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

  describe 'initializing', ->
    it 'Sets message on scope', (done) ->
      ctrl = controller 'mainController', dependencies
      expect(scope.message).to.equal "This is a message from angular"
      done()