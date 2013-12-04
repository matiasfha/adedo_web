app = angular.module('ADedoApp')

# Directive to cath up if password Match or not
app.directive 'passwordMatch', [() ->
	return{
		restrict:'A'
		scope:true
		require:'ngModel'
		link: (scope,elem,attrs,ctrl) ->
			checker = () ->
				e1 = scope.$eval(attrs.ngModel) #first password
				e2 = scope.$eval(attrs.passwordMatch) #second password
				e1 == e2
			scope.$watch checker,(n) ->
				ctrl.$setValidity("unique",n)
	}
]

#
app.directive 'goto',['$location',($location) ->
	return {
		restrict:'A'
		scope:true
		link:(scope,elem,attrs) ->
			elem.on 'click', (event) ->
				event.stopPropagation()
				url = attrs.goto
				$location.path(url)
				scope.$apply()
	}
]

# Directive to show upload button in better style
app.directive 'uploadBtn', () ->
	return  {
		restrict:'E'
		scope:true
		template:"""
		<div class="btn btn-small" style="{{style}}" ng-click="selectFile()">
			Seleccione archivo
		</div>
		<input type="file" ng-model-instant id="fileToUpload" onchange="angular.element(this).scope().setFile(this)" />"""
		link:(scope,elem,attrs) ->
			scope.style = attrs.style
			scope.selectFile = ->
				document.getElementById('fileToUpload').click()

	}


app.directive 'ddLoaderMsg',() ->
	config =
		restrict:'E'
		replace:true
		scope:true
		template:"""
		<div class="loading-container" ng-show="loadingView">
			<div class="loading-div"></div>
			<div class="loading-spinner">
				<div class="ajaxLoading"></div>
				<p>Cargando...</p>
			</div>
		</div>"""




