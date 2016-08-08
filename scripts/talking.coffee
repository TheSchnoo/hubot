module.exports = (robot) ->

	robot.hear /moo|moopy/i, (res) ->
		res.send "Woof!"

	robot.hear /treat/i, (res) ->
		res.send("YAY TREATS!  I CAN'T WAIT TO SEE YOU!")