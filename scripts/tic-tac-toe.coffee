# Commands:
#   hubot sebastian tic-tac-toe - Starts a tic-tac-toe game with a familiar theme
#
# Tags:
#   fun

module.exports = (robot) ->

	CLEAR_BOARD =  [":black_square_button:", ":black_square_button:", ":black_square_button:",
					":black_square_button:", ":black_square_button:", ":black_square_button:",
					":black_square_button:", ":black_square_button:", ":black_square_button:"]

	counter = 0

	# gameGrid
	#
	# 0  1  2
	# 3  4  5
	# 6  7  8
	#

	gameGrid = CLEAR_BOARD
	
	robot.respond /reset game/i, (msg) ->
		resetGame gameGrid, msg

	robot.respond /tic-tac-toe/i, (msg) ->
		player1 = msg.message.user.name
		player2 = msg.message.user.name
		resetGame gameGrid, msg

	robot.hear /play (.*)/i, (msg) ->
		blankPiece = ":black_square_button:"
		gamePiece = ":black_square_button:"
		if counter % 2 == 0
			gamePiece = ":rabbit:"
		else
			gamePiece = ":frog:"
		placement = msg.match[1]
		gameGrid[placement-1] = gamePiece
		counter = counter + 1
		renderGame gameGrid, msg
		if counter > 4
			winner = checkWinner gameGrid, msg
			if winner == true
				msg.send "Winner!"
				counter = 0
				gameGrid = [":black_square_button:", ":black_square_button:", ":black_square_button:",
							":black_square_button:", ":black_square_button:", ":black_square_button:",
							":black_square_button:", ":black_square_button:", ":black_square_button:"]

	renderGame = (gameGrid, msg) ->
		msg.send gameGrid[0] + gameGrid[1] + gameGrid[2]
		msg.send gameGrid[3] + gameGrid[4] + gameGrid[5]
		msg.send gameGrid[6] + gameGrid[7] + gameGrid[8]

	checkWinner = (gameGrid) ->
		if checkHorizontal gameGrid or checkVertical gameGrid or checkDiagonal gameGrid
			return true
		else
			return false
		
		# winning combinations
		#	{0,1,2} {3,4,5} {6,7,8}
		#	{0,3,6} {1,4,7} {2,5,8}
		#	{0,4,8} {2,4,6}
		#

	checkHorizontal = (gameGrid) ->
		if gameGrid[0] == gameGrid[1] and gameGrid[1] == gameGrid[2] and gameGrid[0] != ":black_square_button:"
			return true
		if gameGrid[3] == gameGrid[4] and gameGrid[4] == gameGrid[5] and gameGrid[3] != ":black_square_button:"
			return true
		if gameGrid[6] == gameGrid[7] and gameGrid[7] == gameGrid[8] and gameGrid[6] != ":black_square_button:"
			return true
		else
			return false

	checkVertical = (gameGrid) ->
		if gameGrid[0] == gameGrid[3] and gameGrid[3] == gameGrid[6] and gameGrid[0] != ":black_square_button:"
			return true
		if gameGrid[1] == gameGrid[4] and gameGrid[4] == gameGrid[7] and gameGrid[1] != ":black_square_button:"
			return true
		if gameGrid[2] == gameGrid[5] and gameGrid[5] == gameGrid[8] and gameGrid[2] != ":black_square_button:"
			return true
		else
			return false

	checkDiagonal = (gameGrid) ->
		if gameGrid[0] == gameGrid[4] and gameGrid[4] == gameGrid[8] and gameGrid[0] != ":black_square_button:"
			return true
		if gameGrid[2] == gameGrid[4] and gameGrid[4] == gameGrid[6] and gameGrid[1] != ":black_square_button:"
			return true
		else
			return false

	resetGame = (gameGrid, msg) ->
		counter = 0
		gameGrid = [":black_square_button:", ":black_square_button:", ":black_square_button:",
					":black_square_button:", ":black_square_button:", ":black_square_button:",
					":black_square_button:", ":black_square_button:", ":black_square_button:"]
		renderGame gameGrid, msg