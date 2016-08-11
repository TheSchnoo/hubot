module.exports = (robot) ->

	robot.hear /moo|moopy/i, (res) ->
		res.send "Woof!"

	robot.hear /treat/i, (res) ->
		res.send("YAY TREATS!  I CAN'T WAIT TO SEE YOU!")

	robot.hear /home|on my way/i, (res) ->
		res.send("I can't wait to see you!")
		res.send(":moki_smile:")

	#robot.respond //i, (res) ->
		#robot.http("https://slack.com/api/chat.postMessage?token=" + process.env.HUBOT_SLACK_TOKEN + "&file=F1YU0QRFA").get()
	#	console.log(res.message)
