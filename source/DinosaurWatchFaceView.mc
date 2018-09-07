using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

var partialUpdatesAllowed = false;

class DinosaurWatchFaceView extends WatchUi.WatchFace {

    var font;
    var isAwake;
    var screenShape;
    var dndIcon;
    var offscreenBuffer;
    var dateBuffer;
    var curClip;
    var screenCenterPoint;
    var fullScreenRefresh;
	var centerpoint;
	var xoff;
	var yoff;
	
	var m = 14;
	
	var fontArr = [[Rez.Fonts.fntBody0, Rez.Fonts.fntBody90, Rez.Fonts.fntBody180, Rez.Fonts.fntBody270], [Rez.Fonts.fntBodyPnk0, Rez.Fonts.fntBodyPnk90, Rez.Fonts.fntBodyPnk180, Rez.Fonts.fntBodyPnk270], 
			 [Rez.Fonts.fntArm0, Rez.Fonts.fntArm90, Rez.Fonts.fntArm180, Rez.Fonts.fntArm270],  [Rez.Fonts.fntArmO0, Rez.Fonts.fntArmO90, Rez.Fonts.fntArmO180, Rez.Fonts.fntArmO270]];
			  
	var jsonArr = [[Rez.JsonData.Body0, Rez.JsonData.Body15, Rez.JsonData.Body30, Rez.JsonData.Body45], [Rez.JsonData.BodyPnk0, Rez.JsonData.BodyPnk15, Rez.JsonData.BodyPnk30, Rez.JsonData.BodyPnk45], 
			 [Rez.JsonData.Arm0, Rez.JsonData.Arm15, Rez.JsonData.Arm30, Rez.JsonData.Arm45],  [Rez.JsonData.ArmO0, Rez.JsonData.ArmO15, Rez.JsonData.ArmO30, Rez.JsonData.ArmO45]]; 
	
	
	
