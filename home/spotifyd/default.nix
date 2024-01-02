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
            username = "pkj258alfons";
            backend = "alsa";
            device = "default";
            mixer = "PCM";
            volume-controller = "alsa";
            device_name = "Speaker";
            device_type = "speaker";
            bitrate = 96;
            cache_path = ".cache/spotifyd";
            volume-normalisation = true;
            normalisation-pregain = -10;
            initial_volume = "50";
          };
        };
      };
}
