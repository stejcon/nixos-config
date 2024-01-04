{pkgs, ...}: let 
  spotify-update = pkgs.writeShellScriptBin "update" ''
    # Get metadata using playerctl
    metadata=$(${pkgs.playerctl}/bin/playerctl metadata)

    # Extract relevant information
    art_url=$(echo "$metadata" | grep -m 1 'mpris:artUrl' | awk '{print $3}')
    title=$(echo "$metadata" | grep -m 1 'xesam:title' | awk '{for (i=3; i<=NF; i++) printf "%s ", $i; printf "\n"}')
    artist=$(echo "$metadata" | grep -m 1 'xesam:artist' | awk '{for (i=3; i<=NF; i++) printf "%s ", $i;}')

    # Download the image using curl
    tmp_image=$(mktemp /tmp/temp_image_XXXXXX.jpg)
    curl -o "$tmp_image" "$art_url"

    # Convert the downloaded image to PNG
    tmp_png=$(mktemp /tmp/temp_image_XXXXXX.png)
    convert "$tmp_image" "$tmp_png"

    # Display the notification with notify-send
    notify-send -i "$tmp_png" "Now Playing" "$title\nby $artist"

    # Clean up temporary files
    rm "$tmp_image" "$tmp_png"
  '';
  test-update = pkgs.writeShellScriptBin "update" ''
state="$PLAYER_EVENT"

datadir="$HOME/.local/state/spotifyd-metadata"
if [[ ! -d "$datadir" ]]; then
    mkdir -p "$datadir"
fi

data_log="$datadir/event-log"
data_status="$datadir/status"
data_metadata="$datadir/metadata"

function has_metadata {
  if [[ ! -f "$data_metadata" ]]; then
    return 1
  fi

  player_metadata="$(cat $data_metadata)"
  if [ ["$player_metadata" == ""] ]; then
    return 1
  fi
}

function update_metadata {
  contents="$(playerctl metadata)"
  echo "$contents" > $data_metadata
}

case "$state" in
  "change")
    echo "player status: change" >> $data_log
    update_metadata
  ;;
  "play")
    echo "player status: play" >> $data_log
    echo "playing" > $data_status
    has_metadata || update_metadata

    # Extract relevant information
    art_url=$(cat "$metadata" | grep -m 1 'mpris:artUrl' | awk '{print $3}')
    title=$(cat "$metadata" | grep -m 1 'xesam:title' | awk '{for (i=3; i<=NF; i++) printf "%s ", $i; printf "\n"}')
    artist=$(cat "$metadata" | grep -m 1 'xesam:artist' | awk '{for (i=3; i<=NF; i++) printf "%s ", $i;}')

    echo $art_url
    echo $title
    echo $artist

    # Download the image using curl
    tmp_image=$(mktemp /tmp/temp_image_XXXXXX.jpg)
    curl -o "$tmp_image" "$art_url"

    # Convert the downloaded image to PNG
    tmp_png=$(mktemp /tmp/temp_image_XXXXXX.png)
    convert "$tmp_image" "$tmp_png"

    # Display the notification with notify-send
    notify-send -i "$tmp_png" "Now Playing" "$title\nby $artist"

    # Clean up temporary files
    rm "$tmp_image" "$tmp_png"
  ;;
  "pause")
    echo "player status: pause" >> $data_log
    echo "paused" > $data_status
    has_metadata || update_metadata
  ;;
  "stop")
    echo "player status: stop" >> ~/data/spotify/status
    echo "stopped" > $data_status
    echo "" > $data_metadata
  ;;
  *)
    echo "event $state" >> $data_log
  ;;
esac
  '';
in {
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
        on_song_change_hook = "${test-update}/bin/update";
      };
    };
  };

  home.packages = with pkgs; [
    playerctl
  ];
}
