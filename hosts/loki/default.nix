{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    ./hardware-configuration.nix
  ];
}
