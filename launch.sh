#!/usr/bin/env bash

# Terminate already running bar instances
killall .polybar-wrappe

# Wait until the processes have been shut down
while pgrep -x .polybar-wrappe >/dev/null; do sleep 1; done

# Launch polybar
polybar &
