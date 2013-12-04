'uset strict'

app = angular.module('ADedoApp.auth')

window.SignupCtrl = app.controller 'SignupCtrl',[
	'$scope'
	'sedes',
	($scope,sedes) ->
		$scope.sedes = sedes
		$scope.registerUser = () ->
			$scope.registerForm.submitted = true
			if $scope.registerForm.$valid
				fd = new FormData()
				fd.append('uploadedFile',$scope.file)


		$scope.setFile = (element) ->
			$scope.file = element.files[0]

]

window.SignupCtrl.resolve =
	sedes: (AjaxService) -> AjaxService.get('/api/v1/resources/public_place/')


