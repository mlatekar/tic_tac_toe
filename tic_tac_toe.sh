#! /bin/bash 
echo "Welcome to Tic Tac Toe Game"
#CONSTANT
ROW=3
COLUMN=3
MAXIMUMPLAYINGTURN=9

#VARIABLE
totalPlayingTurn=0
winner=1
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
#ASSIGN LETTER AND TOSS TO PLAY
function assignSymbolAndTossToPlay()
{
	if [ $((RANDOM%2)) -eq  0 ]
	then
		echo "player play first"
		player="X"
		computer="O"
	else
		echo "your playing with computer"
		flag=1
		player="O"
		computer="X"
	fi
	echo "player has assign : $player  computer has assign :$computer"
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
assignSymbolAndTossToPlay
displayTheBoard

#GAME START 
function playGame()
{
	while [[ $totalPlayingTurn -ne $MAXIMUMPLAYINGTURN ]]
	do
		#PLAYER TURN
		playerTurn
		checkWinner $player
		flag=1
		#COMPUTER TURN
	  	echo "computer played"
		playWinMove
	   	playWinMoveColumn
	   	playWinMoveDiagonal
		smartComputer
		flag=0
	done
	if [[ $totalPlayingTurn -eq $MAXIMUMPLAYINGTURN ]]
     	then
		echo "!!!!!......Match Tie.....!!!!! "
		exit;
	fi
}
#PLAYER TURN
function playerTurn()
{
	if [[ $flag -eq 0 ]]
   then
      read -p "Row" row
      read -p "column" column
      if [[ ${board[$row,$column]} == "-" ]]
      then
         board[$row,$column]=$player
         displayTheBoard
         win $player
         ((totalPlayingTurn++))
      else
         echo "place is occupied choose another place"
         playGame
      fi
	fi
}
#COMPUTER TURN
function smartComputer()
{
if [[ $flag -eq 1 ]]
then
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
   	if [[ $mlatekar/tic_tac_toe/blob/master/tic_tac_toe.sh{board[0,2]} == $computer && ${board[1,1]} == "-" && ${board[2,0]} == $computer ]]
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
#CHECK WINNER
function win()
{
	if [ $winner -eq 0 ]
	then
		echo "winner"
		displayTheBoard
		exit
	fi
}
#BLOCK PLAYER
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
#TAKE CORNER TO PLAY
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
#TAKE CENTER TO PLAY
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
#TAKE SIDE TO PLAY
function sides()
{  
   block=true
   for (( sideRow=0; sideRow<$ROW; sideRow+=2 ))
   do
		sideColumn=1
     if [[ ${board[$sideRow,$sideColumn]} == "-" ]]
         then
				echo "hello"
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

