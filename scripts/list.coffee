module.exports = (robot) ->
	pg = require('pg') 
	pg.defaults.ssl = true
	pg.connect(process.env.DATABASE_URL, step1 = (err, client) ->
  		if err 
  			throw err
  		console.log('Connected to postgres! Getting schemas...')
  		client
  		.query('SELECT table_schema,table_name FROM information_schema.tables;')
    	.on('row', step2 = (row) ->
			console.log(JSON.stringify(row))
	
	robot.respond /list/i, (res) ->
		res.send "wes"

	robot.respond /add to list/i, (res) ->
		res.send "list"
