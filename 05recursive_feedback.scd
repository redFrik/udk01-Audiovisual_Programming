//udk may-jul 2009 / fredrikolofsson.com
//090709


//----------------------

"~/D*".pathMatch;	//home directory - all files and folders beginning with D
"sounds/*".pathMatch.scramble; //sounds directory inside sc folder

[1, 2, 3, 4, 5].scramble	//random order
[1, 2, 3, 4, 5].choose		//pick one at random
[10, 1, 2, 3, 4, 5].sort

[1, 2, 3, 4, 5]+10				//math operations on arrays
[1, 2, 3, 4, 5].round(4)
[1, 2, 3, 4, 5]/0.01

[1, 2, 3]*[10, 20, 30]



//----------------------
s.boot

//--record sound as a soundfile
(
SynthDef(\testrec, {
	var src= RLPF.ar(WhiteNoise.ar(0.5));
	Out.ar(0, Pan2.ar(src));
}).send(s);
)
a= Synth(\testrec)	//start test sound to record

//now press 'prepare rec' in the localhost server window
//then 'record' and 'stop'
//your file will end up in ~/Music/SuperCollider Recordings
a.free	//stop the test sound


//or do it programmatically from the language
s.prepareForRecord
a= Synth(\testrec)	//start test sound to record
s.record
s.stopRecording
a.free

//or use a routine to start/stop rec with a specific length
(
Routine({
	s.prepareForRecord;	//prepare the file
	1.wait;
	a= Synth(\testrec);	//start the sound
	s.record;						//start the recording
	4.wait;						//record 4 seconds long
	s.stopRecording;			//stop recording
	a.free;
}).play;
)

//look in ~/Music/SuperCollider Recordings for your recorded files




//----------------------

//--first we look at Pen.scale, Pen.rotate, Pen.translate
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("scaleRotateTranslate", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);//offset or shift whole coordinate system
	Pen.scale(0.75, 0.75);	//scale 75% width and height
	Pen.rotate(0.5*pi);		//between 0 and 2pi (here 0.5*pi is 90degree rotation)
	Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 50, 30));
};
win.front;
)



//--recursion
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursive", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|i|
	if(i>0, {	//all recursive functions should have a stop condition
		Pen.scale(0.95, 0.95);	//scale 95% width and height
		Pen.rotate(0.05*pi);		//between 0 and 2pi
		Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 150, 130));
		r.value(i-1);	//here we call r itself
	});
};
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);//offset or shift whole coordinate system
	r.value(100);		//call recursive function with argument 100
};
win.front;
)



//--recursion2
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursive2", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|i|
	if(i>0, {	//all recursive functions should have a stop condition
		Pen.scale(0.9, 0.95);
		Pen.rotate(0.05*pi);
		if(i%2==0, {		//seperate even and odd i using modulo
			Pen.fillColor= Color.blue;
		}, {
			Pen.fillColor= Color.red;
		});
		Pen.fillOval(Rect.aboutPoint(Point(0, 0), 200, 180));
		r.value(i-1);	//here we call r itself
	});
};
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);//offset or shift whole coordinate system
	r.value(100);
};
win.front;
)


// % means modulo

0%2	//	= 0
1%2	// = 1
2%2	// = 0
3%2	// = 1
4%2	// = 0
5%2	// = 1

0%3	// = 0
1%3	// = 1
2%3	// = 2
3%3	// = 0
4%3	// = 1
5%3	// = 2



//--recursion3
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursive3", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|i|
	if(i>0, {	//all recursive functions should have a stop condition
		Pen.scale(0.98, 0.98);
		Pen.rotate(0.01*2pi);
		//--do 1 of 3 different things for each level/depth
		if(i%3==0, {
			Pen.fillColor= Color.blue(0.5, 1-(i/100));
			Pen.fillOval(Rect.aboutPoint(Point(0, 0), 200, 180));
		});
		if(i%3==1, {
			Pen.strokeColor= Color.red;
			Pen.strokeRect(Rect.aboutPoint(Point(100, 0), 200, 180));
		});
		if(i%3==2, {
			Pen.strokeColor= Color.green;
			Pen.line(Point(0, 0), Point(330, 330));
			Pen.stroke;
		});
		r.value(i-1);	//here we call r itself
	});
};
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	r.value(100);
};
win.front;
)



