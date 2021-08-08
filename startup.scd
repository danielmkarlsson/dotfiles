(
var sf64 = "Soundflower (64ch)"; // Shorten device names.
var sf2 = "Soundflower (2ch)";
var ka6 = "Komplete Audio 6 MK2";
var madi = "MADIface USB (23949544)";
var id14 = "Audient iD14";
//var inOut = Server.default.options;inOut.outDevice = sf64;inOut.inDevice = sf64; // Force device at startup.
//var inOut = Server.default.options;inOut.outDevice = sf2;inOut.inDevice = sf2;
//var inOut = Server.default.options;inOut.outDevice = ka6;inOut.inDevice = ka6;
//var inOut = Server.default.options;inOut.outDevice = madi;inOut.inDevice = madi;
//var inOut = Server.default.options;inOut.outDevice = id14;inOut.inDevice = id14;
//"killall scsynth".unixCmd;
s.options.numBuffers = 1024 * 64; // Increase this number if you need to load more samples.
s.options.numWireBufs = 128; // Increase if "exception in GraphDef_Recv: exceeded number of interconnect buffers."
s.options.memSize = 8192 * 256; // Increase if you get "alloc failed" messages.
s.options.maxNodes = 1024 * 32; // Increase if you get dropouts and the message "too many nodes".
s.options.sampleRate= 44100;
s.options.numOutputBusChannels = 2; // OUTPUT CHANNELS GO HERE.
//s.recSampleFormat = "float32";
s.recHeaderFormat="wav";
s.options.numInputBusChannels = 2; // Set to hardware input channel size, if necessary.
s.latency = 0.3;
MIDIClient.init; // Untoggle this when you want to do MIDI.
MIDIIn.connectAll; // Let SC talk to all of your MIDI inputs.
m = MIDIOut.new(0); // Maybe yours is different?
m.latency = 0.3; // Proly good to match s.latency value here.
thisProcess.platform.recordingsDir = "/Users/danielmkarlsson/sc-rec/"; // Choose recordings directory.

// scnvim connectivity.
if (\SCNvim.asClass.notNil) {
	Server.default.doWhenBooted {
		\SCNvim.asClass.updateStatusLine(1, 9670);
	}
};

// A simple triangle wave synth in stereo with panning and a simple low pass filter.
// This synthDef was written by Mads Kjeldgaard and requires the sc3 plugins.
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

s.waitForBoot {
	~clean = SuperClean(2, s); // Two output channels, increase if you want to pan across more channels.
	~clean.loadSoundFiles; // Hot swap in samples from anywhere!
	// For example: ~clean.loadSoundFiles("~/Downloads/rnb");
	s.sync; // Optionally: wait for samples to be read.
	//~clean.start((0,2..63)); // First 8 out looks like [0,2,4,6]
	~clean.start([0, 0]); // Most minimal output example.
	SuperClean.default = ~clean; // Make the clean key sequenceable inside of SuperCollider.
	"[ SuperClean up + running ]".postln;
};
)
