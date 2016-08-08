module.exports = (robot) ->

	robot.hear /moki/i, (res) ->
		res.send "Woof!"

	robot.hear /treats/i, (res) ->
		res.send("YAY TREATS!  I CAN'T WAIT TO SEE YOU!")

	robot.hear /cute | pretty | small | fuzzy | moo/i (res) ->
		res.send "img/moki.jpg"