//--recursion4 - with animation
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursive4", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|i|
	if(i>0, {	//all recursive functions should have a stop condition
		Pen.scale(0.99, 0.99);
		Pen.rotate(sin(cnt*0.001));
		//only draw something every second level/depth
		if(i%4==0, {
			Pen.fillColor= Color.white;
			Pen.fillOval(Rect.aboutPoint(Point(0, 0), 250, 230));
		});
		if(i%4==2, {
			Pen.fillColor= Color.black;
			Pen.fillOval(Rect.aboutPoint(Point(0, 0), 250, 230));
		});
		r.value(i-1);	//here we call r itself
	});
};
usr.drawFunc= {
	Pen.strokeColor= Color.black;
	Pen.translate(width*0.5, height*0.5);
	r.value(100);
	cnt= cnt+1;
};
Routine({while({win.isClosed.not}, {usr.refresh; (1/25).wait})}).play(AppClock);
win.front;
)



//--recursion5 - simple example again
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursion5", Rect(100, 400, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.grey;
r= {|index|
	if(index>0, {
		Pen.fillColor= Color.red(1, 0.7);
		Pen.fillOval(Rect.aboutPoint(Point(0, 0), 50, 50));
		Pen.rotate(sin(cnt*0.1));
		Pen.translate(40, 40);
		Pen.scale(0.9, 0.9);
		r.value(index-1);
	});
};
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.5);
	r.value(10);
	cnt= cnt+1;
};
Routine({while({win.isClosed.not}, {usr.refresh; (1/25).wait})}).play(AppClock);
win.front;
)


//----------------------

