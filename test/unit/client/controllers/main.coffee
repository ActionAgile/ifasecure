describe 'Main controller', ->
  beforeEach angular.mock.module 'ifasecure'

  controller = null
  scope = null
  ctrl = null
  dependencies = null

  beforeEach inject ($rootScope, $httpBackend, $injector, $controller) ->
    controller = $controller
    scope = $rootScope.$new()

    dependencies =
      $scope: scope

    ctrl = controller 'mainController', dependencies

  describe 'initializing', ->
    it 'Sets message on scope', (done) ->
      expect(scope.message).to.equal "This is a message from angular"
      done()

    it 'puts sendContactInfo() on the scope', (done) ->
      expect(scope).to.have.property 'sendContactInfo'
      done()

  describe 'sendContactInfo()', (done) ->
    it 'is a function', (done) ->
      expect(scope.sendContactInfo).to.be.a 'function'
      done()
