{ config, pkgs, ... }:

{
networking.hostName = "nixos";
networking.networkmanager.enable = false;

networking.interfaces.lan0 = {
  useDHCP = false;
  ipv4.addresses = [ {
    address = "192.168.100.17";
    prefixLength = 24;
  } ];
};

networking.defaultGateway = "192.168.100.1";
networking.nameservers = ["1.1.1.1" "8.8.8.8"];

services.udev.extraRules = ''
  SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="52:54:00:5c:7c:74", NAME="lan0"
'';
}
