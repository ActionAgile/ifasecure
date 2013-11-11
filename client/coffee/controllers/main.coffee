angular.module('ifasecure').controller 'mainController'
, ['$scope'
, ($scope) ->
  
  $scope.message = "This is a message from angular"

  $scope.info =
    status: 'submitted'

  $scope.sendContactInfo = () ->
    console.log 'in send contact Info'
    fire = new Firebase(firebaseURI  + '/contactRequests')
    fire.push $scope.info, (err) ->
      $scope.$apply () ->
        $scope.message = "your request has been recieved"
]