    function initialize() {
        WatchFace.initialize();
        screenShape = System.getDeviceSettings().screenShape;
        fullScreenRefresh = true;
        partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );

    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        screenCenterPoint = [dc.getWidth()/2, dc.getHeight()/2];
    }

    
    function findCenterpoint(im){
    	var di = im.getDimensions();
    	di[0] = di[0]/2;
    	di[1] = di[1]/2;
    	return di;
    }
    
          // Draws the clock tick marks around the outside edges of the screen.
    function drawHashMarks(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        // Draw hashmarks differently depending on screen geometry.
        if (System.SCREEN_SHAPE_ROUND == screenShape) {
            var sX, sY;
            var eX, eY;
            var outerRad = width / 2;
            var innerRad = outerRad - 10;
            // Loop through each 15 minute block and draw tick marks.
            for (var i = Math.PI / 6; i <= 11 * Math.PI / 6; i += (Math.PI / 3)) {
                // Partially unrolled loop to draw two tickmarks in 15 minute block.
                sY = outerRad + innerRad * Math.sin(i);
                eY = outerRad + outerRad * Math.sin(i);
                sX = outerRad + innerRad * Math.cos(i);
                eX = outerRad + outerRad * Math.cos(i);
                dc.drawLine(sX, sY, eX, eY);
                i += Math.PI / 6;
                sY = outerRad + innerRad * Math.sin(i);
                eY = outerRad + outerRad * Math.sin(i);
                sX = outerRad + innerRad * Math.cos(i);
                eX = outerRad + outerRad * Math.cos(i);
                dc.drawLine(sX, sY, eX, eY);
            }
        } else {
            var coords = [0, width / 4, (3 * width) / 4, width];
            for (var i = 0; i < coords.size(); i += 1) {
                var dx = ((width / 2.0) - coords[i]) / (height / 2.0);
                var upperX = coords[i] + (dx * 10);
                // Draw the upper hash marks.
                dc.fillPolygon([[coords[i] - 1, 2], [upperX - 1, 12], [upperX + 1, 12], [coords[i] + 1, 2]]);
                // Draw the lower hash marks.
                dc.fillPolygon([[coords[i] - 1, height-2], [upperX - 1, height - 12], [upperX + 1, height - 12], [coords[i] + 1, height - 2]]);
            }
        }
    }
    
    function createWatchFace(dc){
        var width;
    	var height;
        var screenWidth = dc.getWidth();
        var clockTime = System.getClockTime();
    	var min = clockTime.min; //prob at 3 min, 28 min
	    var hr = clockTime.hour % 12;

        width = dc.getWidth();
        height = dc.getHeight();

        // Fill the entire background with Black.
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
				
		drawTiling(dc, "min", 0xAAFF00, Graphics.COLOR_BLACK, fontArr[0], jsonArr[0], hr, min);
		
	   	drawTiling(dc, "min", 0xFF55FF, Graphics.COLOR_TRANSPARENT, fontArr[1], jsonArr[1], hr, min);
	   
	   	drawTiling(dc, "hr", Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT, fontArr[3], jsonArr[3], hr, min);

 		drawTiling(dc, "hr", 0x00FF00, Graphics.COLOR_TRANSPARENT, fontArr[2], jsonArr[2], hr, min);
	

		// Draw the clock hash marks
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        drawHashMarks(dc);
        
        // Draw the 3, 6, 9, and 12 hour labels
        var font = Graphics.FONT_MEDIUM;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText((width / 2), 2, font, "12", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(width - 2, (height / 2) - 15, font, "3", Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(width / 2, height - 30, font, "6", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(2, (height / 2) - 15, font, "9", Graphics.TEXT_JUSTIFY_LEFT);
    }
    
    function onUpdate(dc){
     // We always want to refresh the full screen when we get a regular onUpdate call.
        fullScreenRefresh = true;
        
       createWatchFace(dc);
        
    	fullScreenRefresh = false;
    }
 
 
        // Handle the partial update event
    function onPartialUpdate( dc ) {
    	

//    	System.print(m);
//    	createWatchFace(dc);
//    	m += 1;
    	
    }
 
/**
	timeFlg = min or hr type str "min" to calc min
	frontClr = foreground color
	backClr = background color
	centerX = center point of watch X coord
	cetnerY = center of watch Y coord
	strName = string of current file or png being processed
	t = time in hours or minutes
**/
	function drawTiling(dc, timeFlg, frontClr, backClr, fnt, jsn, hr, min) {
		
		dc.setColor(frontClr, backClr);

	   if (timeFlg.equals("min")) {
	   		
	        tileToMin(dc, fnt, jsn, min);
	   }
	   else { 
   			tileToHr(dc, fnt, jsn, hr, min);
	   } 
	
	}
    
    function tileToMin(dc, fnt, jsn, t){   		

			var fObj = null;
			var arrObj = null;
					   
		   if (t < 15){
		   	   	fObj = loadResource(fnt[0]);  
		   		var arr = WatchUi.loadResource(jsn[0]);	  
		   		arrObj = arr[t];	   	   	
		   } else if (t >=15 && t < 30){
				fObj = loadResource(fnt[1]);  
		   		var arr = WatchUi.loadResource(jsn[1]);
		   		arrObj = arr[t - 15];	
		   } else if (t >=30 && t < 45){
				fObj = loadResource(fnt[2]);  
		   		var arr = WatchUi.loadResource(jsn[2]);
		   		arrObj = arr[t - 30];	 
	 	   } else if (t >=45 && t <= 60){
				fObj = loadResource(fnt[3]);  
		   		var arr = WatchUi.loadResource(jsn[3]);
		   		arrObj = arr[t - 45];	  	   
		   } 
		   
		   if (arrObj != null) {
		   		printTile(dc, fObj, arrObj);
		   }
		    
    }
    
    function tileToHr(dc, fnt, jsn, t, min){ 

			var fObj = null;
			var arrObj = null;
			 	 	
			var hrInc =  (t + min / 60.0); 
				hrInc =((t % 3) * 5 + ((hrInc - (hrInc.toNumber().toFloat())) * 5).toNumber()) ; 		
           
	    	if (t < 3){
		   	   	fObj = loadResource(fnt[1]); 
		   		var arr = WatchUi.loadResource(jsn[1]);	   		
		   		arrObj = arr[hrInc];
		   } else if (t >=3 && t < 6){
		    	fObj = loadResource(fnt[2]);	  
		   	   	var arr = WatchUi.loadResource(jsn[2]);
		   		arrObj = arr[hrInc];	 
		   } else if (t >=6 && t < 9){
		   		fObj = loadResource(fnt[3]);
		   	   	var arr = WatchUi.loadResource(jsn[3]);
		   		arrObj = arr[hrInc];	   
	 	   } else if (t >=9 && t <= 12){
	 	        fObj = loadResource(fnt[0]);
	 	   	   	var arr = WatchUi.loadResource(jsn[0]);
		   		arrObj = arr[hrInc];	  	   
		   }
		   
		   if (arrObj != null) {
		   		printTile(dc, fObj, arrObj);
		   }
    }
    
    function printTile(dc, fObj, arrObj) {
           for(var i = 0; i < arrObj.size(); i++) {
		        var packed_value = arrObj[i];		
		        var ypos = packed_value & 2047;
		        packed_value >>= 11;
		        var xpos = packed_value & 2047;
		        packed_value >>= 11;
		        var char = packed_value;
		        
//		        System.print(char + " " + xpos + " " + ypos + " \n");
		        
		        dc.drawText(xpos + dc.getWidth()/8, ypos+ dc.getHeight()/8 - 12, fObj, char.toChar(), Graphics.TEXT_JUSTIFY_CENTER);
		        	

		        
	   		}
    }

    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
}

