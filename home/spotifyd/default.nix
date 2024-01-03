{pkgs, ...}:
{
      services.spotifyd = {
        enable = true;
        package = pkgs.spotifyd.override {
          withMpris = true;
          withPulseAudio = true;
        };
        settings = {
          global = {
            backend = "alsa";
            device = "default";
            mixer = "PCM";
            volume-controller = "alsa";
            device_name = "Speaker";
            device_type = "speaker";
            bitrate = 320;
            no_audio_cache = true;
            volume-normalisation = true;
            normalisation-pregain = -10;
            initial_volume = "100";
          };
        };
      };
}
