echo "Welcome to Tic Tac Toe Game"

#CONSTANT
ROW=3
COLUMN=3

#VARIABLE
player=0


#DECLARE ARRAY
declare -a board

#RESET THE BOARD
function reset()
{
	for (( i=0; i<$ROW; i++ ))
	do
		for(( j=0; j<$COLUMN; j++ ))
		do
			board[$i,$j]=" "
		done
	done
}

function assignSymbol()
{
		if [ $((RANDOM%2)) -eq  0 ]
		then
			player="X"
		else
			player="O"
		fi
	echo "player has assign : $player"
}
reset
assignSymbol
