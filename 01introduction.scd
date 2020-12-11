//udk may-jul 2009 / fredrikolofsson.com
//090604

audiovisual programming

(visual music, music visualisation, live cinema)



1. background (course presentation, about me, history, resources)
2. basic drawing with sc (getting started, window, drawfunc, pen)



1.
//--------------------------
audiovisual mappings
soundwave plotting
recursion/feedback
l-systems, chaotic functions, generative techniques
gravity, particle systems, boids
turtle graphics
analysis like amplitude tracking, filters, centroid
music sequencers / gui



//--------------------------
walt disney - the skeleton dance (1929)
oscar fischinger - komposition in blau (1935)
oscar fischinger - allegretto (1936)
mary ellen bute - tarantella (1940)
norman mclaren - begone dull care (1949)
len lye - free radicals (1958)
john whitney - arabesque (1975)
alexander rutterford - gantz graf (2002)
robin fox - backscatter (2004)
ryoji ikeda - datamatics (2006)
mike winkelmann - beeple iv.6 (2006)
the barbarian group - magnetosphere itunes music visualizer (2007)



//--------------------------
max/msp/jitter		http://www.cycling74.com
pd/gem/pdp			http://puredata.info
openframeworks		http://www.openframeworks.cc
processing			http://processing.org
luaav				http://lua-av.mat.ucsb.edu
vvvv					http://vvvv.org
isadora				http://troikatronix.com
touchdesigner			http://www.touch077.com
quartzcomposer		http://www.apple.com
supercollider			http://supercollider.sourceforge.net



//--------------------------
http://dataisnature.com
http://createdigitalmotion.com
http://en.wikipedia.org/wiki/Visual_music
http://iotacenter.org
http://centerforvisualmusic.org
http://asmir.theremin.ru/gsound1.htm


//--------------------------
until next time please read...
http://www.fredrikolofsson.com/f0blog/?q=node/316



2.
//--------------------------
(
var win, usr, cnt;		//variable declarations
win= Window("test", Rect(100, 200, 300, 400));
usr= UserView(win, Rect(10, 10, 280, 380));
usr.background= Color.blue;

cnt= 0;
usr.drawFunc= {
	Pen.fillColor= Color.white;
	Pen.fillOval(Rect(50, 50, 60, 70));
	Pen.fillColor= Color.black;
	Pen.fillOval(Rect(cnt*2+100, 70, 10, 20));
	Pen.fillOval(Rect(90, 70, 10, 20));
	Pen.fillOval(Rect(70, 95, cnt, 10));
	cnt= (cnt+1)%100;
};

win.front;

Routine({ while({win.isClosed.not}, {(1/25).wait; win.refresh})}).play(AppClock);
)

//--------------------------

{SinOsc.ar(300, 0, 0.1)}.play;
{SinOsc.ar(400, 0, 0.1)}.play;
{SinOsc.ar(500, 0, 0.1)}.play;
{SinOsc.ar(600, 0, 0.1)}.play;

//stop with cmd+.

{SinOsc.ar(600, 0, MouseX.kr(0, 1))}.play

//using arguments to control the synth
a= {arg amp= 0.1; SinOsc.ar(600, 0, amp)}.play
a.set(\amp, 0.5);
a.set(\amp, 0.0);
a.free		//stop the synth


//--------------------------
(
var win, usr, cnt;		//variable declarations
win= Window("test", Rect(100, 200, 300, 400));
usr= UserView(win, Rect(10, 10, 280, 380));
usr.background= Color.blue;
a= {arg amp= 0.1; SinOsc.ar(60, 0, amp)}.play;

cnt= 0;
usr.drawFunc= {
	Pen.fillColor= Color.white;
	Pen.fillOval(Rect(50, 50, 60, 70));
	Pen.fillColor= Color.black;
	Pen.fillOval(Rect(cnt*2+100, 70, 10, 20));
	Pen.fillOval(Rect(90, 70, 10, 20));
	Pen.fillOval(Rect(70, 95, cnt, 10));
	a.set(\amp, cnt/100);
	cnt= (cnt+1)%16;
	if(cnt==10 and:{0.5.coin}, {cnt= 0});
};

win.front;

Routine({ while({win.isClosed.not}, {(1/25).wait; win.refresh})}).play(AppClock);
)
