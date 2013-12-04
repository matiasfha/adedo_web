module.exports = function(config) {
	config.set({
		basePath:'',
		frameworks:['mocha'],
		files: [
			'node_modules/chai/chai.js',
      		'test/lib/chai-should.js',
	  		'test/lib/chai-expect.js',
	  		'app/bower_components/angular/angular.js',
	  		'.tmp/scripts/mapsearch/**/*.js',
      		'.tmp/scripts/navbar/**/*.js',
	  		'.tmp/scripts/home/**/*.js',
			'.tmp/scripts/auth/**/*.js',
			'.tmp/scripts/*.js',
      		'.tmp/scripts/directives/**/*.js',
      		'.tmp/scripts/filters/**/*.js',
      		'.tmp/scripts/services/**/*.js',
			'test/midway/**/*.js'
		],
		exclude:[],
		port:8080,
		logLevel: config.LOG_INFO,
		autoWatch: false,
		browsers:['PhantomJS'],
		singleRun:false,
		color:true
	})
}
