describe 'Main controller', ->
  beforeEach angular.mock.module 'ifasecure'

  controller = null
  scope = null
  ctrl = null
  dependencies = null
  firebaseMock = null

  beforeEach inject ($rootScope, $httpBackend, $injector, $controller) ->
    controller = $controller
    scope = $rootScope.$new()

    dependencies =
      $scope: scope

    ctrl = controller 'mainController', dependencies

  describe 'initializing', ->
    it 'puts sendContactInfo() on the scope', (done) ->
      expect(scope).to.have.property 'sendContactInfo'
      done()

    it 'puts and info object on the scope', (done) ->
      expect(scope).to.have.property 'info'
      expect(scope.info).to.have.property 'status'
      expect(scope.info.status).to.equal 'submitted'
      done()

  describe 'sendContactInfo()', (done) ->
    beforeEach (done) ->

      #stub the window.Firebase object so we can see 
      #whether it is constructed correctly
      sinon.stub window, 'Firebase'
      
      firebaseMock =
        push: sinon.stub()
      

      window.Firebase.returns firebaseMock

      done()

    afterEach (done) ->
      window.Firebase.restore()
      done()

    describe 'sucessful firebase push', ->
      beforeEach ->
        firebaseMock.push.callsArgWith 1, null
        scope.sendContactInfo()

      it 'is a function', (done) ->
        expect(scope.sendContactInfo).to.be.a 'function'
        done()

      it 'initialises firebase reference', (done) ->
        expect(Firebase.calledWith(firebaseURI + '/contactRequests')).to.be.true
        done()

      it 'pushes $scope.info into the firebase reference', (done) ->
        expect(firebaseMock.push.called, 'firebase mock not called').to.be.true
        expect(firebaseMock.push.calledWith scope.info).to.be.true
        done()

      it 'sets message in response to sucessful firebase push', (done) ->
        expect(scope.message).to.equal "your request has been recieved"
        done()

    describe 'failed firebase push', ->
      beforeEach ->
        firebaseMock.push.callsArgWith 1, "an error"
        scope.sendContactInfo()

      it 'sets message in response to failed firebase push', (done) ->
        expect(scope.message).to.equal "there was an error sending your request"
        done()
