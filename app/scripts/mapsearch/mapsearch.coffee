app = angular.module('ADedoApp.mapsearch',[])
app.directive 'adedoMapSearch', ['$location',($location) ->
	return {
		restrict:'E'
		scope:true
		templateUrl:'views/mapsearch/mapsearch.html'
		link:(scope,elem,attrs) ->
			$('#boton-mapa').on 'click', () ->
				map = $('.map-container')
				if map.hasClass 'notVisible'
					map.animate {height:300},'slow', () ->
						map.removeClass('notVisible')
						$('.nugget-welcome').show()

				else
					$('.nugget-welcome').hide()
					map.animate {height:0},'slow', () ->
						map.addClass('notVisible')
						$('#boton-mapa').addClass('boton-mapa-back')



	}
]
