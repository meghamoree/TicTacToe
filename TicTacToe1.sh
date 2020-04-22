#!/bin/bash -x

ROWNUMBER=3
COLUMNNUMBER=3
TOTALCOUNT=9

randomCheck=$((RANDOM%2))

function reset() {
        for (( row=0; row < $ROWNUMBER; row++ ))
        do
        for (( col=0; col < $COLUMNNUMBER; col++ ))
        do
        board[$row,$col]=" "
        done
        done
}
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
function Toss(){
 	if (( $randomCheck == 0 ))
 	then
	echo "Player has won the toss"
 	else
 	echo "Computer has won the toss"
 	fi
}

function boardShow(){
	 for (( row=0; row < $ROWNUMBER; row++ ))
	 do
 	 for (( col=0; col < $COLUMNNUMBER; col++ ))
 	 do
	 if (( col < 2 ))
 	 then
 	printf "${board[$row,$col]} | "
 	else
 	printf "${board[$row,$col]}"
 	fi
 	done
 	if (( row < 2 ))
	then
 	printf "\n----------\n"
 	fi
 	done
 	printf "\n"
}

reset
assignLetter
Toss
board
boardShow





