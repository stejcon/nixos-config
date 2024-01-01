{pkgs}: {
  battery = pkgs.writeShellScriptBin "script" ''
    cat /sys/class/power_supply/BAT0/capacity
  '';

  power = pkgs.writeShellScriptBin "power" ''
    entries=" Lock\n⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown\n󰜺 Cancel"

    selected=$(echo -e $entries|${pkgs.wofi}/bin/wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

    case $selected in
      lock)
        swaylock;;
      logout)
        hyprctl dispatch exit;;
      suspend)
        exec systemctl suspend;;
      reboot)
        exec systemctl reboot;;
      shutdown)
        exec systemctl poweroff -i;;
      cancel)
        return;;
    esac
  '';
}
