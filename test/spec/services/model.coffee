describe 'ADedo Model Service', ->
	$httpBackend = null
	Model = null

	beforeEach ->
		module('ADedoApp')
		inject (_$httpBackend_, _Model_) ->
			$httpBackend = _$httpBackend_
			Model = _Model_



	it 'should return a Model class (not instance)', ->
		expect(Model).to.be.a('function')

	it 'should permit extend', ->
		class m extends Model
			constructor: ->

		expect(m.__super__).to.have.property('baseUrl')

	describe 'Model Service request actions', ->
		json_response =
			avatar: null
			bio: "",
			birth_date: null,
			email: "admin@a-dedo.cl",
			first_name: "Adam",
			gender: "",
			has_car: false,
			headquarter: "",
			id: "1",
			last_name: "Minier",
			phone: "",
			resource_uri: "/api/v1/resources/user/1/",
			username: "admin"
		model = null

		# beforeEach ->
		#   $httpBackend.expectPOST('/api/v1/resources/').respond(200,json_response)

		# afterEach  () ->
		# 	$httpBackend.verifyNoOutstandingExpectation()
		# 	$httpBackend.verifyNoOutstandingRequest()

		it 'should create new model without data without defaults', ->
			model = new Model()
			console.log(model.toJSON())
			expect(model.toJSON()).to.be.empty
