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

function computerBlockLogic(){
	player=$1
 for (( i=0; i<$ROWNUMBER; i++ ))
 do
 if [[ ${board[$i,0]}${board[$i,1]} == $player$player ]]
 then
 if [[ ${board[$i,2]} == " " ]]
 then
 board[$i,2]="$computer"
 flag1="true"
	break
 fi
 elif [[ ${board[$i,1]}${board[$i,2]} == $player$player ]]
	then
	if [[ ${board[$i,0]} == " " ]]
	then
	board[$i,0]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[$i,2]}${board[$i,0]} == $player$player ]]
	then
	if [[ ${board[$i,0]} == " " ]]
	then
	board[$i,0]="$computer"
	flag1="true"
	break
	fi
	fi
	done
	for (( i=0; i<$COLUMNNUMBER; i++ ))
	do
	if [[ ${board[0,$i]}${board[1,$i]} == $player$player ]]
	then
	if [[ ${board[2,$i]} == " " ]]
	then
	board[2,$i]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[1,$i]}${board[2,$i]} == $player$player ]]
	then
	if [[ ${board[0,$i]} == " " ]]
	then
	board[0,$i]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[2,$i]}${board[0,$i]} == $player$player ]]
	then
	if [[ ${board[1,$i]} == " " ]]
	then
	board[1,$i]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[0,0]}${board[1,1]} == $player$player ]]
	then
	if [[ ${board[2,2]} == " " ]]
	then
	board[2,2]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[1,1]}${board[2,2]} == $player$player ]]
	then
	if [[ ${board[0,0]} == " " ]]
	then
	board[0,0]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[2,2]}${board[0,0]} == $player$player ]]
	then
	if [[ ${board[1,1]} == " " ]]
	then
	board[1,1]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[0,2]}${board[1,1]} == $player$player ]]
	then
	if	[[ ${board[2,0]} == " " ]]
	then
	board[2,0]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[1,1]}${board[2,0]} == $player$player ]]
	then
	if	[[ ${board[0,2]} == " " ]]
	then
	board[0,2]="$computer"
	flag1="true"
	break
	fi
	elif [[ ${board[2,0]}${board[0,2]} == $player$player ]]
	then
	if [[ $board[1,1]} == " " ]]
	then
	board[1,1]="$computer"
	flag1="true"
	break
	fi
	fi
	done
}

function computerWinLogic(){
	computer=$1
 for (( i=0; i<$ROWNUMBER; i++ ))
 do
 if [[ ${board[$i,0]}${board[$i,1]} == $computer$computer ]]
 then
 if [[ ${board[$i,2]} == " " ]]
 then
 board[$i,2]="$computer"
 flag="true"
	break
 fi
 elif [[ ${board[$i,1]}${board[$i,2]} == $computer$computer ]]
	then
	if [[ ${board[$i,0]} == " " ]]
	then
	board[$i,0]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[$i,2]}${board[$i,0]} == $computer$computer ]]
	then
	if [[ ${board[$i,0]} == " " ]]
	then
	board[$i,0]="$computer"
	flag="true"
	break
	fi
	fi
	done
	for (( i=0; i<$COLUMNNUMBER; i++ ))
	do
	if [[ ${board[0,$i]}${board[1,$i]} == $computer$computer ]]
	then
	if [[ ${board[2,$i]} == " " ]]
	then
	board[2,$i]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[1,$i]}${board[2,$i]} == $computer$computer ]]
	then
	if [[ ${board[0,$i]} == " " ]]
	then
	board[0,$i]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[2,$i]}${board[0,$i]} == $computer$computer ]]
	then
	if [[ ${board[1,$i]} == " " ]]
	then
	board[1,$i]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[0,0]}${board[1,1]} == $computer$computer ]]
	then
	if [[ ${board[2,2]} == " " ]]
	then
	board[2,2]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[1,1]}${board[2,2]} == $computer$computer ]]
	then
	if [[ ${board[0,0]} == " " ]]
	then
	board[0,0]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[2,2]}${board[0,0]} == $computer$computer ]]
	then
	if [[ ${board[1,1]} == " " ]]
	then
	board[1,1]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[0,2]}${board[1,1]} == $computer$computer ]]
	then
	if	[[ ${board[2,0]} == " " ]]
	then
	board[2,0]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[1,1]}${board[2,0]} == $computer$computer ]]
	then
	if	[[ ${board[0,2]} == " " ]]
	then
	board[0,2]="$computer"
	flag="true"
	break
	fi
	elif [[ ${board[2,0]}${board[0,2]} == $computer$computer ]]
	then
	if [[ $board[1,1]} == " " ]]
	then
	board[1,1]="$computer"
	flag="true"
	break
	fi
	fi
	done

}

function checkCornerCondition(){
	if [[ ${board[0,0]} == " " ]]
	then
	board[0,0]="$computer"
	flag2="true"
	elif [[ ${board[0,2]} == " " ]]
	then
	board[0,2]="$computer"
	flag2="true"
	elif	[[ ${board[2,0]} == " " ]]
	then
	board[2,0]="$computer"
	flag2="true"
	elif	[[ ${board[2,2]} == " " ]]
	then
	board[2,2]="$computer"
	flag2="true"
	fi
}

function checkCenter(){
	if [[ ${board[1,1]} == " " ]]
	then
	board[1,1]="$computer"
	flag3="true"
	fi
}

function checkWin(){
 playerinput=$1
 flag=false
	checkVertical $playerinput
	checkHorizontal $playerinput
	checkDiagonal $playerinput
}

function checkSides(){
	if [[ ${board[0,1]} == " " ]]
	then
	board[0,1]=$computer
	flag4="true"
	elif [[ ${board[1,0]} == " " ]]
	then
	board[1,0]=$computer
	flag4="true"
	elif [[ ${board[1,2]} == " " ]]
	then
	board[1,2]=$computer
	flag4="true"
	elif [[ ${board[2,1]} == " " ]]
	then
	board[2,1]=$computer
	flag4="true"
	fi
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
flag="false"

 count=1
tieCheck $playCount
 printf "\nComputer turn\n"
computerWinLogic $computer
	if [[ $flag == true ]]
	then
	boardShow
	printf "\ncomputer won"
	exit
	else
computerBlockLogic $player
	if [[ $flag1 == flase ]]
	then
checkCornerCondition
	if [[ $flag2 == flase ]]
	then
checkCenter
	if [[ $flag3 == false ]]
	then
	if [[ $flag4 == false ]]
	then
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
fi
fi
fi
fi
fi
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
boardShow

