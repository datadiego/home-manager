PATH1=/etc/nixos/configuration.nix
PATH2="/home/datadiego/.config/home-manager/configuration.nix"

echo "Comparando $PATH1 con $PATH2"
diff $PATH1 $PATH2