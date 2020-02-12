#! /bin/bash -x 

echo "Welcome to Tic Tac Toe Game"

#CONSTANT
ROW=3
COLUMN=3
MAXIMUMPLAYINGTURN=9

#VARIABLE
totalPlayingTurn=0
winner=1
flag=0
corner=false

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
tossForPlay
assignSymbol
displayTheBoard
#PLAYER  CAN CHOOSE VALID CELL
function playGame()
{
	while [[ $totalPlayingTurn -ne $MAXIMUMPLAYINGTURN ]]
	do
	if [[ $flag -eq 0 ]]
	then
		read -p "Row" row
		read -p "column" column
		if [[ ${board[$row,$column]} == "-" ]]
		then
			board[$row,$column]=$player
			displayTheBoard
			win
			((totalPlayingTurn++))
		else
			echo "place is occupied choose another place"
			playGame
		fi
		flag=1
	elif [[ $flag -eq 1 ]]
	then
		echo "computer played"
		playWinMove
		playWinMoveColumn
		playWinMoveDiagonal
		blockThePlayer
		if [[ $block == true ]]
		then
		corners
			if [[ $block == true ]]
			then
			center
				if [[ $block == true ]]
				then
				sides
					if [[ $block == true ]]
					then
					row=$((RANDOM%3))
					column=$((RANDOM%3))
			      		if [[ ${board[$row,$column]} == "-" ]]
 		  			then
      						board[$row,$column]=$computer
	            				displayTheBoard
						((totalPlayingTurn++))
					else
						playGame
					fi
				fi
			fi
		fi
	fi
	flag=0
	fi
	done
	if [[ $totalPlayingTurn -eq $MAXIMUMPLAYINGTURN ]]
     	then
		echo "!!!!!......Match Tie.....!!!!! "
		exit;
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
		winner=0
	fi
	if [[ ${board[$i,$j]} == $1 && ${board[$((i+1)),$j]} == $1 && ${board[$((i+2)),$j]} == $1 ]]
	then
		winner=0
	fi
	done
   done
	if [[ ${board[0,0]} == $1 && ${board[1,1]} == $1 && ${board[2,2]} == $1 ]]
	then
		winner=0
	fi
	if [[ ${board[2,0]} == $1 && ${board[1,1]} == $1 && ${board[0,2]} == $1 ]]
	then
		winner=0
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
			winner=0
		fi
		if [[ ${board[$i,$j]} == $computer && ${board[$i,$((j+1))]} == "-" && ${board[$i,$((j+2))]} == $computer ]]
  		then
			board[$i,$(( j+1 ))]=$computer
			winner=0
		fi
		if [[ ${board[$i,$j]} == $computer && ${board[$i,$((j+1))]} == $computer && ${board[$i,$((j+2))]} == "-" ]]
		then
    		board[$i,$(( j+2 ))]=$computer
			winner=0
		fi
	done
	win
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
			winner=0
		fi
   		if [[ ${board[$i,$j]} == $computer && ${board[$((i+1)),$j]} == "-" && ${board[$((i+2)),$j]} == $computer ]]
   		then
			board[$((i+1)),$j]=$computer
			winner=0
   		fi
   		if [[ ${board[$i,$j]} == $computer && ${board[$((i+1)),$j]} == $computer && ${board[$((i+2)),$j]} == "-" ]]
   		then
		   	board[$((i+2)),$j]=$computer
			winner=0
		fi
	done
	win
}
#WINNING MOVE FOR DIAGONAL
function playWinMoveDiagonal()
{
	if [[ ${board[0,0]} == "-" && ${board[1,1]} == $computer && ${board[2,2]} == $computer ]]
	then
		board[0,0]=$computer
		winner=0
	fi
	if [[ ${board[0,0]} == $computer && ${board[1,1]} == "-" && ${board[2,2]} == $computer ]]
  	then
		board[1,1]=$computer
		winner=0
   	fi
	if [[ ${board[0,0]} == $computer && ${board[1,1]} == $computer && ${board[2,2]} == "-" ]]
   	then
      		board[2,2]=$computer
		winner=0
   	fi
	if [[ ${board[0,2]} == "-" && ${board[1,1]} == $computer && ${board[2,0]} == $computer ]]
	then
      		board[0,2]=$computer
		winner=0
   	fi
   	if [[ ${board[0,2]} == $computer && ${board[1,1]} == "-" && ${board[2,0]} == $computer ]]
	then
      		board[1,1]=$computer
		winner=0
	fi
  	if [[ ${board[0,2]} == $computer && ${board[1,1]} == $computer && ${board[2,0]} == "-" ]]
  	then
      		board[2,0]=$computer
		winner=0
   	fi
	win
}
#CHECK WIN
function win()
{
	if [ $winner -eq 0 ]
	then
		echo "winner"
		displayTheBoard
		exit
	fi
}
#BLOCK THE WINNING PLAYER 
function blockThePlayer()
{
	block=true
	for (( p=0; p<$ROW; p++ ))
	do
	for (( k=0; k<$COLUMN; k++ ))
	do
		if [[ ${board[$p,$k]} == "-" ]]
		then
			board[$p,$k]=$player
			checkWinner $player
			if [ $winner -eq 0 ]
			then
				board[$p,$k]=$computer
				displayTheBoard
				winner=1
				((totalPlayingTurn++))
				block=false
				break;
			else
				board[$p,$k]="-"
			fi
		fi
	done
		if [[ $block == false ]]
		then
			break;
		fi
	done
}
#TAKE CORNER 
function corners()
{	
	block=true
	for (( row=0; row<$ROW; row+=2 ))
	do
	for (( column=0; column<$COLUMN; column+=2 ))
	do
		if [[ ${board[$row,$column]} == "-" ]]
		then
			board[$row,$column]=$computer
			displayTheBoard
			winner=1
			((totalPlayingTurn++))
			block=false
			break;
		fi
	done
	if [[ $block == false ]]
	then
		break;
	fi
	done
}
#IF CORNER NOT AVAILABLE THEN TAKE CENTER
function center()
{
	block=true
	if [[ ${board[1,1]} == "-"  ]]
	then
		board[$row,$column]=$computer
		displayTheBoard
		winnner=1
		((totalPlayingTurn++))
		block=false
		break;
	fi
	if [[ $block == false ]]
	then
		break;
	fi
}
#IF CORNER & CENTER NOT AVAILABLE THEN TAKE SIDE 
function sides()
{  
   block=true
   for (( sideRow=0; sideRow<$ROW; sideRow+=2 ))
   do
	sideColumn=1
	if [[ ${board[$sideRow,$sideColumn]} == "-" ]]
	then
            board[$sideRow,$sideColumn]=$computer
            displayTheBoard
            winner=1
            ((totalPlayingTurn++))
            block=false
            break;
	fi
	if [[ ${board[$sideColumn,$sideRow]} == "-" ]]
	then
		board[$sideColumn,$sideRow]=$computer
		displayTheBoard
		winner=1
		((totalPlayingTurn++))
		block=false
		break;
	fi
	if [[ $block == false ]]
      	then
         	break;
   	fi
   done
}
reset
playGame

