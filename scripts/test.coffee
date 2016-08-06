module.exports = (robot) ->

	robot.hear /moki/i, (res) ->
		res.send "Woof!"