#!/bin/sh
# Keep the ThinkPad analog mic boost at 0 dB.
# WirePlumber/UCM resets "Mic Boost Volume" (numid 8) to 3 (+30 dB) on
# startup and profile changes, which makes the mic clip and amplifies
# electrical noise. Watch ALSA events and re-apply 0 dB.

CARD="${MIC_BOOST_CARD:-0}"
NUMID="${MIC_BOOST_NUMID:-8}"

# Wait for the sound card to appear.
while ! amixer -c "$CARD" cget numid="$NUMID" >/dev/null 2>&1; do
    sleep 0.5
done

apply() {
    amixer -c "$CARD" cset numid="$NUMID" 0,0 >/dev/null 2>&1 || true
}

apply

# Re-apply whenever the boost control changes.
alsactl monitor 2>/dev/null | while IFS= read -r line; do
    case "$line" in
        *"Mic Boost Volume"*) apply ;;
    esac
done
