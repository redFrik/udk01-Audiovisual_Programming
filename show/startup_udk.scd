//script to show pieces/sketches /f0
//stop with cmd+.
//udk-audiovisuals show_script2

(
Document.listener.bounds_(Rect(300, 5, 565, 250));
Document.listener.font_(Font("Monaco", 12));


s.waitForBoot{

	//--settings
	var path= "~/udk_sc/*";				//folder with pieces to run
	var defaultTime= 60;				//duration per piece in seconds
	var bounds= Rect(500, 60, 800, 800);	//document position and size
	var fixedTimes= [					//array of filenames that needs a fixed duration
		"andre_1001.rtf" -> 240			//filename, seconds
	];
	
	//--loop
	Task({
		var time;
		var files= path.standardizePath.pathMatch.scramble;
		files.printcsAll;
		"".postln; 
		
		inf.do{|i|
			
			//--load
			var doc= Document.open(files.wrapAt(i));
			var string = doc.string;
			var lineStarts = List.new;
			doc.bounds= bounds;
			(Date.localtime.asString+doc.name).postln;
			1.wait;
			doc.selectRange(0, string.size);
			2.wait;
			
			string.do { |char, i| if (char == $\n) { lineStarts.add(i) } };
			// lineStarts.postln;
			
			//--run
			string.interpret;
			doc.selectRange(0, 0);
			
			//--time
			time= defaultTime;
			fixedTimes.do{|x|
				doc.path.basename;
				if(x.key==doc.path.basename, {
					time= x.value;
				});
			};
			("	time: "+time).postln;
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
