'use strict';

ADedoApp = angular.module 'ADedoApp',[
	'ngRoute'
	'ADedoApp.auth'
	'ADedoApp.home'
]


ADedoApp.config [
	'$locationProvider'
	'$routeProvider'
	($locationProvider,$routeProvider) ->
		$locationProvider.html5Mode(false)
		$routeProvider
			.when('/login',{
				templateUrl: 'views/auth/login.html',
				controller:'LoginCtrl',
				title:'Login'
			})
			.when('/signup',{
				templateUrl:'views/auth/signup.html',
				controller:'SignupCtrl'
				title:'Signup'
				resolve: SignupCtrl.resolve
			})
			.when('/logout',{
				template:'&nbsp'
				controller:'LogoutCtrl'
			})
			.when('/',{
				templateUrl: 'views/home/main.html'
				controller:'MainCtrl'
				resolve: mainCtrl.resolve
				title:'Home'

			})
			.otherwise({
				templateUrl:'views/404.html'
			})
]

ADedoApp.run [
	'$rootScope'
	'$location'
	'$route'
	($rootScope,$location,$route) ->

		# $rootScope.CurrentUser = CurrentUser
		# CurrentUser.get().then (response) ->
		# 	$location.path('/')


		$rootScope.$on '$routeChangeStart', (event, next, current) ->
			# if $rootScope.CurrentUser.attrs.id? > 0
			# 	$location.path('/') if $location.path()!='/'
			# else
			# 	$location.path('/login') if $location.path()!='/login' and $location.path()!='/signup'
			$rootScope.loadingView = true

		$rootScope.$on '$routeChangeSuccess',(event,next,current) ->
			$rootScope.loadingView = false
			$rootScope.title = $route.current.title

]





