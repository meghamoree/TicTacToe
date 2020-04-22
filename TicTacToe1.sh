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

randomCheck=$((RANDOM%2))
	function assignLetter() {
	if (( $randomCheck == 0 ))
 	then
 		player="X"
 		computer="O"
 	else
		player="O"
 		computer="X"
 	fi
 	echo "Player has been assigned $player"
 	echo "Computer has been assigned $computer"

}
