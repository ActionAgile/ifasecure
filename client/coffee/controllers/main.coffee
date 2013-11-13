angular.module('ifasecure').controller 'mainController'
, ['$scope'
, ($scope) ->
  
  $scope.info =
    status: 'submitted'

  $scope.sendContactInfo = () ->
    fire = new Firebase(firebaseURI  + '/contactRequests')
    fire.push $scope.info, (err) ->
      $scope.$apply () ->
        if err?
          $scope.message = "there was an error sending your request"
        else
          $scope.message = "your request has been recieved"
]