module.exports = (robot) ->

  robot.respond /sc\s*(.*):*\s+(.*)/i, (res) ->
    time = res.match[1]
    date = res.match[2]
    data = JSON.stringify({
      time:time,
      date:date
    });
    robot.http("https://star-climb.herokuapp.com/post1")
    # robot.http("http://localhost:9999/post1")
    .header('Content-Type', 'application/json')
    .post(data) (err, res, body) ->
      console.log(data)
      console.log(err)
