// make sure you have sc3 plugins installed first
(
var multiServerSetup = true;

//"Server.killAll".unixCmd
//s.volume_(-6)
var inOut = Server.default.options;
//inOut.outDevice = "BH2+KA6"; inOut.inDevice = "BH2+KA6";
//inOut.outDevice = "BlackHole 2ch"; inOut.inDevice = "BlackHole 2ch";
//inOut.outDevice = "BlackHole 16ch"; inOut.inDevice = "BlackHole 16ch";
inOut.outDevice = "BlackHole 64ch"; inOut.inDevice = "BlackHole 64ch";
//inOut.outDevice = "Audient iD14"; inOut.inDevice = "Audient iD14";
//inOut.outDevice = "Komplete Audio 6 MK2"; inOut.inDevice = "Komplete Audio 6 MK2";
//inOut.outDevice = "Double Kompletes"; inOut.inDevice = "Double Kompletes";
//inOut.outDevice = "External Headphones"; inOut.inDevice = "External Microphone";
//inOut.outDevice = "MADIface USB (23949544)"; inOut.inDevice = "MADIface USB (23949544)"; // LR
//inOut.outDevice = "MADIface USB (24053751)"; inOut.inDevice = "MADIface USB (24053751)"; // IAC
s.options.bindAddress = "0.0.0.0";
//s.maxNumClients = 4;
s.options.maxLogins = 4;
s.options.numBuffers = 1024 * 64; // increase if you need to load more samples
s.options.numWireBufs = 1024; // increase if you get "exception in GraphDef_Recv: exceeded number of interconnect buffers."
s.options.numAudioBusChannels = 2048; // increase if you get "ERROR: Meta_Bus:audio: failed to get an audio bus allocated."
s.options.memSize = 8192 * 256; // increase if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase if drop outs and the message "too many nodes"
s.options.sampleRate= 44100;
s.options.blockSize = 512; // default is 64
s.options.maxSynthDefs_(10000);
s.options.numOutputBusChannels = 64; // OUTPUT CHANNELS GO HERE
//s.recSampleFormat = "float32";
s.recSampleFormat = "int24";
s.recHeaderFormat="wav";
s.options.numInputBusChannels = 2; // set to hardware input channel size, if necessary
s.latency = 0.6; // 0.3
MIDIClient.init;
MIDIIn.connectAll;
m = MIDIOut.new(0); // Maybe yours is different? // could be newByName
m.latency = 0.6; // This should match s.latency
n = NetAddr("127.0.0.1", 8000);
thisProcess.platform.recordingsDir = "/Users/danielmkarlsson/sc-rec/"; // choose where supercollider recordings end up

//~m1 = MIDIOut.newByName("IAC Driver", "Bus 1");
//~m2 = MIDIOut.newByName("Komplete Audio 6 MK2", "Komplete Audio 6 MK2");
//~m1.latency = 0.3;
//~m2.latency = 0.3;
// ~m3 = MIDIOut.newByName("IAC Driver", "Bus 3");
// ~m4 = MIDIOut.newByName("IAC Driver", "Bus 4");
// ~m5 = MIDIOut.newByName("IAC Driver", "Bus 5");
// ~m6 = MIDIOut.newByName("IAC Driver", "Bus 6");
// ~m7 = MIDIOut.newByName("IAC Driver", "Bus 7");
// ~m8 = MIDIOut.newByName("IAC Driver", "Bus 8");

// scnvim
if (\SCNvim.asClass.notNil) {
    Server.default.doWhenBooted {
        \SCNvim.asClass.updateStatusLine(1, \SCNvim.asClass.port); // 9670
    }
};

QtGUI.palette = QPalette.dark; // switch to night mode for floating windows like the meter for example.

//A simple triangle wave synth in stereo with panning and a simple low pass filter
//This synthDef builds on the work of Mads Kjeldgaard and requires the sc3 plugins
s.doWhenBooted{
    SynthDef.new(\default, {
        arg dur, attack=0.01, release=1.0,
        t_gate=1, out, freq=440, cutoff=5500,
        rq=1, pan=0.0, amp=0.5;

        var env = EnvGen.kr(Env.perc(attack, release), t_gate, timeScale: dur, doneAction: 2);
        var sig = DPW3Tri.ar(freq: freq, mul: env);
        sig = RLPF.ar(sig, cutoff.clip(20.0, 20000.0), rq.clip(0.0,1.0));
        sig = Pan2.ar(sig, pan);
        Out.ar(out, sig * amp);
    }).add;
    /*SynthDef(\default, { |out = 2|
        var input = SoundIn.ar([0, 1]);
        Out.ar(out, CombN.ar(input * 0.dbamp, 0.5, 0.5, 0.001))
    }).play;*/
};

/*
fork {
    var cond, runResponder;
    s.options.bindAddress = "0.0.0.0";
    s.options.maxLogins = 8;
    o = ServerOptions.new;
    o.maxLogins = 12;
    o.bindAddress = "0.0.0.0";

    Server.default = s = Server.remote(\remote2, NetAddr("192.168.44.98", 57110), o); // replace "192.168.0.100"

    cond = Condition({ s.serverRunning });

    // 'signal' will allow the forked routine to advance
    // only when 'serverRunning' finally becomes true
    runResponder = SimpleController(s).put(\serverRunning, { cond.signal });

    //cond.wait;

    runResponder.remove;
};

CmdPeriod.freeServers = false;
*/

if (multiServerSetup) {
// Multi-server setup
~servers = 7.collect{|i| // depends maybe, try lowering if no go
    var id = 57100;
 //   var server = Server.new("server"++i, NetAddr("localhost", id+i), Server.local.options); // .boot
	var server = Server.new("server"++i, NetAddr("localhost", id+i), s.options); // .boot
    ~cleanInstances = [];
    server.waitForBoot {
        var instance = SuperClean(numChannels: 2, server: server);
        ~cleanInstances = ~cleanInstances.add(instance);
        instance.loadSoundFiles; // hot swap in samples from anywhere!
        server.sync;
        instance.start((0, 2 .. 62)); // all the auxes!, well, 64 auxes really
        //instance.start([0, 2, 4, 6, 8]);
    };
};
} {
// Single server setup
s.waitForBoot {
    ~clean = SuperClean(2, s); // two output channels
    ~clean.loadSoundFiles; // hot swap in samples from anywhere!
    // for example: ~clean.loadSoundFiles("~/Downloads/rnb");
    s.sync; // optionally: wait for samples to be read
    ~clean.start((0, 2 .. 62)); // all the auxes!, well, 64 auxes really

    SuperClean.default = ~clean; // make the clean key sequenceable inside of SuperCollider

    //~clean.start([0]); // can't have any less
    //~clean.start([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]); // 24 auxes are sending to the first stereo output
    //~clean.start([0].dup(32)); // 32 auxes are sending to the first stereo output
    //~clean.start([0, 2]); // quad
    //~clean.start([0, 2, 4, 6]);  // eight out
    //~clean.start([0, 2, 4, 6, 8, 10, 12, 14]);  // sixteen out

    //~clean.start(Array.series(32, 0, 2).dupEach(2)); // double all the auxes

    "[ SuperClean up + running ]".postln;
};
}

//
//	(
//		r.stop;
//		r = {
//			loop {
//				s.record("~/snd/tmp/continousOverwrite.wav", 2);
//				exprand(1, 2).wait;
//				s.stopRecording;
//				0.1.wait;
//				~clean.lsf("~/snd/tmp");
//				0.1.wait;
//			}
//		}.fork;
//	);
//
//	(
//		Pdef(0,
//			Pbind(*[
//				type: \cln,
//				snd: \tmp,
//				amp: 1,
//				dur: Pdup(Plprand(1, 2), Pwhite(0.1, 1.0)),
//				spd: Prand([0.5, 1.0], inf),
//				bgn: Plprand(0.0, 0.5) + Prand([0, 2], inf),
//				jpr: 1/2,
//				jpg: Plprand(0.0, 1.5),
//				jps: Pwhite(0.0, 1.0)
//			])
//		).play
//	);
//};
//
//
//
//
)


