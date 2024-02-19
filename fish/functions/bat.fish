function bat
set CAP = $(cat /sys/class/power_supply/BAT0/capacity)
set STA = $(cat /sys/class/power_supply/BAT0/status)
echo "$CAP% and $STA"
end
