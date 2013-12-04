'user strict'
app = angular.module('ADedoApp')

app.filter 'range', ->
	(input,min,max) ->
		min = parseInt(min)
		max = parseInt(max)
		input.push(i) for i in [min...max]
		input
