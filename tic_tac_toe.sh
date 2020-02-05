echo "Welcome to Tic Tac Toe Game"

#CONSTANT
ROW=3
COLUMN=3

#VARIABLE
player=0

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
	echo "player has assign : $player"
}

#TOSS FOR WHO WILL PLAY FIRST
function tossForPlay()
{
	if [ $((RANDOM%2)) -eq 0 ]
	then
		echo "player play first"
	else
		echo "computer play first"
	fi
}

#DISPLAY THE TIC-TAC-TOE BOARD
function displayTheBoard()
{
   for (( i=0; i<$ROW; i++ ))
   do
      echo "-------------"
      for (( j=0; j<$COLUMN; j++ ))
      do
         echo -n "| ${board[$i,$j]} "
      done
      echo "|"
   done  
}
reset
assignSymbol
tossForPlay
displayTheBoard
