describe 'ADedoApp modules', () ->
	describe 'App Module', () ->
		it 'ADedoApp should be registered', () ->
			module = angular.module('ADedoApp')
			expect(module).not.to.be.null

		it 'ADedoApp.auth should be registered',() ->
			module = angular.module('ADedoApp.auth')
			expect(module).not.to.be.null

		it 'ADedoApp.home should be registered',() ->
			module = angular.module('ADedoApp.home')
			expect(module).not.to.be.null
