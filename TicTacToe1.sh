#!/bin/bash -x

ROWNUMBER=3
COLUMNNUMBER=3
TOTALCOUNT=9

#variables
randomCheck=$((RANDOM%2))
playcount=0

declare -A board

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
	playerTurn
 	else
 	echo "Computer has won the toss"
	computerTurn
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
 	printf "${board[$0row,$col]}"
 	fi
 	done
 	if (( row < 2 ))
	then
 	printf "\n----------\n"
 	fi
 	done
 	printf "\n"
}
function checkVertical(){
	playerinput=$1
	for ((row=0; row < $ROWNUMBER; row++))
	do
	for ((column=0; column < $COLUMNNUMBER; column++))
	do
	if [[ ${board[$row,$column]}${board[$(($row+1)),$column]}${board[$(($row+2)),$column]} == $playerinput$playerinput$playerinput ]]
	then
	flag=true
	echo "$flag"
	return
	fi
	done
	done
}

function checkHorizontal(){
	playerinput=$1
	for ((row=0; row<3; row++))
	do
	for ((column=0; column<3; column++))
	do
	if [[ ${board[$row,$column]}${board[$row,$(($column+1))]}${board[$row,$(($column+2))]} == $playerinput$playerinput$playerinput ]]
	then
	flag=true
	echo "$flag"
	return
	fi
	done
	done
}

function checkDiagonal(){
	playerinput=$1
	row=0
	column=0
	diagonal1=${board[$row,$column]}${board[$(($row+1)),$(($column+1))]}${board[$(($row+2)),$(($column+2))]}
	diagonal2=${board[$row,$(($column+2))]}${board[$(($row+1)),$(($column+1))]}${board[$(($row+2)),$column]}
	if [[ $diagonal1 == $playerinput$playerinput$playerinput || $diagonal2 == $playerinput$playerinput$playerinput ]]
	then
	flag=true
	echo "$flag"
	return
	fi
}

function checkWin(){
 playerinput=$1
 flag=false
	checkVertical $playerinput
	checkHorizontal $playerinput
	checkDiagonal $playerinput
}

function tieCheck(){
	playCount=$1
	if [[ $playCount == $TOTALCOUNT ]]
	then
	echo	"Match tie"
	exit
	fi
}

function playerTurn(){
	count=1
 	read -p "Player turn, Enter player position :" position
 	for (( i=0; i<$ROWNUMBER; i++ ))
 	do
 	for (( j=0; j<$COLUMNNUMBER; j++))
 	do
 	if [[ $count == $position ]]
 	then
 	if [[ ${board[$i,$j]} == " " ]]
 	then
 	board[$i,$j]=$player
 	else
 	printf "\nInvalid move,Enter again\n"
 	playerTurn
 	fi
 	fi
 	((count++))
 	done
 	done
		((playCount++))
 	boardShow
 	if [[ $(checkWin $player) == true ]]
 	then
 	printf "player won"
 	exit
 	fi
computerTurn
}
function computerTurn(){
flag="false"

 count=1
tieCheck $playCount
 printf "\nComputer turn\n"

for (( i=0; i<$ROWNUMBER; i++ ))
do
for (( j=0; j<$COLUMNNUMBER; j++ ))
 do
 if [[ $count == $position ]]
 then
 if [[ ${board[$i,$j]} == " " ]]
 then
 board[$i,$j]=$computer
 else
 printf "\nInvalid position by computer\n"
 computerTurn
 fi
	fi

((count++))
 done
 done
 ((playCount++))

boardShow
 if [[ $(checkWin $computer) == true ]]
 then
 printf "computer won"
 exit
 fi
 playerTurn
}


reset
assignLetter
Toss
board
boardShow


