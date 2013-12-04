'use strict'
app = angular.module('ADedoApp')

app.factory 'Model',['$http','$q',($http,$q) ->
	class Model
		constructor:(data) ->
			# if @defaults?
			# 	angular.extend(@attributes,@defaults)
			if data?
				angular.extend(@attributes,data)

		baseUrl:'/api/v1/resources/'
		attributes = {}

		request = (data,type) ->
			deferred = $q.defer()
			promise = $http({
				url:@url
				dataType:'json'
				method:type
				data:data
				headers:
					'Content-Type':'application/json'
			})
			promise.then (response) ->
				deferred.resolve(response.objects)
			promise.error (response) ->
				deferred.reject(response)

		fetch: (data) ->
			promise = request(data,'GET')
			promise.then (response) =>
				angular.extend @attributes,response

		save: (data) ->
			promise = request(data,'POST')
			promise.then (response) =>
				@attributes = data

		# Send all data to update (old and changes)
		update: (data) ->
			promise = request(data,'UPDATE')
			promise.then (response) =>
				@attributes = data

		destroy: ->
			promise = request('','DELETE')
			promise.then (response) =>
				@attributes = {}

		#Get attribute
		get: (attr) ->
			@attributes[attr]

		#Set attribute
		set:(key,val) ->
			if !key?
				@
			else
				@attributes[key] = val

		#Unset attribute
		unset:(attr) ->
			delete @attributes[attr]

		#Has attribute
		has:(attr) ->
			@get(attr)!=null

		toJSON: ->
			@attributes

		clear:->
			attrs = {}
			attrs[key] = undefined for key in @attributes
			@attributes = attrs



]
