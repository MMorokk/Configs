#!/usr/bin/env bash

# Terminate already running bar instances
#killall .polybar-wrappe

# Wait until the processes have been shut down
#while pgrep -x .polybar-wrappe >/dev/null; do sleep 1; done

# Launch polybar

#polybar &
#

#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
