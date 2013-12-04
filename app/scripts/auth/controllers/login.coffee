'use strict'

app = angular.module('ADedoApp.auth')
app.controller 'LoginCtrl', [
	'$rootScope'
	'$location'
	'$scope'
	($rootScope,$location,$scope) ->
		$scope.login = () ->
			$rootScope.loadingView = true
			data = $scope.user_data
			# $rootScope.CurrentUser.login(data).finally () ->
			# 	$rootScope.loadingView = false
			# .then () ->
			# 	$location.path('/')
]
