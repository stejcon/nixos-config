{pkgs}: {
  battery = pkgs.writeShellScriptBin "script" ''
    ${pkgs.acpi}/bin/acpi | awk '{print $4}' | sed s/%,//
  '';

  power = pkgs.writeShellScriptBin "power" ''
    sleep 0.1

    entries=" Lock\n⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown\n"

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
    esac
  '';
}
