'use strict'
angular.module('ADedoApp')
.factory 'AjaxService', ['$rootScope','$http','$q',($rootScope,$http,$q) ->
	class Ajax
		constructor:(@url,@data,@type) ->
			if @url.indexOf('?') < 0
				@url = @url+'?format=json'
			else
				@url = @url+'&format=json'
		makeAjax: () ->
			deferred = $q.defer()
			$http({
				url:@url
				dataType:'json'
				method:@type
				data:@data
				headers:
					'Content-Type':'application/json'
			}).success (response) ->
				deferred.resolve(response.objects)
			.error (response) ->
				deferred.reject(response)

			deferred.promise
	class MakeAjax
		@get = (url) ->
			ajax = new Ajax(url,'','GET')
			ajax.makeAjax()


		@post = (url,data) ->
			ajax = new Ajax(url,data,'POST')
			ajax.makeAjax()

		@delete = (url) ->
			ajax = new Ajax(url,'','DELETE')
			ajax.makeAjax()

		@update = (url,data) ->
			ajax = new Ajax(url,data,'PUT')
			ajax.makeAjax()

]
