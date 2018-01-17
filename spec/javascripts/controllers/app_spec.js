describe('AppViewCtrl', function(){

var $controller;

  beforeEach(inject(function(_$controller_){
    $controller = _$controller_;
  }));

  describe('$scope.app', function(){
    it('should have an app, through the Apps service', function(){
      var $scope = {};
      var controller = $controller('AppViewCtrl', { $scope: $scope });
      expect($scope.app);
    });
  };

});
