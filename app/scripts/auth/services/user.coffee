'use strict'

auth = angular.module('ADedoApp.auth')



auth.service 'User',['RpcService','$q',(RpcService,$q) ->

	class User
		constructor:(data) ->
			angular.extend(data,@)

		url: ->
			url = "/api/v1/resources/user/"
			if @attrs?.id
				url = "#{url}#{@attrs.id}"
			url

		getFullName: ->
			"#{@attrs.first_name} #{@attrs.last_name}"

		getAvatar: ->
			url = @attrs.avatar
			if url is null or url is undefined
				return '/img/missing_profile.png'
			return url

		getProfileUrl: ->
			"profile/#{@attrs.id}/"
		isLogged: ->
			JSON.stringify(@attrs) != '{}'


		addAvatar:(fileInput,options={}) ->
			if options.name?
				fileInput.attr('name',options.name)
			url = @url+"attach/?format=json"
			console.log url




]
