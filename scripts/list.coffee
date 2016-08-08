module.exports = (robot) ->
	pg = require('pg')
	#pg.defaults.ssl = true
	pg.connect(process.env.DATABASE_URL, step1 = (err, client) ->
		if err 
	  		throw err

	  	robot.respond /list/i, (res) ->
	  		client.query('SELECT COUNT(name) FROM groceries;').on('row', step2 = (row) -> res.send("Grocery Items: " + row.count))
	  		client.query('SELECT name FROM groceries;').on('row', step2 = (row) -> res.send(row.name))

		robot.respond /add to list (.*)/i, (res) ->
			itemToAdd = res.match[1]
			if itemToAdd != ""
				client.query("INSERT INTO groceries VALUES($1)", [itemToAdd])
				res.send("Added!")

		robot.respond /clear list/i, (res) ->
			client.query('DELETE FROM groceries')
			res.send("Did you remember to buy me something?")
		)