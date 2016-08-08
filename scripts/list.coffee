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

		robot.respond /remove (.*)/i, (res) ->
			itemToRemove = res.match[1]
			if itemToRemove != ""
				client.query("DELETE FROM groceries WHERE name=($1)", [itemToRemove])
				res.send("Added!")

		robot.respond /grocery help/i, (res) ->
			res.send "I love keeping track of groceries!"
			res.send "'list' means I'll tell you all the stuff to get"
			res.send "'add to list <something>' means I'll add that something to list"
			res.send "'remove <something>' means I'll remove it from the list"
			res.send "'clear list' means I'll remove everything from the list"
		)