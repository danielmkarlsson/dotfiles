(
"killall scsynth".unixCmd;
s.options.numBuffers = 1024 * 64; // increase if you need to load more samples
s.options.memSize = 8192 * 256; // increase if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase if drop outs and the message "too many nodes"
s.options.sampleRate= 44100;
s.options.numOutputBusChannels = 2; // OUTPUT CHANNELS GO HERE
s.recSampleFormat = "int24";
s.options.numInputBusChannels = 2; // set to hardware input channel size, if necessary
s.latency = 0.1;

// boot the server and start SuperDirt

s.waitForBoot {
	~dirt = SuperDirt(2, s); // OUTPUT CHANNELS GO HERE ALSO DO NOT FORGET
	~dirt.loadSoundFiles; // load samples (path containing a wildcard can be passed in)
	s.sync; // wait for samples to be read
	~dirt.start(57120, [0,0]);
	// start listening on port 57120, create two orbits, each sending audio to channel 0.
	// You can direct sounds to the orbits from tidal e.g. by: `# orbit "0 1 1"
};
)