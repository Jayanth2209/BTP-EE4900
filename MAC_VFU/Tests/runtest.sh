#!/bin/sh

TOPMODULE="mkmac644p"
TOPFILE="mac644p"

bsc -u -verilog -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g $TOPMODULE $TOPFILE.bsv

bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g $TOPMODULE $TOPFILE.bsv
bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkTb Tb.bsv
bsc -e mkTb -sim -o Tb_bsim -keep-fires

./Tb_bsim

rm $TOPMODULE.b*
rm $TOPMODULE.c*
rm $TOPMODULE.h
rm $TOPMODULE.o
rm Tb.bo
rm Tb_*
rm mkTb*
rm $TOPFILE.bo
rm model*
