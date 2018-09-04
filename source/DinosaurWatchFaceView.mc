using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

//Arrays: 
//TODO make the images slightly bigger ~~200px should do it and store these arrays in a JSON to free up space
//const Body0 = [[0x2100000, 0x2206000, 0x230c000, 0x2400018, 0x2506018, 0x260c018, 0x2706030, 0x280c030, 0x2912030, 0x2a06048, 0x2b0c048, 0x2c12048], [0x2e00000, 0x2f06000, 0x300c000, 0x3100018, 0x3206018, 0x330c018, 0x3406030, 0x350c030, 0x3612030, 0x3706048, 0x380c048, 0x3912048], [0x3c00000, 0x3d06000, 0x3e0c000, 0x3f00018, 0x4006018, 0x410c018, 0x4206030, 0x430c030, 0x4412030, 0x4506048, 0x460c048, 0x4712048], [0x4b06000, 0x4c0c000, 0x4d06018, 0x4e0c018, 0x4f06030, 0x500c030, 0x5112030, 0x5200048, 0x5306048, 0x540c048, 0x5512048], [0x5a06000, 0x5b0c000, 0x5c06018, 0x5d0c018, 0x5e06030, 0x5f0c030, 0x6000048, 0x6106048, 0x620c048, 0x6312048], [0x6906000, 0x6a0c000, 0x6b12000, 0x6c06018, 0x6d0c018, 0x6e00030, 0x6f06030, 0x700c030, 0x7100048, 0x7206048, 0x730c048, 0x7412048], [0x7b06000, 0x7c0c000, 0x7d12000, 0x7e06018, 0x7f0c018, 0x8000030, 0x8106030, 0x820c030, 0x8300048, 0x8406048, 0x850c048, 0x8612048], [0x8e06000, 0x8f0c000, 0x9012000, 0x9106018, 0x920c018, 0x9312018, 0x9400030, 0x9506030, 0x960c030, 0x9700048, 0x9806048, 0x990c048, 0x9a12048], [0xa306000, 0xa40c000, 0xa512000, 0xa606018, 0xa70c018, 0xa812018, 0xa900030, 0xaa06030, 0xab0c030, 0xac00048, 0xad06048, 0xae0c048], [0xb806000, 0xb90c000, 0xba12000, 0xbb06018, 0xbc0c018, 0xbd12018, 0xbe00030, 0xbf06030, 0xc00c030, 0xc100048, 0xc206048, 0xc30c048], [0xce06000, 0xcf0c000, 0xd012000, 0xd106018, 0xd20c018, 0xd312018, 0xd400030, 0xd506030, 0xd60c030, 0xd700048, 0xd806048, 0xd90c048], [0xe50c000, 0xe612000, 0xe700018, 0xe806018, 0xe90c018, 0xea12018, 0xeb00030, 0xec06030, 0xed0c030, 0xee00048, 0xef06048, 0xf00c048], [0xfd0c000, 0xfe12000, 0xff00018, 0x10006018, 0x1010c018, 0x10212018, 0x10318018, 0x10400030, 0x10506030, 0x1060c030, 0x10700048, 0x10806048, 0x1090c048], [0x1170c000, 0x11812000, 0x11900018, 0x11a06018, 0x11b0c018, 0x11c12018, 0x11d18018, 0x11e00030, 0x11f06030, 0x1200c030, 0x12112030, 0x12200048, 0x12306048, 0x1240c048], [0x1330c000, 0x13412000, 0x13500018, 0x13606018, 0x1370c018, 0x13812018, 0x13918018, 0x13a00030, 0x13b06030, 0x13c0c030, 0x13d12030, 0x13e00048, 0x13f06048]];
//const Body90 = [[0x210c000, 0x2212000, 0x2300018, 0x2406018, 0x250c018, 0x2612018, 0x2718018, 0x2800030, 0x2906030, 0x2a0c030, 0x2b12030, 0x2c18030, 0x2d00048, 0x2e06048], [0x3f0c000, 0x4012000, 0x4100018, 0x4206018, 0x430c018, 0x4412018, 0x4500030, 0x4606030, 0x470c030, 0x4812030, 0x4918030, 0x4a00048, 0x4b06048], [0x5d12000, 0x5e00018, 0x5f06018, 0x600c018, 0x6112018, 0x6200030, 0x6306030, 0x640c030, 0x6512030, 0x6618030, 0x6700048, 0x6806048], [0x7b00000, 0x7c00018, 0x7d06018, 0x7e0c018, 0x7f12018, 0x8000030, 0x8106030, 0x820c030, 0x8312030, 0x8418030, 0x8500048, 0x8606048], [0x9a00000, 0x9b00018, 0x9c06018, 0x9d0c018, 0x9e12018, 0x9f00030, 0xa006030, 0xa10c030, 0xa212030, 0xa300048, 0xa406048], [0xb900000, 0xba06000, 0xbb00018, 0xbc06018, 0xbd0c018, 0xbe12018, 0xbf00030, 0xc006030, 0xc10c030, 0xc212030, 0xc300048, 0xc406048, 0xc512048], [0xdb00000, 0xdc06000, 0xdd00018, 0xde06018, 0xdf0c018, 0xe012018, 0xe100030, 0xe206030, 0xe30c030, 0xe412030, 0xe500048, 0xe612048], [0xfd00000, 0xfe06000, 0xff00018, 0x10006018, 0x1010c018, 0x10212018, 0x10300030, 0x10406030, 0x1050c030, 0x10612030, 0x10700048, 0x10812048], [0x12000000, 0x12106000, 0x12200018, 0x12306018, 0x1240c018, 0x12512018, 0x12600030, 0x12706030, 0x1280c030, 0x12912030, 0x12a0c048, 0x12b12048], [0x14400000, 0x14506000, 0x14600018, 0x14706018, 0x1480c018, 0x14912018, 0x14a00030, 0x14b06030, 0x14c0c030, 0x14d12030, 0x14e0c048, 0x14f12048], [0x16900000, 0x16a06000, 0x16b0c000, 0x16c00018, 0x16d06018, 0x16e0c018, 0x16f12018, 0x17000030, 0x17106030, 0x1720c030, 0x17312030, 0x1740c048, 0x17512048], [0x19000000, 0x19106000, 0x1920c000, 0x19300018, 0x19406018, 0x1950c018, 0x19600030, 0x19706030, 0x1980c030, 0x19912030, 0x19a0c048, 0x19b12048], [0x1b700000, 0x1b806000, 0x1b90c000, 0x1ba00018, 0x1bb06018, 0x1bc0c018, 0x1bd00030, 0x1be06030, 0x1bf0c030, 0x1c012030, 0x1c10c048, 0x1c212048, 0x1c30c060], [0x1e000000, 0x1e106000, 0x1e20c000, 0x1e300018, 0x1e406018, 0x1e50c018, 0x1e600030, 0x1e706030, 0x1e80c030, 0x1e912030, 0x1ea0c048, 0x1eb12048, 0x1ec0c060], [0x20a00000, 0x20b06000, 0x20c0c000, 0x20d00018, 0x20e06018, 0x20f0c018, 0x21006030, 0x2110c030, 0x21212030, 0x21306048, 0x2140c048, 0x21512048, 0x2160c060]];
//const Body180 = [[0x2100000, 0x2206000, 0x230c000, 0x2400018, 0x2506018, 0x260c018, 0x2706030, 0x280c030, 0x2912030, 0x2a06048, 0x2b0c048, 0x2c12048, 0x2d0c060], [0x4d00000, 0x4e06000, 0x4f0c000, 0x5000018, 0x5106018, 0x520c018, 0x5306030, 0x540c030, 0x5512030, 0x5606048, 0x570c048, 0x5812048, 0x5906060, 0x5a0c060], [0x7b00000, 0x7c06000, 0x7d0c000, 0x7e12000, 0x7f00018, 0x8006018, 0x810c018, 0x8206030, 0x830c030, 0x8412030, 0x8506048, 0x860c048, 0x8712048, 0x8806060], [0xaa00000, 0xab06000, 0xac0c000, 0xad12000, 0xae00018, 0xaf06018, 0xb00c018, 0xb112018, 0xb206030, 0xb30c030, 0xb412030, 0xb506048, 0xb60c048, 0xb712048, 0xb806060], [0xdb00000, 0xdc06000, 0xdd0c000, 0xde12000, 0xdf00018, 0xe006018, 0xe10c018, 0xe212018, 0xe306030, 0xe40c030, 0xe506048, 0xe60c048], [0x10a00000, 0x10b06000, 0x10c0c000, 0x10d12000, 0x10e00018, 0x10f06018, 0x1100c018, 0x11112018, 0x11206030, 0x1130c030, 0x11406048, 0x1150c048], [0x13a00000, 0x13b06000, 0x13c0c000, 0x13d12000, 0x13e06018, 0x13f0c018, 0x14012018, 0x14106030, 0x1420c030, 0x14300048, 0x14406048, 0x1450c048], [0x16b06000, 0x16c0c000, 0x16d12000, 0x16e06018, 0x16f0c018, 0x17012018, 0x17106030, 0x1720c030, 0x17312030, 0x17400048, 0x17506048, 0x1760c048], [0x19d06000, 0x19e0c000, 0x19f12000, 0x1a006018, 0x1a10c018, 0x1a212018, 0x1a306030, 0x1a40c030, 0x1a512030, 0x1a600048, 0x1a706048, 0x1a80c048], [0x1d006000, 0x1d10c000, 0x1d212000, 0x1d306018, 0x1d40c018, 0x1d512018, 0x1d600030, 0x1d706030, 0x1d80c030, 0x1d912030, 0x1da00048, 0x1db06048, 0x1dc0c048], [0x20506000, 0x2060c000, 0x20712000, 0x20806018, 0x2090c018, 0x20a12018, 0x20b00030, 0x20c06030, 0x20d0c030, 0x20e12030, 0x20f00048, 0x21006048, 0x2110c048], [0x23b06000, 0x23c0c000, 0x23d12000, 0x23e06018, 0x23f0c018, 0x24012018, 0x24100030, 0x24206030, 0x2430c030, 0x24412030, 0x24500048, 0x24606048, 0x2470c048], [0x27206000, 0x2730c000, 0x27412000, 0x27506018, 0x2760c018, 0x27712018, 0x27818018, 0x27900030, 0x27a06030, 0x27b0c030, 0x27c12030, 0x27d18030, 0x27e00048, 0x27f06048], [0x2ab0c000, 0x2ac12000, 0x2ad06018, 0x2ae0c018, 0x2af12018, 0x2b000030, 0x2b106030, 0x2b20c030, 0x2b312030, 0x2b418030, 0x2b500048, 0x2b606048], [0x2e30c000, 0x2e412000, 0x2e506018, 0x2e60c018, 0x2e712018, 0x2e800030, 0x2e906030, 0x2ea0c030, 0x2eb12030, 0x2ec18030, 0x2ed00048, 0x2ee06048]];
//const Body270 = [[0x210c000, 0x2212000, 0x2300018, 0x2406018, 0x250c018, 0x2612018, 0x2700030, 0x2806030, 0x290c030, 0x2a12030, 0x2b00048, 0x2c06048], [0x5b0c000, 0x5c12000, 0x5d00018, 0x5e06018, 0x5f0c018, 0x6012018, 0x6100030, 0x6206030, 0x630c030, 0x6412030, 0x6500048, 0x6606048], [0x960c000, 0x9712000, 0x9800018, 0x9906018, 0x9a0c018, 0x9b12018, 0x9c00030, 0x9d06030, 0x9e0c030, 0x9f12030, 0xa000048, 0xa106048, 0xa212048], [0xd30c000, 0xd412000, 0xd500018, 0xd606018, 0xd70c018, 0xd812018, 0xd900030, 0xda06030, 0xdb0c030, 0xdc12030, 0xdd00048, 0xde06048, 0xdf0c048, 0xe012048], [0x11212000, 0x11300018, 0x11406018, 0x1150c018, 0x11612018, 0x11700030, 0x11806030, 0x1190c030, 0x11a12030, 0x11b0c048, 0x11c12048], [0x14f12000, 0x15000018, 0x15106018, 0x1520c018, 0x15312018, 0x15400030, 0x15506030, 0x1560c030, 0x15712030, 0x1580c048, 0x15912048], [0x18d00000, 0x18e12000, 0x18f00018, 0x19006018, 0x1910c018, 0x19212018, 0x19300030, 0x19406030, 0x1950c030, 0x19612030, 0x1970c048, 0x19812048], [0x1cd00000, 0x1ce00018, 0x1cf06018, 0x1d00c018, 0x1d112018, 0x1d200030, 0x1d306030, 0x1d40c030, 0x1d512030, 0x1d60c048, 0x1d712048], [0x20d00000, 0x20e06000, 0x20f00018, 0x21006018, 0x2110c018, 0x21212018, 0x21300030, 0x21406030, 0x2150c030, 0x21612030, 0x2170c048, 0x21812048], [0x24f00000, 0x25006000, 0x25100018, 0x25206018, 0x2530c018, 0x25412018, 0x25500030, 0x25606030, 0x2570c030, 0x25812030, 0x25906048, 0x25a0c048, 0x25b12048], [0x29300000, 0x29406000, 0x29500018, 0x29606018, 0x2970c018, 0x29812018, 0x29900030, 0x29a06030, 0x29b0c030, 0x29c12030, 0x29d06048, 0x29e0c048, 0x29f12048], [0x2d806000, 0x2d900018, 0x2da06018, 0x2db0c018, 0x2dc12018, 0x2dd00030, 0x2de06030, 0x2df0c030, 0x2e012030, 0x2e106048, 0x2e20c048, 0x2e312048], [0x31d00000, 0x31e06000, 0x31f00018, 0x32006018, 0x3210c018, 0x32212018, 0x32306030, 0x3240c030, 0x32512030, 0x32606048, 0x3270c048, 0x32812048, 0x3290c060], [0x36400000, 0x36506000, 0x36600018, 0x36706018, 0x3680c018, 0x36906030, 0x36a0c030, 0x36b12030, 0x36c06048, 0x36d0c048, 0x36e12048, 0x36f06060, 0x3700c060], [0x3ac06000, 0x3ad0c000, 0x3ae00018, 0x3af06018, 0x3b00c018, 0x3b106030, 0x3b20c030, 0x3b312030, 0x3b406048, 0x3b50c048, 0x3b612048, 0x3b706060]];
//const Arm0 = [[0x2106018, 0x220c018, 0x2300030, 0x2406030, 0x250c030], [0x2706018, 0x280c018, 0x2900030, 0x2a06030, 0x2b0c030], [0x2e00018, 0x2f06018, 0x300c018, 0x3100030, 0x3206030, 0x330c030], [0x3700018, 0x3806018, 0x390c018, 0x3a00030, 0x3b06030, 0x3c0c030], [0x4100018, 0x4206018, 0x430c018, 0x4406030, 0x450c030], [0x4b00018, 0x4c06018, 0x4d0c018, 0x4e06030, 0x4f0c030], [0x5600018, 0x5706018, 0x580c018, 0x5906030, 0x5a0c030], [0x6206018, 0x630c018, 0x6406030, 0x650c030], [0x6e06018, 0x6f0c018, 0x7006030, 0x710c030], [0x7b06018, 0x7c0c018, 0x7d06030, 0x7e0c030], [0x8906018, 0x8a0c018, 0x8b06030, 0x8c0c030], [0x9806000, 0x9906018, 0x9a0c018, 0x9b06030, 0x9c0c030], [0xa906000, 0xaa06018, 0xab0c018, 0xac06030, 0xad0c030], [0xbb06000, 0xbc06018, 0xbd0c018, 0xbe06030, 0xbf0c030], [0xce06000, 0xcf06018, 0xd00c018, 0xd106030, 0xd20c030]];
//const Arm90 = [[0x2106000, 0x2206018, 0x230c018, 0x2406030, 0x250c030], [0x3606000, 0x370c000, 0x3806018, 0x390c018, 0x3a06030, 0x3b0c030], [0x4d06000, 0x4e0c000, 0x4f06018, 0x500c018, 0x5106030, 0x520c030], [0x650c000, 0x6606018, 0x670c018, 0x6806030, 0x690c030], [0x7d0c000, 0x7e06018, 0x7f0c018, 0x8006030, 0x810c030], [0x960c000, 0x9706018, 0x980c018, 0x9906030, 0x9a0c030], [0xb00c000, 0xb106018, 0xb20c018, 0xb306030, 0xb40c030], [0xcb06018, 0xcc0c018, 0xcd06030, 0xce0c030], [0xe60c018, 0xe706030, 0xe80c030], [0x1010c018, 0x10212018, 0x10306030, 0x1040c030], [0x11e0c018, 0x11f12018, 0x12006030, 0x1210c030], [0x13c0c018, 0x13d12018, 0x13e06030, 0x13f0c030], [0x15b0c018, 0x15c12018, 0x15d06030, 0x15e0c030], [0x17b06018, 0x17c0c018, 0x17d12018, 0x17e06030, 0x17f0c030], [0x19d0c018, 0x19e12018, 0x19f06030, 0x1a00c030]];
//const Arm180 = [[0x210c018, 0x2212018, 0x2306030, 0x240c030, 0x2512030], [0x450c018, 0x4612018, 0x4706030, 0x480c030, 0x4912030], [0x6a06018, 0x6b0c018, 0x6c12018, 0x6d06030, 0x6e0c030, 0x6f12030], [0x910c018, 0x9206030, 0x930c030, 0x9412030], [0xb70c018, 0xb806030, 0xb90c030, 0xba12030], [0xde0c018, 0xdf06030, 0xe00c030, 0xe112030], [0x1060c018, 0x10706030, 0x1080c030, 0x10912030], [0x12f0c018, 0x13006030, 0x1310c030, 0x13212030], [0x1590c018, 0x15a06030, 0x15b0c030, 0x15c12030], [0x1840c018, 0x18506030, 0x1860c030, 0x1870c048], [0x1b00c018, 0x1b106030, 0x1b20c030, 0x1b30c048], [0x1dd0c018, 0x1de06030, 0x1df0c030, 0x1e00c048], [0x20b0c018, 0x20c06030, 0x20d0c030, 0x20e0c048], [0x23a06018, 0x23b0c018, 0x23c06030, 0x23d0c030, 0x23e0c048], [0x26b06018, 0x26c0c018, 0x26d06030, 0x26e0c030, 0x26f0c048]];
//const Arm270 = [[0x2106018, 0x220c018, 0x2306030, 0x240c030, 0x250c048], [0x5406018, 0x550c018, 0x5606030, 0x570c030, 0x580c048], [0x8806018, 0x890c018, 0x8a06030, 0x8b0c030, 0x8c06048, 0x8d0c048], [0xbe06018, 0xbf0c018, 0xc006030, 0xc10c030, 0xc206048, 0xc30c048], [0xf506018, 0xf60c018, 0xf706030, 0xf80c030, 0xf906048], [0x12c06018, 0x12d0c018, 0x12e06030, 0x12f0c030, 0x13006048], [0x16406018, 0x1650c018, 0x16606030, 0x1670c030, 0x16806048], [0x19d06018, 0x19e0c018, 0x19f06030, 0x1a00c030, 0x1a106048], [0x1d706018, 0x1d80c018, 0x1d906030, 0x1da0c030, 0x1db06048], [0x21206018, 0x2130c018, 0x21406030, 0x2150c030], [0x24d06018, 0x24e0c018, 0x24f06030, 0x2500c030], [0x2890c018, 0x28a00030, 0x28b06030, 0x28c0c030], [0x2c60c018, 0x2c700030, 0x2c806030, 0x2c90c030], [0x30406018, 0x3050c018, 0x30600030, 0x30706030, 0x3080c030], [0x34406018, 0x3450c018, 0x34600030, 0x34706030, 0x3480c030]];

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
    var dinoBody, dinoBodyPnk;
    var dinoArm;
    
	var f_body;
	var f_arm;
	var f_bodyPnk;
	var centerpoint;
	var xoff;
	var yoff;
	        
    var secondo;
	
    function initialize() {
        WatchFace.initialize();
        screenShape = System.getDeviceSettings().screenShape;
        fullScreenRefresh = true;
        partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );
        //dinoBody = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dinoBody, :locX=>0, :locY=>0});
       // dinoArm = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dinoArm, :locX=>0, :locY=>0});
        f_body = null;
		f_bodyPnk = null;
       	f_arm = null;
 
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
    
    function onUpdate(dc){
    	var width;
    	var height;
        var screenWidth = dc.getWidth();
        var clockTime = System.getClockTime();
    
    
     // We always want to refresh the full screen when we get a regular onUpdate call.
        fullScreenRefresh = true;

        width = dc.getWidth();
        height = dc.getHeight();

        // Fill the entire background with Black.
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        // Draw the hour hand. Convert it to minutes and compute the angle.
//        hourHandAngle = (((clockTime.hour % 12) * 60) + clockTime.min);
//        hourHandAngle = hourHandAngle / (12 * 60.0);
//        hourHandAngle = hourHandAngle * Math.PI * 2;
//        
//        // Draw the minute hand.
       // minuteHandAngle = (clockTime.min / 60.0) * Math.PI * 2;
		
		
       // dc.drawText(dc.getWidth()/2-48,dc.getHeight()/2, f_body0, secondo.toChar() , Graphics.TEXT_JUSTIFY_CENTER);
//       	for (var i = 0; i < 3; i += 1) {
//       		dc.drawText(dc.getWidth()/2-48+i*24,dc.getHeight()/2, f_body0, (i + 33).toChar() , Graphics.TEXT_JUSTIFY_CENTER);
//       	}
//        for (var i = 0; i < 3; i += 1) {
//       		dc.drawText(dc.getWidth()/2-48+i*24,dc.getHeight()/2 + 24, f_body0, (i + 33 +3).toChar() , Graphics.TEXT_JUSTIFY_CENTER);
//       	}
//       	for (var i = 0; i < 3; i += 1) {
//       		dc.drawText(dc.getWidth()/2-48+i*24,dc.getHeight()/2 + 24*2, f_body0, (i + 33 +6).toChar() , Graphics.TEXT_JUSTIFY_CENTER);
//       	}
       // dc.drawText(dc.getWidth()/2-24,dc.getHeight()/2, f_body0, secondo.toChar() + 10 , Graphics.TEXT_JUSTIFY_CENTER);
       // dc.drawText(dc.getWidth()/2,dc.getHeight()/2, f_body180, secondo.toChar() , Graphics.TEXT_JUSTIFY_CENTER);
       // dc.drawText(dc.getWidth()/2+48,dc.getHeight()/2, f_body306, secondo.toChar() , Graphics.TEXT_JUSTIFY_CENTER);
       // dc.drawText(dc.getWidth()/2+24,dc.getHeight()/2, f_arm0, secondo.toChar() , Graphics.TEXT_JUSTIFY_CENTER);
        //draw the dinosaur
       // dinoBody.draw(dc);
		//dinoArm.draw(dc);
		
		
		//draw the dino body
	   dc.setColor(0xAAFF00, Graphics.COLOR_BLACK);
	   var min = clockTime.min;
	   var hr = clockTime.hour;
	    f_body = null;
	   if (min < 15){
	   	   	f_body = loadResource(Rez.Fonts.fntBody0);  
	   		var arr = WatchUi.loadResource(Rez.JsonData.Body0);	  
	   		dinoBody = arr[min];	   	   	
	   } else if (min >=15 && min < 30){
	    	f_body = loadResource(Rez.Fonts.fntBody90);	  
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Body15);
	   		dinoBody = arr[min - 15];	
	   } else if (min >=30 && min < 45){
	   		f_body = loadResource(Rez.Fonts.fntBody180);
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Body30);
	   		dinoBody = arr[min - 30];	 
 	   } else if (min >=45 && min < 60){
 	        f_body = loadResource(Rez.Fonts.fntBody270);
 	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Body45);
	   		dinoBody = arr[min - 45];	  	   
	   }
	   
	   

		//System.println(dinoBody);
       for(var i = 0; i < dinoBody.size(); i++) {
       
	        var packed_value = dinoBody[i];
	
	        var ypos = packed_value & 1023;
	        packed_value >>= 10;
	        var xpos = packed_value & 1023;
	        packed_value >>= 10;
	        var char = packed_value;
	        dc.drawText(xpos + dc.getWidth()/8,ypos+ dc.getHeight()/8,f_body,char.toChar(),Graphics.TEXT_JUSTIFY_CENTER);
	       
	   }
	   
	   f_body = null;
	   
	   
	   dc.setColor(0xFF55FF, Graphics.COLOR_TRANSPARENT);

	   if (min < 15){
	   	   
			f_bodyPnk = loadResource(Rez.Fonts.fntBodyPnk0); 
	   		var arr = WatchUi.loadResource(Rez.JsonData.BodyPnk0);
	   		dinoBodyPnk = arr[min];
	   } else if (min >=15 && min < 30){
	    	
	    	f_bodyPnk = loadResource(Rez.Fonts.fntBodyPnk90); 
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.BodyPnk15);
	   		dinoBodyPnk = arr[min - 15]; 
	   } else if (min >=30 && min < 45){
	   	
	   		f_bodyPnk = loadResource(Rez.Fonts.fntBodyPnk180); 
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.BodyPnk30);
	   		dinoBodyPnk = arr[min - 30];   
 	   } else if (min >=45 && min < 60){
 	     
 	        f_bodyPnk = loadResource(Rez.Fonts.fntBodyPnk270); 
 	   	   	var arr = WatchUi.loadResource(Rez.JsonData.BodyPnk45);
	   		dinoBodyPnk = arr[min - 45];
	   }
	   
	   for(var i = 0; i < dinoBodyPnk.size(); i++) {
       
	        var packed_value = dinoBodyPnk[i];
	
	        var ypos = packed_value & 1023;
	        packed_value >>= 10;
	        var xpos = packed_value & 1023;
	        packed_value >>= 10;
	        var char = packed_value;
	        dc.drawText(xpos + dc.getWidth()/8,ypos+ dc.getHeight()/8,f_bodyPnk,char.toChar(),Graphics.TEXT_JUSTIFY_CENTER);
	       
	   }
	   
	   f_bodyPnk = null;
	    
	   //draw the dino arm
	   dc.setColor(0x00FF00, Graphics.COLOR_TRANSPARENT);
	  // System.println(hr);

	   if (hr < 15){
	   	   	f_arm = loadResource(Rez.Fonts.fntArm90); 
	   		var arr = WatchUi.loadResource(Rez.JsonData.Arm15);	   		
	   		dinoArm = arr[hr];
	   } else if (hr >=15 && hr < 30){
	    	f_arm = loadResource(Rez.Fonts.fntArm180);	  
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Arm30);
	   		dinoArm = arr[hr - 15];	 
	   } else if (hr >=30 && hr < 45){
	   		f_arm = loadResource(Rez.Fonts.fntArm270);
	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Arm45);
	   		dinoArm = arr[hr - 30];	   
 	   } else if (hr >=45 && hr < 60){
 	        f_arm = loadResource(Rez.Fonts.fntArm0);
 	   	   	var arr = WatchUi.loadResource(Rez.JsonData.Arm0);
	   		dinoArm = arr[hr - 45];	  	   
	   }
		//System.println(dinoBody);
       for(var i = 0; i < dinoArm.size(); i++) {
       
	        var packed_value = dinoArm[i];
	
	        var ypos = packed_value & 1023;
	        packed_value >>= 10;
	        var xpos = packed_value & 1023;
	        packed_value >>= 10;
	        var char = packed_value;
	        dc.drawText(xpos + dc.getWidth()/8,ypos+ dc.getHeight()/8,f_arm,char.toChar(),Graphics.TEXT_JUSTIFY_CENTER);
	   }
	   
		 f_arm = null;
		 
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

