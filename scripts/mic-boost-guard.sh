#!/bin/sh
# Keep the ThinkPad analog mic chain at sane, non-clipping levels.
#
# WirePlumber/UCM resets these controls on startup and on every card change:
#   - "Mic Boost Volume" (numid 8) -> 3 (+30 dB), which clips the ADC hard
#   - "Capture Volume"   (numid 6) -> 63 (+30 dB), the hottest PGA setting
#
# This watcher re-applies a fixed, safe setting whenever ALSA reports a change.

CARD="${MIC_GUARD_CARD:-0}"
BOOST_NUMID="${MIC_BOOST_NUMID:-8}"
CAP_NUMID="${MIC_CAP_NUMID:-6}"
CAP_VALUE="${MIC_CAP_VALUE:-59}"   # 0..63, 59 = about 6 dB below max

# Wait for the sound card to appear.
while ! amixer -c "$CARD" cget numid="$BOOST_NUMID" >/dev/null 2>&1; do
    sleep 0.5
done

apply() {
    amixer -c "$CARD" cset numid="$BOOST_NUMID" 0,0 >/dev/null 2>&1 || true
    amixer -c "$CARD" cset numid="$CAP_NUMID" "$CAP_VALUE,$CAP_VALUE" >/dev/null 2>&1 || true
}

apply

# Re-apply whenever one of the guarded controls changes.
alsactl monitor 2>/dev/null | while IFS= read -r line; do
    case "$line" in
        *"Mic Boost Volume"*|*"Capture Volume"*) apply ;;
    esac
done
