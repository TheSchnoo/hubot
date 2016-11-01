cronJob = require('cron').CronJob

module.exports = (robot) ->

  goodMorning = () ->
    console.log("moki")
    room = "#test"
    msgData =
      channel: room
      text: "Good morning!  I\'m thinking about you guys!"

    robot.emit 'slack-attachment', msgData

  tz = 'America/Los_Angeles'
  console.log("room = #{room}")
  new cronJob('0 9 * * *', goodMorning, null, true, tz)    # Set time for production
  # new cronJob('*/1 * * * *', goodMorning, null, true, tz)  # Every minute for testing
