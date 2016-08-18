module.exports = (robot) ->

	robot.hear /moo|moopy/i, (res) ->
		res.send "Woof!"

	robot.hear /treat/i, (res) ->
		res.send("YAY TREATS!  I CAN'T WAIT TO SEE YOU!")

	robot.hear /home|on my way/i, (res) ->
		res.send("I can't wait to see you!")
		res.send(":moki_smile:")

	robot.catchAll (res) ->
		if res.message.user.name != robot.name
			res.send("Too busy...napping")
