//udk may-jul 2009 / fredrikolofsson.com
//090625


//----------------------
/*
the Point class...
Point(x, y)

a= Point(100, 300)
a+10
a+Point(1, 2)
a.x+1000
a.y*2
*/


(
var win, usr;
win= Window("lines", Rect(100, 200, 400, 400));
usr= UserView(win, Rect(0, 0, 400, 400));
usr.background= Color.white;
usr.drawFunc= {
	100.do{|i|
		Pen.moveTo(Point(200, 200));//move to middle screen
		Pen.lineTo(Point(i*2, i*4));//line to somewhere
	};
	Pen.stroke;
};
win.front;
)


(
var win, usr;
win= Window("more lines", Rect(100, 200, 400, 400));
usr= UserView(win, Rect(0, 0, 400, 400));
usr.background= Color.white;
usr.drawFunc= {
	70.do{|i|
		Pen.moveTo(Point(200, 200));//move to middle screen
		Pen.lineTo(Point(i*2, i*6));//line to somewhere
		Pen.moveTo(Point(100, 100));
		Pen.lineTo(Point(i*9, i*2));
		Pen.moveTo(Point(350, 350));
		Pen.lineTo(Point(i/5, i*7));
	};
	Pen.stroke;
};
win.front;
)



(
var win, usr, width= 640, height= 480;
win= Window("structured lines", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	(width/2).do{|i|
		Pen.strokeColor= Color(1.0.rand);
		Pen.moveTo(Point(width/2, height/2));//move to middle screen
		Pen.lineTo(Point(i*2, 20));
		Pen.moveTo(Point(width/2, height/2));//move back to middle screen
		Pen.lineTo(Point(i*2, height-20));
		Pen.stroke;
	};
};
win.front;
)


//Pen.quadCurveTo(destionationPoint, controlPoint)
(
var win, usr, width= 640, height= 480;
win= Window("curve", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.moveTo(Point(width/2, height/2));
	Pen.quadCurveTo(Point(600, 10), Point(450, 50));
	Pen.stroke;
	Pen.strokeOval(Rect(width/2, height/2, 5, 5));//start
	Pen.strokeOval(Rect(450, 50, 5, 5));//control
	Pen.strokeOval(Rect(600, 10, 5, 5));//destination
};
win.front;
)


(
var win, usr, width= 640, height= 480;
win= Window("more curve", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	50.do{|i|
		var start, control, end;
		start= Point(width/2, height/2);
		control= Point(width.rand, height.rand);
		end= Point(20, i/50*height);
		Pen.moveTo(start);
		Pen.quadCurveTo(end, control);
		Pen.stroke;
		Pen.strokeOval(Rect(control.x, control.y, 5, 5));
	};
};
win.front;
)