//(
//var inOut = Server.default.options;
//inOut.outDevice = "Komplete Audio 6 MK2"; inOut.inDevice = "Komplete Audio 6 MK2";
//s.options.bindAddress = "0.0.0.0";
//s.options.maxLogins = 4;
//s.options.numBuffers = 1024 * 64; // increase if you need to load more samples
//s.options.numWireBufs = 1024; // increase if you get "exception in GraphDef_Recv: exceeded number of interconnect buffers."
//s.options.numAudioBusChannels = 2048; // increase if you get "ERROR: Meta_Bus:audio: failed to get an audio bus allocated."
//s.options.memSize = 8192 * 256; // increase if you get "alloc failed" messages
//s.options.maxNodes = 1024 * 32; // increase if drop outs and the message "too many nodes"
//s.options.sampleRate= 44100;
//s.options.blockSize = 512; // default is 64
//s.options.maxSynthDefs_(10000);
//s.options.numOutputBusChannels = 64; // OUTPUT CHANNELS GO HERE
//s.recSampleFormat = "int24";
//s.recHeaderFormat="wav";
//s.options.numInputBusChannels = 2; // set to hardware input channel size, if necessary
//s.latency = 0.6; // 0.3
//n = NetAddr("127.0.0.1", 8000);
//QtGUI.palette = QPalette.dark; // switch to night mode for floating windows like the meter for example.
//s.doWhenBooted{
//	SynthDef(\default, { |out = 2|
//		var input = SoundIn.ar([0, 1]);
//		Out.ar(out, CombN.ar(input * 0.dbamp, 0.5, 0.5, 0.001))
//	}).play;
//};
//s.waitForBoot {
//	~clean = SuperClean(2, s); // two output channels
//	~clean.loadSoundFiles; // hot swap in samples from anywhere!
//	s.sync; // optionally: wait for samples to be read
//	~clean.start((0, 2 .. 62)); // all the auxes!, well, 64 auxes really
//	SuperClean.default = ~clean; // make the clean key sequenceable inside of SuperCollider
//	"[ SuperClean up + running ]".postln;
//	(
//		r.stop;
//		r = {
//			loop {
//				s.record("~/snd/tmp/continousOverwrite.wav", 2);
//				exprand(3, 6).wait;
//				s.stopRecording;
//				0.1.wait;
//				~clean.lsf("~/snd/tmp");
//				0.1.wait;
//			}
//		}.fork;
//	);
//	(
//		Pdef(0,
//			Pbind(*[
//				type: Pwrand2([\cln, \], [2, 1], inf),
//				snd: \tmp,
//				amp: 1,
//				dur: Pdup(Plprand(1, 2), Pwhite(0.1, 3.0)),
//				spd: Pwrand2([0.5, 1.0], [1, 4], inf),
//				bgn: Plprand(0.0, 0.5) + Prand([0, 2], inf),
//				jpr: 1/4,
//				jpg: Plprand(0.0, 2.0),
//				jps: Pseq([Plprand(0.0, 0.5, 1), Phprand(0.5, 1.0, 1)], inf),
//				flp: Pwhite(0, 1),
//				pan: Pmeanrand(0.25, 0.75),
//				hpf: 200,
//			])
//		).play
//	);
//};
//)
