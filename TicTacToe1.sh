#!/bin/bash -x

ROWNUMBER=3
COLUMNNUMBER=3
TOTALCOUNT=9

function reset() {
 for (( row=0; row < $ROWNUMBER; row++ ))
 do
 for (( col=0; col < $COLUMNNUMBER; col++ ))
 do
 board[$row,$col]=" "
 done
 done
}
