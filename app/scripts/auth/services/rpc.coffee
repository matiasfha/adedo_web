'use strict'

angular.module('ADedoApp.auth')
.factory 'RpcService', ['$http','$q',($http,$q) ->
	class RPC
		constructor: (options) ->
			@rpcUrl = options.url
			@method = options.method
			@params = options.params || {}
			@setup()

		setup: () ->

			data =
				jsonrpc: "2.0"
				method : @method
				id     : Math.random()
			if (k for own k of @params).length isnt 0
				data.params = @params

			@data = JSON.stringify(data)

		execute:() ->
			$http({
				url:@rpcUrl,
				dataType:'json',
				method:'POST',
				data:@data,
				headers:{
					"Content-Type":"application/json"
				}
			})


	class MakeRpc
		@makeProc:(method,params={}) ->
			proc_options =
				url:'/api/v1/rpc'
				method:method
				params:params
			rpc = new RPC(proc_options)
			rpc.execute().then (response) ->
				if response.data?
					response.data.result
				else
					response.result
			,(response) ->
				if response.data?.error?
					$q.reject(response.data.error.message)
				else
					$q.reject(response.error.message)

		@login : (params) -> @makeProc("api.login",params),
		@logout : (params) -> @makeProc("api.logout",params),
		@getUser: (params) -> @makeProc("api.get_user",params),
		@resetPassword: (params) -> @makeProc("api.reset_password",params)
		@tokenLogin: (params) -> @makeProc("api.token_login",params)
]
