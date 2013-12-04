app = angular.module('ADedoApp.navbar',[])
app.directive 'adedoMenu', ['$location',($location) ->
	return {
		restrict:'E'
		scope:true
		templateUrl:'views/navbar/navbar.html'
	}
]
