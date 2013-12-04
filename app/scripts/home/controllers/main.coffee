'use strict';

window.mainCtrl = angular.module('ADedoApp.home').controller 'MainCtrl', [
	'$scope'
	'$rootScope'
	'$location'
	'AjaxService'
	'$q'
	'users'
	'articles'
	'upcomingTrips'
	'statistics'
	($scope,$rootScope,$location,AjaxService,$q,users,articles,upcomingTrips,statistics) ->
		#Security
		# if $rootScope.CurrentUser.attrs.id? <= 0
		# 	$location.path('/login')

		$q.all([users,articles,upcomingTrips,statistics]).then (results) ->
			$scope.users = results[0]
			$scope.articles = results[1]
			$scope.upcomingTrips = results[2]
			statistics =
				shared_trips_kms: 0
				shared_trips_count: 0
				co2_savings: 0
				money_savings: 0
			for s in results[3]
				if s.name of statistics
					results[3][s.name] = s.value
			$scope.statistics =
				co2_savings: results[3]['co2_savings']
				gas_savings: results[3]['money_savings']
				total_trips_count: results[3]['shared_trips_count']



		$scope.searchUser = ->
			AjaxService.get("/api/v1/resources/user/search/?q=#{$scope.user_search}").then (response) ->
				$scope.users = response
]

window.mainCtrl.resolve = {
	statistics :(AjaxService) -> AjaxService.get('/api/v1/resources/statistic/')
	upcomingTrips:(AjaxService) ->
		serialize = (obj, prefix) ->
			str = []
			for p of obj
				k = (if prefix then prefix + "[" + p + "]" else p)
				v = obj[p]
				if typeof v is "object"
					val = serialize(v, k)
				else
					val = encodeURIComponent(k) + "=" + encodeURIComponent(v)
				str.push val
			str.join "&"
		dateNow = ->
			date = new Date(Date.now())
			res  = date.getFullYear()
			res+='-'+date.getMonth()
			res+='-'+( if date.getDate() < 10 then '0'+date.getDate() else date.getDate())
			res+='T'+( if date.getHours() < 10 then '0'+date.getHours() else date.getHours())
			res+='-'+( if date.getMinutes() < 10 then '0'+date.getMinutes() else date.getMinutes())
			res+='-'+( if date.getSeconds() < 10 then '0'+date.getSeconds() else date.getSeconds())
		AjaxService.get("/api/v1/resources/trip/?method=upcoming&#{serialize({limit:5,now:dateNow()})}")
	users:(AjaxService) -> AjaxService.get('/api/v1/resources/user/')
	articles :(AjaxService) ->AjaxService.get('/api/v1/resources/article/')
}

