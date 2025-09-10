#!/bin/sh

i3lock \
--blur 16 \
--bar-indicator \
--bar-pos y+h \
--bar-direction 1 \
--bar-max-height 50 \
--bar-base-width 50 \
--bar-color 000000cc \
--keyhl-color eeeeeecc \
--bar-periodic-step 50 \
--bar-step 50 \
--redraw-thread \
\
--clock \
--force-clock \
--time-pos x+30:y+h-100 \
--time-color eeeeeeff \
--date-pos tx:ty+30 \
--date-color eeeeeeff \
--date-align 1 \
--time-align 1 \
--ringver-color eeeeee88 \
--ringwrong-color ee000088 \
--status-pos x+5:y+h-8 \
--verif-align 1 \
--wrong-align 1 \
--verif-color ffffffff \
--wrong-color ffffffff \
--modif-pos -50:-50
