module.exports = (robot) ->

  room = "#general"

  goodMorning = () ->
    console.log('count')
    robot.messageRoom room, 'I will nag you every 5 minutes'

  cronJob = require('cron').CronJob
  tz = 'America/Los_Angeles'
  console.log(room)
  # new cronJob('0 9 * * *', goodMorning, null, true, tz)
  new cronJob('0 */5 * * *', goodMorning, null, true, tz)
