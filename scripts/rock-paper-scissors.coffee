decideWinner = (choices) ->
	player1 = choices[0]
	throw1 = choices[1]
	player2 = choices[2]
	throw2 = choices[3]

	if throw1 == throw2
		choices.push('Tie')
		return 4
	if throw1 == 'paper' && throw2 == 'rock'
		return 0
	if throw1 == 'paper' && throw2 == 'scissors'
		return 2
	if throw1 == 'rock' && throw2 == 'paper'
		return 2
	if throw1 == 'rock' && throw2 == 'scissors'
		return 0
	if throw1 == 'scissors' && throw2 == 'rock'
		return 2
	if throw1 == 'scissors' && throw2 == 'paper'
		return 0

pushChoice = (username, choice, choices, player1, player2) ->
	if username != player1 and username != player2
		return
	if username in choices and player1 != player2
		return
	choices.push username
	choices.push choice

module.exports = (robot) ->
	urlBase = "https://slack.com/api/chat.postMessage?token=" + process.env.HUBOT_SLACK_TOKEN
	choices = []
	interval = 5000
	player1 = ""
	player2 = ""

	robot.respond /rock/i, (res) ->
		pushChoice(res.message.user.name, 'rock', choices, player1, player2)

	robot.respond /paper/i, (res) ->
		pushChoice(res.message.user.name, 'paper', choices, player1, player2)

	robot.respond /scissors/i, (res) ->
		pushChoice(res.message.user.name, 'scissors', choices, player1, player2)
	  	
	robot.respond /rps (.*)/i, (res) ->
		choices = []
		res.send("Game Time!")
		player1 = res.message.user.name
		player2 = res.match[1]
		message = "You're in a game!"
		if not /@/.exec player2
			url = urlBase + "&channel=@" + player2 + "&text=" + message
		else
			url = urlBase + "&channel=" + player2 + "&text=" + message
			player2 = player2.replace(/@/, '')
		robot.http(url).get() (err, res, body) ->
			if err
				console.log("Error")
		res.send(player1 + " challenges @" + player2 + " to Rock, Paper, Scissors!")
		res.send("Players, enter your choices!")
		res.send("(Message me with 'rock', 'paper', or 'scissors')")
		go = setInterval(
			func = () ->
				if choices.length > 3
					winner = decideWinner(choices)
					if winner == 4
						res.send("Tie")
					else
						res.send("Winner is " + choices[winner] + " with " + choices[winner+1] + "!")
					if choices[winner] == player2
						message = "You won!"
						url = urlBase + "&channel=@" + player2 + "&text=" + message
						robot.http(url).get() (err, res, body) ->
							if err
								console.log("Error")
					else 
						message = "You didn't win..."
						url = urlBase + "&channel=@" + player2 + "&text=" + message
						robot.http(url).get() (err, res, body) ->
							if err
								console.log("Error")
					choices = []
					clearInterval(go)
				else
					res.send "waiting..."
			# TODO add a listener for when choices is full.  This would be more responsive.
		, interval)
		