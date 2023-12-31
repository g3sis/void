=$(cat /sys/class/power_supply/BAT1/status)
		battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
		case "$battery_status" in
			Charging) echo 'B' "$(icon  0) ${battery_percent}";;
			Discharging)
			if [ "$battery_percent" -gt 80 ]
            then
            echo 'B' "$(icon  0) ${battery_percent}"
            elif [ "$battery_percent" -gt 30 ]
            then
            echo 'B' "$(icon  0) ${battery_percent}"
            else
            echo 'B' "$(icon  0) ${battery_percent}"
            fi
            ;;
        Unknown|Full) echo 'B' "$(icon  0) 100%";;
    esac
    sleep 30;
	done
}

clock > "$PANEL_FIFO" &
music > "$PANEL_FIFO" &
wifi > "$PANEL_FIFO" &
battery > "$PANEL_FIFO" &
bspc subscribe report > "$PANEL_FIFO" &

num_mon=$(bspc query -M | wc -l)

panel_bar() {
while read -r line ; do
	case $line in
		B*)
            # bat
            bat="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}";;
		N*)
            # net
            net="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}";;
		S*)
			# clock output
			sys="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}"
			;;
		M*)
			# music output
			mus="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}"
			;;
		W*)
			# bspwm's state
			wm=
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ] ; do
				item=$1
				name=${item#?}
				case $item in
					[mM]*)
						case $item in
							m*)
								# monitor
								FG=$COLOR_MONITOR_FG
								BG=$COLOR_MONITOR_BG
								on_focused_monitor=
								;;
							M*)
								# focused monitor
								FG=$COLOR_FOCUSED_MONITOR_FG
								BG=$COLOR_FOCUSED_MONITOR_BG
								on_focused_monitor=1
								;;
						esac
						[ $num_mon -lt 2 ] && shift && continue
						wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
						;;
					[fFoOuU]*)
						case $item in
							f*)
								# free desktop
								FG=$COLOR_FREE_FG
								BG=$COLOR_FREE_BG
								UL=$BG
								;;
							F*)
								if [ "$on_focused_monitor" ] ; then
									# focused free desktop
									FG=$COLOR_FOCUSED_FREE_FG
									BG=$COLOR_FOCUSED_FREE_BG
									UL=$BG
								else
									# active free desktop
									FG=$COLOR_FREE_FG
									BG=$COLOR_FREE_BG
									UL=$COLOR_FOCUSED_FREE_BG
								fi
								;;
							o*)
								# occupied desktop
								FG=$COLOR_OCCUPIED_FG
								BG=$COLOR_OCCUPIED_BG
								UL=$BG
								;;
							O*)
								if [ "$on_focused_monitor" ] ; then
									# focused occupied desktop
									FG=$COLOR_FOCUSED_OCCUPIED_FG
									BG=$COLOR_FOCUSED_OCCUPIED_BG
									UL=$BG
								else
									# active occupied desktop
									FG=$COLOR_OCCUPIED_FG
									BG=$COLOR_OCCUPIED_BG
									UL=$COLOR_FOCUSED_OCCUPIED_BG
								fi
								;;
							u*)
								# urgent desktop
								FG=$COLOR_URGENT_FG
								BG=$COLOR_URGENT_BG
								UL=$BG
								;;
							U*)
								if [ "$on_focused_monitor" ] ; then
									# focused urgent desktop
									FG=$COLOR_FOCUSED_URGENT_FG
									BG=$COLOR_FOCUSED_URGENT_BG
									UL=$BG
								else
									# active urgent desktop
									FG=$COLOR_URGENT_FG
									BG=$COLOR_URGENT_BG
									UL=$COLOR_FOCUSED_URGENT_BG
								fi
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B-}%{F-}%{-u}"
						;;
					[LTG]*)
						# layout, state and flags
						wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG} ${name} %{B-}%{F-}"
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{l}${wm}%{c}${mus}%{r}${net}${bat}${sys}"
done
}

panel_bar < "$PANEL_FIFO" | lemonbar -a 32 -u 2 -n "$PANEL_WM_NAME" -g 1066x$PANEL_HEIGHT+150+8 -f "$PANEL_FONT_0" -f "$PANEL_FONT_1" -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" | sh &

wid=$(xdo id -a "$PANEL_WM_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
