echo "Welcome to Tic Tac Toe Game"

#CONSTANT
ROW=3
COLUMN=3

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
reset
