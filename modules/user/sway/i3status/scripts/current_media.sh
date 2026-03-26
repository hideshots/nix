#!/bin/bash

PLAYER="spotify"

echo "" > /tmp/now_playing

playerctl -p "$PLAYER" metadata --format "{{ artist }} - {{ title }}" --follow 2>/dev/null | while read -r line; do
    if [ -n "$line" ]; then
        echo "$line" > /tmp/now_playing
    else
        echo "" > /tmp/now_playing
    fi
done
