# pci configuration
lspci

# motherboard and cpu configuration
sudo dmidecode -t baseboard
sudo dmidecode -t processor

# usb configuration
lsusb -t

# native thunderbolt support
sudo dmesg | grep -i thunderbolt

# show possible layouts and their possible configurations
# like display configuration in system settings but without a gui
xrandr --verbose
