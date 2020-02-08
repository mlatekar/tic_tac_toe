#! /bin/bash
echo "Welcome to Tic Tac Toe Game"

#CONSTANT
ROW=3
COLUMN=3
MAXIMUMPLAYINGTURN=9

#VARIABLE
totalPlayingTurn=0
#player=0
flag=0

#DECLARE ARRAY
declare -A board

#RESET THE BOARD
function reset()
{
	for (( i=0; i<$ROW; i++ ))
	do
		for(( j=0; j<$COLUMN; j++ ))
		do
			board[$i,$j]="-"
		done
	done
}

#ASSIGN LETTER TO PLAYER
function assignSymbol()
{
	if [ $((RANDOM%2)) -eq  0 ]
		then
			player="X"
			computer="O"
		else
			player="O"
			computer="X"
		fi
	echo "player has assign : $player  computer has assign :$computer"
}

#TOSS FOR WHO WILL PLAY FIRST
function tossForPlay()
{
	if [ $((RANDOM%2)) -eq 0 ]
	then
		echo "player play first"
	else
		echo "your playing with computer"
		flag=1
	fi
}

#DISPLAY THE TIC-TAC-TOE BOARD
function displayTheBoard()
{
   for (( i=0; i<$ROW; i++ ))
   do
      echo "-----------"
      for (( j=0; j<$COLUMN; j++ ))
      do
         echo -n "| ${board[$i,$j]} "
      done
      echo "|"
   done  
}

#PLAER  CAN CHOOSE VALID CELL
function playGame()
{
	tossForPlay
	assignSymbol
	displayTheBoard
	while [[ $totalPlayingTurn -ne $MAXIMUMPLAYINGTURN ]]
	do
	if [[ $flag -eq 0 ]]
	then
		read -p "Row" row
		read -p "column" column
		if [[ ${board[$row,$column]} == - ]]
		then
			board[$row,$column]=$player
			displayTheBoard
			flag=1
			checkWinner $player
			((totalPlayingTurn++))
		else
			echo "place is occupied choose another place"
		fi
	elif [[ $flag -eq 1 ]]
        then
				playWinMove
				playWinMoveColumn
				playWinMoveDiagonal
				checkWinner $computer
            row=$((RANDOM%3))
            column=$((RANDOM%3))
            if [[ ${board[$row,$column]} == - ]]
               then
					   board[$row,$column]=$computer
                  echo "computer played"
                  displayTheBoard
						flag=0
                  checkWinner $computer
						((totalPlayingTurn++))
            fi
      fi
	done
	if [[ $totalPlayingTurn -eq $MAXIMUMPLAYINGTURN ]]
      then
         echo "!!!!!......Match Tie.....!!!!! "
   fi

}

#CHECK WINNER
function checkWinner()
{
   for (( i=0; i<$ROW; i++ ))
   do
      for (( j=0; j<$COLUMN; j++ ))
	do
	if [[ ${board[$i,$j]} == $1 && ${board[$i,$((j+1))]} == $1 && ${board[$i,$((j+2))]} == $1 ]]
	then
		echo "winner is : $1"
		displayTheBoard
		exit
	fi
	if [[ ${board[$i,$j]} == $1 && ${board[$((i+1)),$j]} == $1 && ${board[$((i+2)),$j]} == $1 ]]
	then
		echo "winner is : $1"
		displayTheBoard
		exit
	fi
	done
   done
	if [[ ${board[0,0]} == $1 && ${board[1,1]} == $1 && ${board[2,2]} == $1 ]]
	then
		echo "winner is : $1"
		displayTheBoard
		exit
	fi
	if [[ ${board[2,0]} == $1 && ${board[1,1]} == $1 && ${board[0,2]} == $1 ]]
	then
		echo "winner is : $1"
		displayTheBoard
		exit
	fi
}
#WINNING MOVE FOR ROW
function playWinMove()
{
	for (( i=0; i<$ROW; i++ ))
	do
	j=0
			if [[ ${board[$i,$j]} == "-" && ${board[$i,$((j+1))]} == $computer && ${board[$i,$((j+2))]} == $computer ]]
				then
					board[$i,$j]=$computer
			fi
			if [[ ${board[$i,$j]} == $computer && ${board[$i,$((j+1))]} == "-" && ${board[$i,$((j+2))]} == $computer ]]
   			then
					board[$i,$((j+1))]=$computer
			fi
			if [[ ${board[$i,$j]} == $computer && ${board[$i,$((j+1))]} == $computer && ${board[$i,$((j+2))]} == "-" ]]
            then
               board[$i,$((j+2))]=$computer
			fi
	done
}
#WINNING MOVE FOR COLUMN
function playWinMoveColumn()
{
	for (( j=0; j<$COLUMN; j++ ))
   do
   i=0
         if [[ ${board[$i,$j]} == "-" && ${board[$((i+1)),$j]} == $computer && ${board[$((i+2)),$j]} == $computer ]]
            then
               board[$i,$j))]=$computer
         fi
         if [[ ${board[$((i+1)),$j]} == $computer && ${board[$((i+1)),$j]} == "-" && ${board[$((i+2)),$j]} == $computer ]]
            then
               board[$((i+1)),$j]=$computer
         fi
         if [[ ${board[$i,$j]} == $computer && ${board[$((i+1)),$j]} == $computer && ${board[$((i+2)),$j]} == "-" ]]
            then
               board[$((i+2)),$j]=$computer
         fi
   done
}
#WINNING MOVE FOR DIAGONAL
function playWinMoveDiagonal()
{
	if [[ ${board[0,0]} == "-" && ${board[1,1]} == $computer && ${board[2,2]} == $computer ]]
		then
			board[0,0]=$computer
	fi
	if [[ ${board[0,0]} == $computer && ${board[1,1]} == "-" && ${board[2,2]} == $computer ]]
      then
         board[1,1]=$computer
   fi
	if [[ ${board[0,0]} == $computer && ${board[1,1]} == $computer && ${board[2,2]} == "-" ]]
      then
         board[2,2]=$computer
   fi
	if [[ ${board[0,2]} == "-" && ${board[1,1]} == $computer && ${board[2,0]} == $computer ]]
      then
         board[0,2]=$computer
   fi
   if [[ ${board[0,2]} == $computer && ${board[1,1]} == "-" && ${board[2,0]} == $computer ]]
      then
         board[1,1]=$computer
   fi
   if [[ ${board[0,2]} == $computer && ${board[1,1]} == $computer && ${board[2,0]} == "-" ]]
      then
         board[2,0]=$computer
   fi

}
reset
playGame
