//udk may-jul 2009 / fredrikolofsson.com
//090618


//----------------------
//typing warm-up exercise...


//animation of 6 ovals at random position
(
var win, usr, cnt;
win= Window("circ", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

usr.drawFunc= {
	Pen.strokeColor= Color(1.0.rand, 0.4.rand, 0.5.rand);
	6.do{
		Pen.addOval(Rect(200.rand, 200.rand, 150.rand, 150.rand));
	};
	Pen.stroke;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)

500.rand		//random values between 0 and 499 (integer)
0.7.rand		//random values betweel 0 and 0.7 (float)

80.do{100.rand.postln}	//do something 80 times
a= 0; 7.do{a= a+1}; a.postln;//increase 'a' 7 times



//radians...
0 radians = 0
1 radians ≈ 6.28... = 2pi

0.5pi
1pi
1.5pi
2pi


//sin and cos...
sin(phase)	//output values between -1.0 and 1.0 as phase goes from 0 to 2pi

sin(0)	 	//= 0		//beginning of circle (right hand side, y= 0)
sin(0.5pi)	//= 1		//spinning anti-clock wise to top of circle (y= 1)
sin(1pi)	//= 0		//half way (left hand side, y= 0)
sin(1.5pi)	//= -1		//bottom of circle (y= -1)


//sin control x position
(
var win, usr, cnt;
win= Window("circ2", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

cnt= 0;
usr.drawFunc= {
	Pen.strokeColor= Color.red;

	Pen.addOval(Rect(sin(cnt/50)*75+150, 150, 30, 30));
	Pen.line(Point(150, 150), Point(150, sin(cnt/50)*75+150));
	cnt= cnt+1;

	Pen.stroke;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)


//cos to control y and we get a circle
(
var win, usr, cnt;
win= Window("circ3", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

cnt= 0;
usr.drawFunc= {
	Pen.strokeColor= Color(1.0.rand, 0.4.rand, 0.5.rand);

	Pen.addOval(Rect(sin(cnt/50)*75+150, cos(cnt/50)*75+150, 30, 30));
	Pen.line(Point(150, 150), Point(150, sin(cnt/50)*75+150));
	cnt= cnt+1;

	Pen.stroke;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)


//iteration in sc...
8.do{|x| ((x*100)+500).postln}//post values from 500 to 1200
3.do{|x| ((x*0.5)+2).postln}//post values from 2 to 3 in 0.5 steps



//many circles with different phase offset (x is circle index 0-39)
(
var win, usr, cnt, phase;
win= Window("circ4", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

cnt= 0;
usr.drawFunc= {
	Pen.width= 2;
	Pen.strokeColor= Color.black;

	phase= cnt/30;	//radians (0 to 2pi)
	40.do{|x|
		Pen.addOval(Rect(sin(phase+(x*0.1))*75+150, cos(phase+(x*0.4))*50+150, x*5+50, x*10+10));
	};
	Pen.stroke;
	cnt= cnt+1;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)


//
(
var win, usr, cnt, phase;
win= Window("circ5", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

cnt= 0;
usr.drawFunc= {
	Pen.width= 2;

	phase= cnt/30;	//radians (0 to 2pi)
	40.do{|x|
		Pen.fillColor= Color.grey(1-(x/40), 0.1);
		Pen.addOval(Rect(sin(phase+(x*0.1))*75+150, cos(phase+(x*0.4))*50+150, x*5+50, x*10+10));
		Pen.fill;
	};
	cnt= cnt+1;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)






//----------------------
//sound
s.boot
(
//sine oscillator
SynthDef("sine1", 	{|freq= 500, amp= 0.5|
	var snd;
	snd= SinOsc.ar(freq, 0, amp);
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

//create 3 synths from the same synth definition
Synth("sine1", [\freq, 700])
Synth("sine1", [\freq, 200])
Synth("sine1", [\freq, 600])
//stop with cmd+. (alt+. on windows)

//
(
SynthDef("sine2", 	{|freq= 500, amp= 0.5, ampRate= 0.1|
	var snd;
	snd= SinOsc.ar(freq, 0, amp*SinOsc.ar(ampRate, 0, 1));
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

Synth("sine2", [\freq, 220])
Synth("sine2", [\freq, 440])
Synth("sine2", [\freq, 880])

(
8.do{|x|
	Synth("sine2", [\freq, x*100+400, \amp, 0.1, \ampRate, x*1.2+0.1]);
};
)

//same as typing...
Synth("sine2", [\freq, 0*100+400, \amp, 0.1, \ampRate, 0*2+0.1]);
Synth("sine2", [\freq, 1*100+400, \amp, 0.1, \ampRate, 1*2+0.1]);
Synth("sine2", [\freq, 2*100+400, \amp, 0.1, \ampRate, 2*2+0.1]);
Synth("sine2", [\freq, 3*100+400, \amp, 0.1, \ampRate, 3*2+0.1]);
Synth("sine2", [\freq, 4*100+400, \amp, 0.1, \ampRate, 4*2+0.1]);
Synth("sine2", [\freq, 5*100+400, \amp, 0.1, \ampRate, 5*2+0.1]);
Synth("sine2", [\freq, 6*100+400, \amp, 0.1, \ampRate, 6*2+0.1]);
Synth("sine2", [\freq, 7*100+400, \amp, 0.1, \ampRate, 7*2+0.1]);


//many more synths.  look out for amplitude (1/80) and frequency (keep below half samplingrate (22050))
(
80.do{|x|
	Synth("sine2", [\freq, x*100+400, \amp, 1/80, \ampRate, x*0.1+0.1]);
};
)



//a new
(
SynthDef("sine3", {|freq= 600, amp= 0.1, pan= 0|
	var snd;
	snd= SinOsc.ar(freq, 0, amp);
	Out.ar(0, Pan2.ar(snd, pan));
}).send(s);
)

//a synth with freq 500 left speaker
//a synth with freq 770 in right speaker
//a synth with freq 900 in the middle
Synth("sine3", [\freq, 500, \amp, 0.3, \pan, -1]);
Synth("sine3", [\freq, 770, \amp, 0.3, \pan, 1]);
Synth("sine3", [\freq, 900, \amp, 0.3, \pan, 0]);

//and same thing written using variables and .set messages
a= Synth("sine3")
a.set(\freq, 500)
a.set(\pan, -1)
b= Synth("sine3")
b.set(\freq, 770)
b.set(\pan, 1)
c= Synth("sine3")
c.set(\freq, 900)
c.set(\pan, 0)
a.free
b.free
c.free


//making arrays with .dup.  here 20 random values between 0-100
{100.rand}.dup(20)


//create many synths and save in one array
a= {Synth("sine3", [\freq, 1000.rand, \amp, 1/40])}.dup(40);

//access single synths in the array...
a[31].set(\freq, 2000)
a[31].free

a.do{|x| x.free}	//stop all synths




//---------------------
{|x| x%20}.dup(100)	//modulo

//controlling sound from the graphic
(
var win, usr, cnt;
win= Window("circ", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

a= {Synth("sine3")}.dup(1);
cnt= 0;
usr.drawFunc= {
	var amp= 0;
	amp= cnt%100/100;		//keep amp between 0 and 1
	a[0].set(\amp, amp);
	Pen.strokeColor= Color(1, 0, 0);
	Pen.addOval(Rect(200, 200, amp*200, amp*200));
	Pen.stroke;
	cnt= cnt+1;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)




//--
(
var win, usr, cnt;
win= Window("circ", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

a= {Synth("sine3", [\amp, 0])}.dup(30);
cnt= 0;
usr.drawFunc= {
	30.do{|x|
		var amp= amp= cnt%100/100;//keep amp between 0 and 1
		var posX= x*15+10;
		var posY= sin(cnt%80/80*2pi+(x/10))*150+200;
		a[x].set(\amp, amp/30, \freq, posY*10+100, \pan, (x/30)*2-1);
		Pen.strokeColor= Color(1-amp, 1-amp, 1-amp);
		Pen.addOval(Rect(posX, posY, amp*20, amp*20));
		Pen.stroke;
	};
	cnt= cnt+1;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)




//------------------
//sound setup...
s.boot
(
SynthDef("sine4", {|freq= 900, amp= 0.1, freq2= 2, amp2= 20, pan= 0|
	var snd;
	snd= SinOsc.ar(freq+SinOsc.ar(freq2, 0, amp2), 0, amp);
	Out.ar(0, Pan2.ar(snd, pan));
}).send(s);
)
a= Synth("sine4")
a.set(\freq, 600)
a.set(\freq2, 0.4)		//speed of frequency modulation
a.set(\amp2, 100)		//depth of frequency modulation
a.free


(
//graphic setup...
var win, usr, cnt, syn, updown, size;
win= Window("simple again", Rect(100, 100, 640, 480));
win.front;
usr= UserView(win, Rect(0, 0, 640, 480));
usr.background= Color.black;

//sound...
syn= Synth("sine4");

//draw...
cnt= 0;
usr.drawFunc= {
	updown= sin(cnt/1000 + (sin(cnt/400)*20))*0.5;	//phase should go from 0 to 2pi
	size= sin(cnt/80);
	Pen.fillColor= Color.grey(0.9);
	Pen.fillOval(Rect(cnt%640, 480*(updown*0.5+0.5), (size*0.5+0.5)*50, (size*0.5+0.5)*50));
	syn.set(\pan, ((cnt%640/640)*2-1).postln);	syn.set(\freq, (updown* -0.5+0.5)*200+400);
	syn.set(\amp, (size*0.5+0.5));
	cnt= cnt+10;
};

//animate...
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)

updown				//gives values between -1 and 1
(updown*0.5+0.5)	//gives values between 0 and 1





(
//graphic setup...
var win, usr, cnt, syn, updown, size;
win= Window("simple again", Rect(100, 100, 640, 480));
win.front;
usr= UserView(win, Rect(0, 0, 640, 480));
usr.background= Color.black;

//sound...
syn= {Synth("sine4", [\amp, 0])}.dup(20);

//draw...
cnt= 0;
usr.drawFunc= {
	20.do{|x|		//x is counting 0 to 19
		updown= sin(cnt/100+(x*0.2));
		size= sin(cnt/80+(x*0.1));
		Pen.fillColor= Color.grey(0.9);
		Pen.fillOval(Rect(cnt+(x*20)%640, 480*(updown*0.5+0.5), (size*0.5+0.5)*50, (size*0.5+0.5)*50));
		syn[x].set(\pan, ((cnt%640/640)*2-1));		syn[x].set(\freq, (updown* -0.5+0.5)*200+400);
		syn[x].set(\amp, (size*0.5+0.5));
	};
	cnt= cnt+4;	//overall speed
};

//animate...
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)





//-----------------------
//sine5 separate sines on separate channels - no beating
(
SynthDef("sine5", {|freq= 400, detune= 1|
	var snd, snd2;
	snd= SinOsc.ar(freq, 0, 0.1);
	snd2= SinOsc.ar(freq+detune, 0, 0.1);
	Out.ar(0, snd);
	Out.ar(1, snd2);
}).send(s);
)

Synth("sine5")


//sine6 is mixing 2 sines - beating happens
(
SynthDef("sine6", {|freq= 400, detune= 1|
	var snd, snd2;
	snd= SinOsc.ar(freq, 0, 0.1);
	snd2= SinOsc.ar(freq+detune, 0, 0.1);
	Out.ar(0, Pan2.ar(snd+snd2, 0));
}).send(s);
)

a= Synth("sine6")
a.set(\detune, 2)
a.set(\detune, 20)
a.set(\detune, 0.5)
a.free


//sine7 uses phase modulation
(
SynthDef("sine7", {|freq= 680, phaseFreq= 500|
	var snd, snd2;
	snd2= SinOsc.ar(phaseFreq)*2pi;
	snd= SinOsc.ar(freq, snd2, 0.5);
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

a= Synth("sine7");
a.set(\phaseFreq, 100)
a.set(\phaseFreq, 1000)
a.set(\phaseFreq, 50)
a.free


//sine8 - connect modulators in parallel
(
SynthDef("sine8", {|freq= 680, phaseFreq= 500|
	var snd, snd2, snd3, snd4;
	snd4= SinOsc.ar(phaseFreq+3)*2pi;
	snd3= SinOsc.ar(phaseFreq+2)*2pi;
	snd2= SinOsc.ar(phaseFreq+1)*2pi;
	snd= SinOsc.ar(freq, snd2+snd3+snd4, 0.5);
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

a= Synth("sine8")
a.set(\phaseFreq, 50)
a.set(\phaseFreq, 150)
a.free

//sine9 - modulators connected in chain
(
SynthDef("sine9", {|freq= 680, phaseFreq= 500|
	var snd, snd2, snd3, snd4;
	snd4= SinOsc.ar(phaseFreq+3)*2pi;
	snd3= SinOsc.ar(phaseFreq+2, snd4)*2pi;
	snd2= SinOsc.ar(phaseFreq+1, snd3)*2pi;
	snd= SinOsc.ar(freq, snd2, 0.5);
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

a= Synth("sine9")
a.set(\phaseFreq, 50)
a.set(\phaseFreq, 150)
a.free

//complex sounds from simple modulation with a couple of sine oscillators
//sine10 - similar to 9 but with more arguments
(
SynthDef("sine10", {|freq= 680, phaseFreq4= 1, phaseFreq3= 10, phaseFreq2= 23|
	var snd, snd2, snd3, snd4;
	snd4= SinOsc.ar(phaseFreq4)*2pi;
	snd3= SinOsc.ar(phaseFreq3, snd4)*2pi;
	snd2= SinOsc.ar(phaseFreq2, snd3)*2pi;
	snd= SinOsc.ar(freq, snd2, 0.5);
	Out.ar(0, Pan2.ar(snd, 0));
}).send(s);
)

a= Synth("sine10")
a.set(\phaseFreq2, 0.5, \phaseFreq3, 2.9 ,\phaseFreq4, 4)
a.set(\phaseFreq2, 1.5, \phaseFreq3, 50.9 ,\phaseFreq4, 4)
a.set(\freq, 200, \phaseFreq2, 33, \phaseFreq3, 50.9 ,\phaseFreq4, 40)
a.set(\freq, 800, \phaseFreq2, 0.25, \phaseFreq3, 1.9 ,\phaseFreq4, 0.7)
a.free

//compare sin(cnt/100)+sin(cnt/60) etc in the graphics
//or sin(cnt/100 + (sin(cnt/60)*2pi)) for sort of phase mod



//---------------------------
(
var win, usr, cnt, phase;
win= Window("circ6", Rect(100, 200, 500, 500));
usr= UserView(win, Rect(0, 0, 500, 500));
usr.background= Color.white;

a= {Synth("sine3")}.dup(40);
cnt= 0;
usr.drawFunc= {
	Pen.width= 2;

	phase= cnt/30;	//radians (0 to 2pi)
	40.do{|x|
		Pen.fillColor= Color.grey(1-(x/40), 0.3);
		Pen.addOval(Rect(sin(phase+(x*0.1))*75+150, cos(phase+(x*0.4))*50+150, x*5+50, x*10+10));
		a[cnt%40].set(\freq, sin(phase+(x*0.1))*75+500);
		Pen.fill;
	};
	cnt= cnt+1;
};

win.front;
Routine({while({win.isClosed.not}, {usr.refresh; (1/30).wait})}).play(AppClock);
)