//even more curves and with colours
(
var win, usr, width= 640, height= 480, n= 250;
win= Window("even more curve", Rect(100, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	n.do{|i|
		var start, control, end, col;
		col= Color.grey(1-(i/n), 0.5);
		Pen.strokeColor= col;
		start= Point(width/2, height/2);
		control= Point(width.rand.round(100), height.rand.round(50));
		end= Point(20, i/n*height);
		Pen.moveTo(start);
		Pen.quadCurveTo(end, control);
		Pen.stroke;
		Pen.strokeOval(Rect(control.x, control.y, 5, 5));
	};
};
win.front;
)




//-------------------------
s.boot;
(
SynthDef("env", {
	var env, snd;
	env= EnvGen.ar(Env.perc(0.01, 0.5, curve:-4), doneAction:2);
	snd= SinOsc.ar(500)*env;
	Out.ar(0, Pan2.ar(snd));
}).send(s);
)

Synth("env")

Env.perc(0.01, 0.5, curve:-4).plot

//doneAction:2 is almost like deallocation of synths
//cleans up and stop the synth when envelope is finished (attacktime+releasetime)



//same but with white noise
(
SynthDef("env2", {
	var env, snd;
	env= EnvGen.ar(Env.perc(0.01, 0.5, curve:-4), doneAction:2);
	snd= WhiteNoise.ar(1)*env;
	Out.ar(0, Pan2.ar(snd));
}).send(s);
)

Synth("env2")



//same envelope used for both amp and freq
(
SynthDef("env3", {
	var env, snd;
	env= EnvGen.ar(Env.perc(0.1, 0.9, curve:-4), doneAction:2);
	snd= SinOsc.ar(500*env+500)*env;//freq between 500 and 1000
	Out.ar(0, Pan2.ar(snd));
}).send(s);
)

Synth("env3")



//same synthdef but with 4 arguments.  using arguments we can
//control the synth parameters without changing the synthdef
(
SynthDef("env4", {|attack= 0.1, release= 0.9, c= -4, freq= 500|
	var env, snd;
	env= EnvGen.ar(Env.perc(attack, release, curve:c), doneAction:2);
	snd= SinOsc.ar(freq*env+500, 0, 0.25)*env;
	Out.ar(0, Pan2.ar(snd));
}).send(s);
)

Synth("env4", [\attack, 0.001, \release, 1, \c, -4, \freq, 600])
Synth("env4", [\attack, 0.4, \release, 0.5, \c, -4, \freq, 900])
Synth("env4", [\attack, 0.2, \release, 0.1, \c, -4, \freq, 1500])



//--many different curves/envelopes at the same time
(
Synth("env4", [\attack, 2.1, \release, 3.0, \c, -0.1, \freq, 600]);
Synth("env4", [\attack, 2.2, \release, 2.9, \c, -0.2, \freq, 700]);
Synth("env4", [\attack, 2.3, \release, 2.8, \c, -0.3, \freq, 800]);
Synth("env4", [\attack, 2.4, \release, 2.7, \c, -0.4, \freq, 900]);
Synth("env4", [\attack, 2.5, \release, 2.6, \c, -0.5, \freq, 1000]);
Synth("env4", [\attack, 2.6, \release, 2.5, \c, -0.6, \freq, 1100]);
Synth("env4", [\attack, 2.7, \release, 2.4, \c, -0.7, \freq, 1200]);
Synth("env4", [\attack, 2.8, \release, 2.3, \c, -0.8, \freq, 1300]);
Synth("env4", [\attack, 2.9, \release, 2.2, \c, -0.9, \freq, 1400]);
)


//exactly the same but makes the computer calculate arguments for us
(
9.do{|i|
	Synth("env4", [\attack, 2.1+(i*0.1), \release, 3-(i*0.1), \c, -0.1+(i* -0.1), \freq, 600+(i*100)]);
};
)


//advanced...
//start synths with a time delay between each
(
Routine({
	9.do{|i|
		Synth("env4", [\attack, 2.1+(i*0.1), \release, 3-(i*0.1), \c, -0.1+(i* -0.1), 	\freq, 600+(i*100)]);
		1.wait;	//1 second between each synth start
	};
}).play(AppClock);
)




//a synthdef with 3 different envelopes inside
//more control over the sound
//note: use only 1 doneAction per synthdef.  usually on the amplitude control
(
SynthDef("env5", {|attack= 0.01, release= 0.5, c= -4, freq= 500|
	var env, env2, env3, snd;
	env= EnvGen.ar(Env.perc(attack, release, curve: c), doneAction:2);//controls amp
	env2= EnvGen.ar(Env.perc(0.5, 0.5, curve: 0));//controls panning
	env3= EnvGen.ar(Env.perc(0.2, 0.1, curve: -3));//controls frequency
	snd= SinOsc.ar(freq*env3+500, SinOsc.ar(env2*200, 0, 2pi), env);
	Out.ar(0, Pan2.ar(snd, env2*2-1));//env2 is scaled from (0 to 1) to (-1 to 1)
}).send(s);
)

Synth("env5")
Synth("env5", [\attack, 0.1, \release, 0.7, \c, -6, \freq, 800])
Synth("env5", [\attack, 0.02, \release, 0.17, \c, -3, \freq, 1800])
Synth("env5", [\attack, 0.01, \release, 0.17, \c, 7, \freq, 2800])
Synth("env5", [\attack, 1, \release, 0.2, \c, 0, \freq, 10])



//more simple again.  phase modulation with 2 envelopes.
(
SynthDef("env6", {|atk= 0.01, rel= 0.3, freq= 500, mod= 0, matk= 0.03|
	var env, env2, snd;
	env= EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	env2= EnvGen.ar(Env.perc(matk, 0.06));
	snd= SinOsc.ar(0, SinOsc.ar(freq, 0, 2pi*env2*mod+1), env);
	Out.ar(0, Pan2.ar(snd));
}).send(s);
)
Synth("env6", [\freq, 500])
Synth("env6", [\freq, 700])
Synth("env6", [\freq, 80, \mod, 1])
Synth("env6", [\freq, 180, \mod, 3, \matk, 0.4])
Synth("env6", [\freq, 120, \mod, 13, \matk, 0.1])


//little arpeggiator...
(
Routine({
	4.do{|x|		//play 4 bars
		8.do{|y|	//8 notes per bar
			Synth("env6", [\freq, 200+(y*100)+(x*100), \matk, y/8, \mod, x, \rel, y/8*0.2]);
			0.1.wait;		//note duration
		};
	};
}).play(AppClock);
)


//little sequencer... (stop with cmd+.)
(
Routine({
	inf.do{|x|
		if(x%16==4, {Synth("env6", [\freq, x%5*100+200, \rel, 2, \mod, 0, \matk, 0.01])});
		if(x%8==0, {Synth("env6", [\freq, 80, \atk, 0.005, \rel, 0.1, \mod, 1, \matk, 0.01])});
		if(x%8==0 or:{x%6==0}, {Synth("env6", [\freq, 1800, \atk, 0.01, \rel, 0.05, \mod, 50, \matk, 0.01])});
		0.04.wait;	//note duration
	};
}).play(AppClock);
)



//-----------------
(
var win, usr, cnt= 0, width= 500, height= 500;
win= Window("linenv", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.moveTo(Point(width/2, height/2));
	Pen.lineTo(Point(cnt*10%width, 100));
	Pen.stroke;
	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {usr.refresh; 0.5.wait})}).play(AppClock);
)




