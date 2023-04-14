#!/bin/sh

TOPMODULE="mkMAC"
TOPFILE="MAC"

bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkmac8 mac8.bsv
bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkmac16 mac16.bsv
bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkmac322p mac322p.bsv
bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkmac642p mac642p.bsv

bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g $TOPMODULE $TOPFILE.bsv
bsc -u -sim -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g mkTb Tb.bsv
bsc -e mkTb -sim -o Tb_bsim -keep-fires

bsc -u -verilog -elab -keep-fires -aggressive-conditions -no-warn-action-shadowing -g $TOPMODULE $TOPFILE.bsv

./Tb_bsim

rm mkmac8.b*
rm mkmac8.c*
rm mkmac8.h
rm mkmac8.o

rm mkmac16.b*
rm mkmac16.c*
rm mkmac16.h
rm mkmac16.o

rm mkmac322p.b*
rm mkmac322p.c*
rm mkmac322p.h
rm mkmac322p.o

rm mkmac642p.b*
rm mkmac642p.c*
rm mkmac642p.h
rm mkmac642p.o

rm $TOPMODULE.b*
rm $TOPMODULE.c*
rm $TOPMODULE.h
rm $TOPMODULE.o

rm mac8.bo
rm mac16.bo
rm mac322p.bo
rm mac642p.bo

rm $TOPFILE.bo

rm Tb.bo
rm Tb_*
rm mkTb*
rm model*
