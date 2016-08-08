module.exports = (robot) ->

	robot.hear /moki/i, (res) ->
		res.send "Woof!"

	robot.hear /treat/i, (res) ->
		res.send("YAY TREATS!  I CAN'T WAIT TO SEE YOU!")

	robot.hear /cute|pretty|small|fuzzy|moo/i, (res) ->
		res.send "Need I remind you..."
		res.send $('img/moki.jpg')