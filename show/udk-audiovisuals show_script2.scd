//script to show pieces/sketches /f0
//stop with cmd+.

(
s.waitForBoot{

	//--settings
	var path= "~/udk/*";				//folder with pieces to run
	var defaultTime= 20;				//duration per piece in seconds
	//var bounds= Rect(500, 60, 800, 800);	//document position and size
	var fixedTimes= [					//array of filenames that needs a fixed duration
		"andre_1001.scd" -> 240			//filename, seconds
	];

	//--loop
	Task({
		var time;
		var files= path.standardizePath.pathMatch.scramble;
		files.postln;
		inf.do{|i|

			//--load
			var doc= Document.open(files.wrapAt(i));
			//doc.bounds= bounds;
			(Date.localtime.asString+doc.name).postln;
			0.5.wait;
			doc.selectRange(0, doc.string.size);
			0.5.wait;

			//--run
			doc.string.interpret;

			//--time
			time= defaultTime;
			fixedTimes.do{|x|
				doc.path.basename;
				if(x.key==doc.path.basename, {
					time= x.value;
				});
			};
			("time"+time).postln;
			time.wait;

			//--stop
			thisProcess.stop;
			Window.allWindows.reject{|x| x.name.contains(" server")}.do{|x| x.close};
			doc.close;
			0.5.wait;
		}
	}).play(AppClock);
};
)