(
var win, usr, cnt= 0, width= 500, height= 500;
win= Window("linenv2", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	Pen.fillColor= Color.grey;

	Pen.strokeColor= Color.red;
	if(cnt%8==0, {
		Synth("env6", [\freq, 120]);
		Pen.strokeOval(Rect.aboutPoint(Point(25, 100), 40, 40));
		Pen.fillOval(Rect.aboutPoint(Point(25, 100), 20, 20));
	});
	Pen.moveTo(Point(width/2, height/2));
	Pen.lineTo(Point(cnt%8*80+25, 100));
	Pen.stroke;

	Pen.strokeColor= Color.green;
	if(cnt%12==0, {
		Synth("env6", [\freq, 440]);
		Pen.strokeOval(Rect.aboutPoint(Point(25, 180), 40, 40));
		Pen.fillOval(Rect.aboutPoint(Point(25, 180), 20, 20));
	});
	Pen.moveTo(Point(width/2, height/2));
	Pen.lineTo(Point(cnt%12*80+25, 180));
	Pen.stroke;

	Pen.strokeColor= Color.blue;
	if(cnt%5==0, {
		Synth("env6", [\freq, 900]);
		Pen.strokeOval(Rect.aboutPoint(Point(25, 360), 40, 40));
		Pen.fillOval(Rect.aboutPoint(Point(25, 360), 20, 20));
	});
	Pen.moveTo(Point(width/2, height/2));
	Pen.lineTo(Point(cnt%5*80+25, 360));
	Pen.stroke;

	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {usr.refresh; 0.25.wait})}).play(AppClock);
)



//-------------------
(
var win, usr, cnt= 0, width= 500, height= 500, control, step;
win= Window("curvenv", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
control= Point(width/2, 0);
step= 10;
usr.drawFunc= {

	if(cnt%32==0, {
		step= 50.rand;
		Synth("env6", [\freq, step*25+180, \mod, step, \matk, 0.1, \rel, 1]);
		control= Point(width/2, 0);
	});
	if(cnt%32==16, {
		step= 0-50.rand;		//step becomes negative
		Synth("env6", [\freq, step*25+180, \mod, step, \matk, 0.1, \rel, 1]);
	});
	Pen.width= step;
	Pen.moveTo(Point(20, height/2));
	Pen.quadCurveTo(Point(width-20, height/2), control*0.5);
	Pen.stroke;

	cnt= cnt+1;
	control= Point(control.x, control.y+step);
};
win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/40).wait})}).play(AppClock);
)


//each curve has a unique sound connected to it
(
var win, usr, cnt= 0, width= 500, height= 500;
win= Window("curvenv2", Rect(200, 200, width, height));
usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.white;
usr.drawFunc= {
	var freq= cnt*50%2000+80;	//80.rrand(2000)
	var atk= cnt*0.1%0.25; 		//0.0.rrand(0.25)
	var rel= 	cnt*0.05%0.6+0.01;//0.01.rrand(0.6)
	var matk= cnt*0.06%3;		//0.0.rrand(3)
	var mod= cnt*0.5%10;			//0.0.rrand(10)
	Synth("env6", [\freq, freq, \atk, atk, \rel, rel, \matk, matk, \mod, mod]);
	Pen.moveTo(Point(atk.linlin(0, 0.25, 0, width), freq.linlin(80, 2080, 0, height)));
	Pen.quadCurveTo(Point(rel.linlin(0.01, 0.61, 0, width), matk.linlin(0, 3, 0, height)), Point(mod.linlin(0, 10, 0, width), height/2));
	Pen.stroke;
	cnt= cnt+1;
};
win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/10).wait})}).play(AppClock);
)


//17th-19th (fri-sun) show sketches/pieces
//make document with comment with your name
//make it start with selectAll+enter

//saturday (july 4th) at 11:00 - 3 day workshop: network programming with julian
