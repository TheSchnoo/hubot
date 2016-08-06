DATABASE_URL = "postgres://fapptvczzvewka:fNGq2xDWpeghPTy12PrvRZRa2b@ec2-54-243-190-100.compute-1.amazonaws.com:5432/d3j7svoq8l07ha"

step1 = (err, client) ->
  	if err 
  		throw err
  	console.log('Connected to postgres! Getting schemas...');
  	client
  	.query('SELECT table_schema,table_name FROM information_schema.tables;')
    .on('row', step2);

step2 = (row) ->
	console.log(JSON.stringify(row));

module.exports = (robot) ->
	pg = require('pg') 
	pg.defaults.ssl = true
	pg.connect(process.env.DATABASE_URL, step1)
	
	robot.respond /list/i, (res) ->
		res.send "wes"

	robot.respond /add to list/i, (res) ->
		res.send "list"
