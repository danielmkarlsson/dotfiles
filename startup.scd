(
//"killall scsynth".unixCmd;
var sf64 = "Soundflower (64ch)"; // shorten device names.
var sf2 = "Soundflower (2ch)";
var bl2 = "BlackHole 2ch";
var ka6 = "Komplete Audio 6 MK2";
var madi = "MADIface USB (23949544)";
var id14 = "Audient iD14";
var motu = "MOTU UltraLite";
var inOut = Server.default.options; // shorten some server stuff
//inOut.outDevice = "Soundflower (2ch)";inOut.inDevice = "Soundflower (2ch)"; // force devices
//inOut.outDevice = sf2;inOut.inDevice = sf2; 
//inOut.outDevice = sf64;inOut.inDevice = sf64;
//inOut.outDevice = bl2;inOut.inDevice = bl2;
//inOut.outDevice = ka6;inOut.inDevice = ka6;
//inOut.outDevice = madi;inOut.inDevice = madi;
//inOut.outDevice = id14;inOut.inDevice = id14;
//inOut.outDevice = motu;inOut.inDevice = motu;
//s.volume = -0.01; // uncomment if you don't want to see the red light which indicates limiting in SuperClean?
s.options.blockSize = 64; // try increasing this up to 512 if you get drouputs on long files
s.options.bindAddress = "0.0.0.0";
s.options.numBuffers = 1024 * 64; // Increase this number if you need to load more samples.
s.options.numWireBufs = 128; // Increase if "exception in GraphDef_Recv: exceeded number of interconnect buffers"
s.options.memSize = 4096 * 256; // Increase if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // Increase if you get dropouts and the message "too many nodes"
s.options.sampleRate= 44100;
s.options.numOutputBusChannels = 2; // OUTPUT CHANNELS GO HERE
//s.recSampleFormat = "float32";
s.recSampleFormat = "int24";
s.recHeaderFormat= "wav";
s.options.numInputBusChannels = 0; // input channels can be zero if you only ever do output anyways
s.latency = 0.3;
//HID.findAvailable; // uncomment these lines when you want to do HID stuff
//HID.postAvailable;
//~myhid = HID.open( 1356, 3290 );
//HIDFunc.trace(true);
//MIDIClient.init; // uncomment this when you want to do MIDI
//MIDIIn.connectAll; // let SC talk to all of your MIDI inputs
//m = MIDIOut.new(0); // default to using to using the first connected midi device
//m.latency = 0.3; // Proly good to match s.latency value here
//MIDIFunc.trace(true); // trace all midi
thisProcess.platform.recordingsDir = "/Users/danielmkarlsson/sc-rec/"; // Choose SC recordings directory

// scnvim stuff
if (\SCNvim.asClass.notNil) {
	Server.default.doWhenBooted {
		\SCNvim.asClass.updateStatusLine(1, 9670);
	}
};

QtGUI.palette = QPalette.dark; // switch to night mode for floating windows like the meter for example

// a simple triangle wave synth in stereo with panning and a simple low pass filter
// this synthDef was written by Mads Kjeldgaard and requires the sc3 plugins
s.doWhenBooted{
	SynthDef.new(\default, {
		arg dur, attack=0.01, release=1.0,
		t_gate=1, out, freq=442, cutoff=5500,
		rq=1, pan=0.0, amp=0.5;

		var env = EnvGen.kr(Env.perc(attack, release), t_gate, timeScale: dur, doneAction: 2);
		var sig = DPW3Tri.ar(freq: freq, mul: env);
		sig = RLPF.ar(sig, cutoff.clip(20.0, 20000.0), rq.clip(0.0,1.0));
		sig = Pan2.ar(sig, pan);
		Out.ar(out, sig * amp);
	}).add;
};
/*
fork { // uncomment for multi client fun
	var cond, runResponder;
	s.options.bindAddress = "0.0.0.0";
	s.options.maxLogins = 8;
	o = ServerOptions.new;
	o.maxLogins = 12;
	o.bindAddress = "0.0.0.0";
	Server.default = s = Server.remote(\remote, NetAddr("169.254.66.79", 57110), o);
	// replace "169.254.66.79" with host IP on all computers
	// ethernet connections are far superior in terms of stability compared to WiFi connections
	cond = Condition({ s.serverRunning });
	// 'signal' will allow the forked routine to advance
	// only when 'serverRunning' finally becomes true
	runResponder = SimpleController(s).put(\serverRunning, { cond.signal });
	runResponder.remove;
	CmdPeriod.freeServers = false; // without this our twitchy reflexes will ruins everyone's fun
};
*/
s.waitForBoot {
	~clean = SuperClean(2, s); // two output channels, change if you want to pan across more channels.
	~clean.loadSoundFiles; // load the \mmd samples (only 10mb)
	// you can hotswap in samples from anywhere like this: ~clean.loadSoundFiles("~/Downloads/rnb");
	s.sync; // wait for the samples to be read before starting SuperClean and making outputs
	//~clean.start([0]); // most minimal output example.
	~clean.start([0, 0]); // multi aux stereo output example.
	//~clean.start([0, 2]); // Quad out
	//~clean.start([0, 2, 4, 6]); // Octaphonic out
	//~clean.start((0, 2 .. 62)); // 64 output channels
	SuperClean.default = ~clean; // Make the clean key sequenceable inside of SuperCollider.
	"[ SuperClean up + running ]".postln; // rejoice, everything is up + running
};
)
