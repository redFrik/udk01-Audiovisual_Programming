//udk may-jul 2009 / fredrikolofsson.com
//090625


//----------------------
/*
the Rect class...
Rect(x, y, width, height)

a= Rect(100, 300, 640, 480)
a+10
a+Rect(1, 2, 30, 40)
*/


(
var win, usr, width= 400, height= 400;
win= Window("rect0", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color(0.4, 0.1, 0.6);

usr.drawFunc= {
	Pen.strokeColor= Color.white;
	Pen.strokeRect(Rect(10, 20, 30, 40));
};

win.front;
)



//iteration
(
var win, usr, width= 400, height= 400;
win= Window("rect1", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color(0.4, 0.1, 0.6);

usr.drawFunc= {
	//40 rectangles at random positions
	40.do{
		Pen.strokeColor= Color.white;
		Pen.strokeRect(Rect(width.rand, height.rand, 30, 40));
	};
};

win.front;
)





//modulo
(
var win, usr, width= 400, height= 400;
win= Window("rect2", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color(0.4, 0.1, 0.6);

usr.drawFunc= {
	//45 rectangles evenly spaces
	45.do{|index|
		Pen.strokeColor= Color.white;
		Pen.strokeRect(Rect(index%10*33, index.div(10)*23, 30, 20));
	};
};

win.front;
)


//combination of modulo (%) and integer division (.div)
//very common to use for grids

//if modulo 4 then the first number never goes above 3
3%4
4%4
5%4
6%4
//now try with %5

//integer division
3.div(4)
4.div(4)
5.div(4)
6.div(4)
//now try with .div(5)

//compare with standard (float) division
3/4
4/4
5/4
6/4




(
var win, usr, width= 400, height= 400;
win= Window("rect3", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color(0.4, 0.1, 0.6);

usr.drawFunc= {
	64.do{|index|
		Pen.strokeColor= Color.white;
		Pen.strokeRect(Rect(index%12*33, index.div(6)*23, 30, 20));

		//64 is total number of rectangles
		//30 is rectangle width
		//20 is rectangle height
		//33 is rectangle spacing per row (x)
		//23 is rectangle spacing per column (y)
		//12 is number of rectangles per row
		//6 is number of rectangles per column
	};
};

win.front;
)
//try changing all these numbers and insert modulo here and there



//fill vs stroke
(
var win, usr, width= 400, height= 400;
win= Window("rect4", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color(0.4, 0.1, 0.6);

usr.drawFunc= {
	64.do{|index|
		if(index%3==0, {		//stroke every third
			Pen.strokeColor= Color.white;
			Pen.strokeRect(Rect(index%12*33, index.div(6)*23, 30, 20));
		}, {		//fill the rest
			Pen.fillColor= Color.white;
			Pen.fillRect(Rect(index%12*33, index.div(6)*23, 30, 20));
		});
	};
};

win.front;
)




//--------------------

//to use the scope, first click ->default and then boot on internal server window
s.scope

//pulse/square waves
(
	SynthDef("pulse0", {
		var snd;
		snd= LFPulse.ar(800, 0, 0.2) * LFPulse.ar(2, 0, 0.8);
		Out.ar(0, Pan2.ar(snd, 0));
	}).send(s);
)
a= Synth("pulse0")
a.free


//with a low-pass filter (LPF - only lets low frequencies pass)
//sound gets smoother and less bright
(
	SynthDef("pulse1", {
		var snd, filter;
		snd= LFPulse.ar(800, 0, 0.2) * LFPulse.ar(2, 0, 0.8);
		filter= LPF.ar(snd, 1000);
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);
)
a= Synth("pulse1")
a.free

//using another pulse to control filter frequency (cutoff freq)
(
	SynthDef("pulse2", {
		var snd, filter;
		snd= LFPulse.ar(400, 0, 0.2) * LFPulse.ar(0.5, 0, 0.8);
		filter= LPF.ar(snd, LFPulse.ar(3)*2700+600);//low-pass filter
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);
)
a= Synth("pulse2")
a.free


//another type of filter and also controlling snd freq with a pulse
(
	SynthDef("pulse3", {
		var snd, filter;
		snd= LFPulse.ar(LFPulse.ar(8)*200+400, 0, 0.2) * LFPulse.ar(0.5, 0, 0.8);
		filter= MoogFF.ar(snd, LFPulse.ar(3)*2700+600);//low-pass filter
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);
)
a= Synth("pulse3")
a.free



//many more pulses as controllers
(
	SynthDef("pulse4", {
		var snd, filter, gater, freaker, higher;
		gater= LFPulse.ar(5)*0.5+1;
		freaker= LFPulse.ar(0.25)*20+8;
		higher= LFPulse.ar(0.2)*200+300;
		snd= LFPulse.ar(LFPulse.ar(freaker)*higher+400, 0, 0.2) * LFPulse.ar(gater, 0, 0.8);
		filter= MoogFF.ar(snd, LFPulse.ar(3)*2700+600);//low-pass filter
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);
)
a= Synth("pulse4")
a.free



//adding 3 arguments
(
	SynthDef("pulse5", {|baseFreq= 400, baseRate= 20, width= 0.2|
		var snd, filter, gater, freaker, higher;
		gater= LFPulse.ar(5)*0.5+1;
		freaker= LFPulse.ar(0.25)*baseRate+8;
		higher= LFPulse.ar(0.2)*200+300;
		snd= LFPulse.ar(LFPulse.ar(freaker)*higher+baseFreq, 0, width) * LFPulse.ar(gater, 0, 0.8);
		filter= MoogFF.ar(snd, LFPulse.ar(3)*2700+600);
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);
)
a= Synth("pulse5")
a.set(\baseFreq, 100)
a.set(\baseFreq, 200)
a.set(\baseFreq, 300)
a.set(\width, 0.8)
a.set(\width, 0.1)
a.set(\baseRate, 12)
a.set(\baseRate, 70)
a.free





//---------------------------
(
var win, usr, width= 500, height= 400, cnt= 0;
win= Window("more rects0", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(0.5);
			Pen.strokeRect(Rect(x*10, y*7, 6, 5));
		};
	};
};
win.front;
)


//
(
var win, usr, width= 500, height= 400, cnt= 0;
win= Window("more rects1", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(x%50/50);
			Pen.strokeRect(Rect(x*10, y*7, 6, 5));
		};
	};
};
win.front;
)


(
var win, usr, width= 500, height= 400, cnt= 0;
win= Window("more rects2", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(cnt/150);
			Pen.strokeRect(Rect(x*10+cnt%width, y*7, 6, 5));
		};
	};
	cnt= cnt+1%150;	//wrap conter 0-149
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)



//--
(
var win, usr, width= 500, height= 400, cnt= 0;
win= Window("structure0", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(cnt/150);
			Pen.strokeRect(Rect(x*10+cnt%width, y+x*7, 6*cnt%8, 50));
		};
	};
	cnt= cnt+1%150;	//wrap conter 0-149
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)


//draw 2 rectangles at the same time.  one filled and one stroked
~haha= 30;		//use environmental variable to change on the fly
~spread= 10;	//no need to declare but needs to initialise to some values

(
var win, usr, width= 500, height= 400, cnt= 0;
win= Window("structure1", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(cnt%150/150, 0.5);
			Pen.strokeRect(Rect(x*10+cnt%width, y+x*7, 7*cnt%8, 50));
			Pen.fillColor= Color.grey(1-(cnt%150/150), 0.5);
			Pen.fillRect(Rect(x*~spread+cnt%width, y+x*7, 7*cnt%~haha+10, 25));
		};
	};
	cnt= cnt+1%300;	//wrap conter 0-149
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)

~haha= 100
~spread= 100
~spread= -10
~haha= 900




//-------------------------
//sound+video -> a little a/v composition


//--initialisation
(
	//create a synthdef
	SynthDef("pulsesound0", {|freq= 500, amp= 0.5, filterFreq= 600, freqMax= 100|
		var snd, filter, freqControl;
		freqControl= LFPulse.ar(6)*freqMax;//0 or 100
		snd= LFPulse.ar(freq+freqControl, 0, 0.7);
		filter= MoogFF.ar(snd, filterFreq);
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);

	//prepare some variables
	~haha= 50;
	~spread= 10;
)

//--main code
(
var win, usr, width= 500, height= 400, cnt= 0, syn;
win= Window("soundstructure0", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
syn= Synth("pulsesound0");
usr.drawFunc= {
	50.do{|x|
		20.do{|y|
			Pen.strokeColor= Color.grey(cnt%150/150, 0.5);
			Pen.strokeRect(Rect(x*10+cnt%width, y+x*7, 7*cnt%8, 50));
			Pen.fillColor= Color.grey(1-(cnt%150/150), 0.5);
			Pen.fillRect(Rect(x*~spread+cnt%width, y+x*7, 7*cnt%~haha+10, 25));
		};
	};
	syn.set(\freqMax, cnt);
	syn.set(\filterFreq, ~haha*10+100);
	syn.set(\freq, ~spread*30);
	cnt= cnt+1%300;	//wrap conter 0-299
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)

~haha= 200
~spread= 30
~haha= 30
~spread= 300
~haha= 580
~spread= 600
~haha= 85
~spread= 40





//-------------------------

(	//--initialisation
	//create a synthdef
	SynthDef("pulsesound1", {|freq= 500, amp= 0.5, filterFreq= 600, freqMax= 100|
		var snd, filter, freqControl;
		freqControl= LFPulse.ar(6)+LFPulse.ar(5)*freqMax;//0 or 200
		snd= LFPulse.ar(freq+freqControl, 0, 0.6);
		filter= MoogFF.ar(snd, filterFreq)*amp;
		Out.ar(0, Pan2.ar(filter, 0));
	}).send(s);

	//prepare some variables
	~haha= 50;
	~spread= 10;
	~vol= 0.5;
	~mainFreq= 200;
)

(	//--main code
var win, usr, width= 500, height= 400, cnt= 0, syn;
win= Window("soundstructure1", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
syn= Synth("pulsesound1");
usr.drawFunc= {
	(40*~vol).do{|x|
		42.do{|y|
			Pen.strokeColor= Color.red(cnt%150/150, 0.5);
			Pen.strokeRect(Rect(x*10+cnt%width, y+x*7, 7*cnt%8, 50*~vol));
			Pen.fillColor= Color.grey(1-(cnt%150/150), 0.5);
			Pen.fillRect(Rect(x*~spread+cnt%width, y+x*7, 7*cnt%~haha+10, 25*~vol));
		};
	};
	syn.set(\freqMax, ~haha);
	syn.set(\filterFreq, cnt.fold(0, ~mainFreq)*10+100);
	syn.set(\freq, ~mainFreq*(~vol+0.5));
	syn.set(\amp, ~vol);
	cnt= cnt+1%~mainFreq;	//wrap conter 0-199
};
win.front;

Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)

~vol= 1
~vol= 0.05
~vol= 0.5
~mainFreq= 100
~haha= 110
~spread= 200
~vol= 0.7
