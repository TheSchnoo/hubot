cronJob = require('cron').CronJob

module.exports = (robot) ->

  room = "#general"

  goodMorning = () ->
    robot.messageRoom room, 'Good morning!  I\'m thinking about you guys!'

  tz = 'America/Los_Angeles'
  console.log("room = #{room}")
  # new cronJob('0 9 * * *', goodMorning, null, true, tz)
  new cronJob('0 */5 * * *', goodMorning, null, true, tz)