//--feedback - phasemodulation
(
SynthDef("feed00", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= LocalIn.ar(1);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, fb*2pi, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed00")
Synth("feed00", [\freq, 800])
Synth("feed00", [\freq, 1800])
Synth("feed00", [\freq, 700, \amp, 0.3])
Synth("feed00", [\freq, 400, \amp, 0.5])


//--feedback - frequencymodulation
(
SynthDef("feed01", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= LocalIn.ar(1);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq+(fb*freq), 0, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed01")
Synth("feed01", [\freq, 800])
Synth("feed01", [\freq, 1800])
Synth("feed01", [\freq, 700, \amp, 0.3])
Synth("feed01", [\freq, 400, \amp, 0.5])
Synth("feed01", [\freq, 300, \amp, 0.8])



//--feedback - amplitudemodulation
(
SynthDef("feed02", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= LocalIn.ar(1);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, 0, amp+fb*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed02")
Synth("feed02", [\freq, 800])
Synth("feed02", [\freq, 1800])
Synth("feed02", [\freq, 700, \amp, 0.3])
Synth("feed02", [\freq, 400, \amp, 0.5])
Synth("feed02", [\freq, 300, \amp, 0.8])



//--feedback - amplitudemodulation with delay
(
SynthDef("feed03", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= DelayN.ar(LocalIn.ar(1), 0.05, 0.05);//delaying the local signal
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, 0, amp+fb*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed03")
Synth("feed03", [\freq, 800])
Synth("feed03", [\freq, 1800])
Synth("feed03", [\freq, 700, \amp, 0.3])
Synth("feed03", [\freq, 400, \amp, 0.5])
Synth("feed03", [\freq, 300, \amp, 0.8])


//--feedback - frequencymodulation with delay
(
SynthDef("feed04", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= DelayN.ar(LocalIn.ar(1), 0.05, 0.05);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq+(fb*freq), 0, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed04")
Synth("feed04", [\freq, 800])
Synth("feed04", [\freq, 1800])
Synth("feed04", [\freq, 700, \amp, 0.3])
Synth("feed04", [\freq, 400, \amp, 0.5])
Synth("feed04", [\freq, 300, \amp, 0.8])


//--feedback - phasemodulation with delay
(
SynthDef("feed05", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= DelayN.ar(LocalIn.ar(1), 0.05, 0.05);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, fb*2pi, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed05")
Synth("feed05", [\freq, 800])
Synth("feed05", [\freq, 1800])
Synth("feed05", [\freq, 700, \amp, 0.3])
Synth("feed05", [\freq, 400, \amp, 0.5])
Synth("feed05", [\freq, 300, \amp, 0.8])



//--feedback - phasemodulation with delay with filter
(
SynthDef("feed06", {|freq= 400, amp= 0.1|
	var env, src, fb;
	//--please try with BPF, LPF, HPF below
	fb= BPF.ar(DelayN.ar(LocalIn.ar(1), 0.05, 0.05), 600);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, fb*2pi, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed06")
Synth("feed06", [\freq, 800])
Synth("feed06", [\freq, 1800])
Synth("feed06", [\freq, 700, \amp, 0.3])
Synth("feed06", [\freq, 400, \amp, 0.5])
Synth("feed06", [\freq, 300, \amp, 0.8])



//--feedback - phasemodulation with delay with filter with pitchshift
(
SynthDef("feed07", {|freq= 400, amp= 0.1|
	var env, src, fb;
	fb= PitchShift.ar(BPF.ar(DelayN.ar(LocalIn.ar(1), 0.05, 0.05), 600), 0.1, 1.1);
	env= EnvGen.ar(Env.perc(0.1, 2), doneAction:2);
	src= SinOsc.ar(freq, fb*2pi, amp*env);
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed07")
Synth("feed07", [\freq, 800])
Synth("feed07", [\freq, 1800])
Synth("feed07", [\freq, 700, \amp, 0.3])
Synth("feed07", [\freq, 400, \amp, 0.5])
Synth("feed07", [\freq, 300, \amp, 0.8])



//--feedback - mixing
(
SynthDef("feed08", {|freq= 400, amp= 0.1, atk= 0.1, rel= 2, delayTime= 0.05, cutoff= 600, pitch= 1.1|
	var env, src, fb;
	fb= PitchShift.ar(LPF.ar(DelayN.ar(LocalIn.ar(1), 1, delayTime), cutoff), 0.1, pitch);
	env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	src= SinOsc.ar(freq, 0, amp*env)+fb;//mixing in the feedback signal
	Out.ar(0, Pan2.ar(src, 0));//output to speakers
	LocalOut.ar(src);	//output to localin
}).send(s);
)
Synth("feed08")
Synth("feed08", [\freq, 800, \atk, 0.001, \rel, 1, \amp, 0.6])
Synth("feed08", [\freq, 800, \atk, 0.001, \rel, 1, \amp, 0.6, \pitch, 2])
Synth("feed08", [\freq, 400, \atk, 0.001, \rel, 1, \amp, 0.6, \pitch, 2, \cutoff, 900])
Synth("feed08", [\freq, 400, \atk, 0.001, \rel, 1, \amp, 0.6, \pitch, 2, \cutoff, 400, \delayTime, 0.1])
Synth("feed08", [\freq, 400, \atk, 1, \rel, 4, \amp, 0.3, \pitch, 0.8, \cutoff, 800, \delayTime, 0.0007])


//----------------------
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursion6", Rect(100, 400, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|index|
	if(index>0, {
		Pen.translate(0, -40);
		Pen.scale(0.8, 0.9);
		Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//branch
		Pen.use{		//like push/pop
			Pen.rotate(0.2);
			Pen.translate(0, -15);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf1
			r.value(index-1);
		};
		Pen.use{		//like push/pop
			Pen.rotate(-0.2);
			Pen.translate(0, -15);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf2
			r.value(index-1);
		};
	});
};
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.9);
	Pen.strokeColor= Color.grey(0.2, 0.8);
	r.value(10);
};
win.front;
)


//--adding some random values makes it look more 'natural'
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursion7", Rect(100, 400, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|index|
	if(index>0, {
		Pen.translate(0, -40+3.rand2);
		Pen.scale(0.8+0.1.rand2, 0.9+0.2.rand2);
		Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//branch
		Pen.use{		//like push/pop
			Pen.rotate(0.2+0.01.rand2);
			Pen.translate(0, -15+2.rand2);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf1
			r.value(index-1);
		};
		Pen.use{		//like push/pop
			Pen.rotate(-0.2+0.01.rand2);
			Pen.translate(0, -15+2.rand2);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf2
			r.value(index-1);
		};
	});
};
usr.drawFunc= {
	Pen.translate(width*0.5, height);
	Pen.strokeColor= Color.grey(0.2, 0.8);
	r.value(10);
};
win.front;
)


//--animation
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursion8", Rect(100, 400, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
r= {|index|
	if(index>0, {
		Pen.translate(0, -40);
		Pen.rotate(sin(cnt*0.08)*0.1);
		Pen.scale(0.8+(sin(cnt*0.01)*0.1), 0.9);
		Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//branch
		Pen.use{		//like push/pop
			Pen.rotate(0.2);
			Pen.translate(0, -15);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf1
			r.value(index-1);
		};
		Pen.use{		//like push/pop
			Pen.rotate(-0.2);
			Pen.translate(0, -15);
			Pen.strokeRect(Rect.aboutPoint(Point(0, 0), 2, 30));//leaf2
			r.value(index-1);
		};
	});
};
usr.drawFunc= {
	Pen.translate(width*0.5, height*0.9);
	Pen.strokeColor= Color.blue(1, 0.8);
	r.value(8);
	cnt= cnt+1;
};
Routine({while({win.isClosed.not}, {usr.refresh; (1/25).wait})}).play(AppClock);
win.front;
)


//--grass?
(
var win, usr, width= 500, height= 500, cnt= 0;
win= Window("recursion9", Rect(100, 400, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.grey;
r= {|index|
	if(index>0, {
		Pen.fillColor= Color.grey(0.6, 0.6);
		Pen.fillOval(Rect.aboutPoint(Point(0, 0), 20, 20));//branch
		Pen.use{		//like push/pop
			Pen.fillColor= Color.white;
			Pen.scale(0.95, 0.95);
			Pen.rotate(sin(cnt+index*0.1)*0.04);
			Pen.translate(0, -20);
			Pen.fillOval(Rect.aboutPoint(Point(0, 0), 5, 5));//leaf1
			r.value(index-1);
		};
	});
};
usr.drawFunc= {
	Pen.translate(width*0.16, height*0.9);
	10.do{|i|
		r.value(20);
		Pen.translate(37, 0);
	};
	cnt= cnt+1;
};
Routine({while({win.isClosed.not}, {usr.refresh; (1/25).wait})}).play(AppClock);
win.front;
)


//----------------------

//--back to sound feedback
(
SynthDef("feed09", {|freq= 600, amp= 0.4, fbamp= 100, atk= 0.01, rel= 0.1, delayTime= 0.05|
	var env, src, local;
	local= DelayN.ar(LocalIn.ar(1), 1, delayTime);
	env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	src= SinOsc.ar(local*fbamp, SinOsc.ar(freq, 0, pi), amp*env);
	Out.ar(0, Pan2.ar(src, 0));
	LocalOut.ar(src);
}).add;
)
Synth("feed09")
Synth("feed09", [\freq, 800, \rel, 0.9, \fbamp, 200])
Synth("feed09", [\freq, 80, \atk, 0, \rel, 1.9, \fbamp, 900])
Synth("feed09", [\freq, 400, \atk, 1, \rel, 1, \fbamp, 100])
Synth("feed09", [\freq, 140, \atk, 0.01, \rel, 0.2, \fbamp, 1000, \delayTime, 0.001])
Synth("feed09", [\freq, 140, \atk, 0.01, \rel, 0.2, \fbamp, 1000, \delayTime, 0.0001])



//----------------------

//something new to finish with... patterns

Pdef(\seq).play

Pdef(\seq, Pbind(\instrument, "feed09", \freq, Pseq([200, 400, 500, 500, 500], inf), \dur, 0.5))

Pdef(\seq, Pbind(\instrument, "feed09", \freq, Pseq([200, 400, 500, 500, 500], inf), \dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25], inf)))

Pdef(\seq, Pbind(\instrument, "feed09", \freq, Pseq([200, 400, 500, 500, 500], inf), \dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25], inf), \amp, Pseq([0.1, 0.1, 0.4, 0, 0.1], inf), \rel, Pseq([0.1, 0.1, 0.1, 0.8], inf), \fbamp, Pseq([900, 500, 2000], inf)))

Pdef(\seq, Pbind(\instrument, "feed09", \freq, Pseq([200, 400, 500, 500, 500], inf), \dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25], inf)*0.5, \amp, Pseq([0.1, 0.1, 0.4, 0, 0.1], inf), \rel, Pseq([0.1, 0.1, 0.1, 0.8], inf), \fbamp, Pseq([900, 500, 2000], inf), \delayTime, Pseq([0.05, 0.005], inf)))

(
Pdef(\seq, Pbind(\instrument, "feed09",
	\freq, Pseq([100, 200, 300, Prand([1000, 2000, 3000, 4000], 1)], inf),
	\dur, Pseq([0.5, 0.5, 0.5, Pseq([0.125, 0.125, 0.125, 0.125], 1)], inf),
	\amp, 0.3,
	\rel, Pseq([0.2, 0.6, 0.2, Pseq([0.01, 0.001, 0.02, 0.04], 1)], inf),
	\fbamp, Pseq([0, 500, 2000, Pseq([5000, 1000, 0, 7000], 3)], inf),
	\delayTime, Pseq([0.05, 0.005], inf)
))
)
Pdef(\seq).stop


//--create a simple bassdrum using the same synthdef
(
Pdef(\bd, Pbind(\instrument, "feed09",
	\dur, 1,
	\freq, 60,
	\atk, 0.001,
	\rel, 0.4,
	\fbamp, 1500
))
)
Pdef(\bd).play

//using Pfunc to calculate frequencies 'by hand'
(
c= 0;
Pdef(\hh, Pbind(\instrument, "feed09",
	\dur, 0.25,
	\freq, Pfunc({c= c+1; sin(c*0.25)*100+500}).trace,
	\atk, 0.01,
	\rel, 0.1,
	\fbamp, 10000,
	\delayTime, 0.001,
	\amp, Pseq([0.1, 0.3], inf)
))
)
Pdef(\hh).play

Pdef(\hh).stop
Pdef(\bd).stop

//play them in sync
(
Pdef(\hh).play(quant:4);
Pdef(\bd).play(quant:4);
Pdef(\seq).play(quant:4);
)

(
Pdef(\seq).stop;
Pdef(\bd).stop;
Pdef(\hh).stop;
)


//hand in pieces/sketches before 16th jul
//one piece of code per document.
//make it run with select all and add a comment with your name
