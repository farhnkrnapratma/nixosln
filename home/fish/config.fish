function fish_greeting
    fastfetch
end

function loopfetch
    while true
        clear
        sleep 0.5
        fastfetch
        sleep 5
    end
end

function syslogbar
    clear
    # Default interval is 3 seconds if not provided or invalid
    if test (count $argv) -gt 0
        set interval $argv[1]
    else
        set interval 3
    end

    # Ensure interval is a positive number (including decimals)
    if not string match -qr '^(0|[1-9][0-9]*)(\.[0-9]+)?$' -- $interval
        echo "Invalid interval: '$interval'. Must be a positive number."
        return 1
    end

    # Convert to float and check if it's > 0
    set interval_val (math "$interval")
    if test $interval_val -le 0
        echo "Invalid interval: '$interval'. Must be greater than 0."
        return 1
    end

    # Get active network interface
    set iface (ip route get 8.8.8.8 2>/dev/null | string match -r 'dev\s+(\S+)' | string split ' ')[-1]

    if test -z "$iface"
        echo "Unable to determine network interface."
        return 1
    end

    # Initial network counters
    set rx_prev (cat /sys/class/net/$iface/statistics/rx_bytes)
    set tx_prev (cat /sys/class/net/$iface/statistics/tx_bytes)
    set t_prev (date +%s)

    set counter 0

    while true
        set user (whoami)
        set host (hostname)

        # Battery
        set battery_path /sys/class/power_supply/BAT*
        set battery (cat $battery_path/capacity 2>/dev/null)
        set battery_status (cat $battery_path/status 2>/dev/null)

        # Other system info
        set datetime (date '+%H:%M:%S %d/%m/%Y')
        set kernel (uname -r)

        # Network rate
        set rx_now (cat /sys/class/net/$iface/statistics/rx_bytes)
        set tx_now (cat /sys/class/net/$iface/statistics/tx_bytes)
        set t_now (date +%s)
        set delta_t (math "$t_now - $t_prev")

        if test $delta_t -eq 0
            set rx_rate 0
            set tx_rate 0
        else
            set rx_rate (math --scale=1 "($rx_now - $rx_prev) / 1024 / $delta_t")
            set tx_rate (math --scale=1 "($tx_now - $tx_prev) / 1024 / $delta_t")
        end

        # Output
        echo -n (set_color blue)"$user "(set_color cyan)"$host "
        echo -n (set_color yellow)"$datetime "
        echo -n (set_color green)"$battery "
        echo -n (set_color brmagenta)"$kernel "
        echo -n (set_color red)"↑ $(printf "%.1f" $tx_rate) KB/s "
        echo -n (set_color red)"↓ $(printf "%.1f" $rx_rate) KB/s"
        echo (set_color normal)

        set rx_prev $rx_now
        set tx_prev $tx_now
        set t_prev $t_now

        sleep $interval
    end
end

alias b="z .."
alias c="clear"
alias d="rm -rf"
alias e="hx"
alias f="fd"
alias g="git"
alias j="jj"
alias l="eza -la"
alias s="sudo-rs"
alias t="hyperfine"
alias x="exit"
alias y="yazi"
alias ff="fastfetch"
alias gt="gitui"
alias jt="just"
alias tk="tokei"
alias wt="wiki-tui"
alias zl="zellij"
alias zn="zenith"
alias fishc="e ~/.homemanager/fish/config.fish && source ~/.config/fish/config.fish"

zoxide init fish | source
