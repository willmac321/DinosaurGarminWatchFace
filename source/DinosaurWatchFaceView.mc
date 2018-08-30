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
    var dinoBody;
    var dinoArm;
    
	var f_body;
	var centerpoint;
	var xoff;
	var yoff;
	
	
    function initialize() {
        WatchFace.initialize();
        screenShape = System.getDeviceSettings().screenShape;
        fullScreenRefresh = true;
        partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );
        //dinoBody = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dinoBody, :locX=>0, :locY=>0});
       // dinoArm = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dinoArm, :locX=>0, :locY=>0});
        f_body = null;
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        screenCenterPoint = [dc.getWidth()/2, dc.getHeight()/2];
        //WatchUi.animate( dinoBody, :locX, WatchUi.ANIM_TYPE_LINEAR, 10, dc.getWidth() + 50, 10, null );
       // WatchUi.animate( dinoArm, :locX, WatchUi.ANIM_TYPE_LINEAR, 10, dc.getWidth() + 50, 10, null );
        //dinoArm = new Rez.Drawables.dinoArm();
//        dinoBody.setSize(dc.getWidth(), dc.getHeight());
		

		//Calc the centerpoint of the images
//		var di = findCenterpoint(dinoBody);
//		var diA = findCenterpoint(dinoArm);
		//Then attempt to set picture to centered
		//dinoBody.setLocation(screenCenterPoint[0] - di[0],screenCenterPoint[1] - di[1]);
       // dinoArm.setLocation(screenCenterPoint[0] - diA[0],screenCenterPoint[1]- diA[1]);
       
       f_body = loadResource(Rez.Fonts.fntArm);
       

    }

    
    function findCenterpoint(im){
    	var di = im.getDimensions();
    	di[0] = di[0]/2;
    	di[1] = di[1]/2;
    	return di;
    }
    
    function onUpdate(dc){
    	var width;
    	var height;
        var screenWidth = dc.getWidth();
        var clockTime = System.getClockTime();
        var minuteHandAngle;
        var hourHandAngle;
        var second;
      //  var secondHand;
        var targetDc = null;
    
    
     // We always want to refresh the full screen when we get a regular onUpdate call.
        fullScreenRefresh = true;

//        width = targetDc.getWidth();
//        height = targetDc.getHeight();

        // Fill the entire background with Black.
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        
        // Draw the hour hand. Convert it to minutes and compute the angle.
        hourHandAngle = (((clockTime.hour % 12) * 60) + clockTime.min);
        hourHandAngle = hourHandAngle / (12 * 60.0);
        hourHandAngle = hourHandAngle * Math.PI * 2;
        
        // Draw the minute hand.
        minuteHandAngle = (clockTime.min / 60.0) * Math.PI * 2;
        
        var secondo = 33 + clockTime.sec -1;

        dc.drawText(dc.getWidth()/2,dc.getHeight()/2, f_body, secondo.toChar() , Graphics.TEXT_JUSTIFY_LEFT);
        //draw the dinosaur
       // dinoBody.draw(dc);
		//dinoArm.draw(dc);
        
        
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

