describe 'ADedo.auth Rpc service', ->
	$httpBackend = null
	service = null
	userJSON = {}
	badPassword = {}
	access = {}
	beforeEach ->
		module('ADedoApp.auth')
		inject (_$httpBackend_, RpcService) ->
			$httpBackend = _$httpBackend_
			service = RpcService
		userJSON =
			result:
				token: "FXqiotohXJy-ii9fs8N8ON9PCuQC1M"
				api_key: "4bd98f7fd3b9785ac3a1c1305028c67df511bf91"
				avatar: "https://s3.amazonaws.com/a-dedo.cl.dev.local.uploads/avatar/000008.120x120.jpg"
				bio: ""
				birth_date: "1982-07-28"
				email: "test@a-dedo.cl"
				first_name: "Test"
				gender: "m"
				headquarter: "Sede 1"
				id: "1"
				last_name: "ADedo"
				phone: "01636288093"
				resource_uri: "/api/v1/resources/user/8/"
				username: "test@a-dedo.cl"
		badPassword =
			error:
				message: "WrongPassword: email o password incorrecto."
				code: 1
				data: null
				name: "WrongPassword"

		access =
			error:
				message: "InvalidCredentialsError: Invalid login credentials"
				code: 401
				data: null
				name: "InvalidCredentialsError"




	afterEach  () ->
		$httpBackend.verifyNoOutstandingExpectation()
		$httpBackend.verifyNoOutstandingRequest()


	it 'should return attrs with login', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)

		promise = service.login({user:'test@a-dedo.cl',password:'asdfghj'})

		expect(promise).to.not.be.rejected
		expect(promise).to.eventually.have.property('first_name')
		expect(promise).to.eventually.equal(userJSON.result)
		$httpBackend.flush()



	it 'should return error message on bad username/password', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(400,badPassword)
		promise = service.login({user:'bad@ba.cl',password:'1234566'})
		result = null
		promise.then (response) ->
			result = response
		, (response) ->
			result = response.data
		expect(promise).to.be.rejected
		expect(promise).to.eventually.not.have.property('first_name')
		expect(promise).to.eventually.equal(badPassword.error.message)
		$httpBackend.flush()


	it 'should return 401 (reject) if not logged', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(401,access)
		promise = service.getUser()
		expect(promise).to.be.rejected
		expect(promise).to.eventually.have.property('error',401)
		$httpBackend.flush()



	it 'should return the same user if was logged before', ->
		user = {}
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)
		promise = service.login({user:'test@a-dedo.cl',password:'asdfghj'})
		promise.then (response) ->
			user = response
		$httpBackend.flush()

		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)
		promise = service.getUser()
		expect(promise).to.not.be.rejected
		promise.then (response) ->
			expect(response).to.equal(user)
		$httpBackend.flush()


	it 'should logout successfully', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)
		service.login({user:'test@a-dedo.cl',password:'asdfghj'})
		$httpBackend.flush()

		logout_response = {jsonrpc: "2.0", id: 0.029002865077927709, "result": {}}
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,logout_response)
		promise = service.logout()
		expect(promise).to.not.be.rejected
		expect(promise).to.eventually.be.an('object')
		expect(promise).to.eventually.be.empty
		$httpBackend.flush()

	it 'should resetPassword successfully (aka send email)', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)
		service.login({user:'test@a-dedo.cl',password:'asdfghj'})
		$httpBackend.flush()

		response = {"jsonrpc": "2.0", "id": 0.3009736353997141, "result": null}
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,response)
		promise = service.resetPassword()
		expect(promise).to.eventually.be.null
		$httpBackend.flush()

	it 'should login using token if token is valid', ->
		$httpBackend.expectPOST('/api/v1/rpc').respond(200,userJSON)
		promise = service.tokenLogin({email:userJSON.result.email,token:userJSON.result.token})
		expect(promise).to.not.be.rejected
		expect(promise).to.eventually.have.property('first_name')
		expect(promise).to.eventually.equal(userJSON.result)
		$httpBackend.flush()



