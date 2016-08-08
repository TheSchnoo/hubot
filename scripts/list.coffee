#process.env.DATABASE_URL="postgres://basic:home@localhost:5432/test"

module.exports = (robot) ->
	
	pg = require('pg')
	pg.defaults.ssl = true
	
	robot.respond /list/i, (res) ->
		pg.connect(process.env.DATABASE_URL, step1 = (err, client) ->
  			if err 
  				throw err
  			client.query('select name from groceries;').on('row', step2 = (row) -> res.send(row.name))
  			)

	robot.respond /add to list (.*)/i, (res) ->
		itemToAdd = res.match[1]
		pg.connect(process.env.DATABASE_URL, step1 = (err, client) -> client.query("INSERT INTO groceries VALUES($1)", [itemToAdd]))
		res.send("Added!")