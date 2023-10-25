function bat
set CAP = $(cat /sys/class/power_supply/BAT0/capacity)
echo "$CAP%"
end
