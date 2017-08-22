
chrisApp.controller('loginController', 
		 ['$rootScope', '$scope', '$filter', '$location','userService',
	function ($rootScope, $scope , $filter,$location,userService) {
		$scope.user={};	 
		 var loggedInuser =null;
	    $scope.validateUser=function(){
	    		var appuser=this;
	    	    appuser.validatedUser={};
	    	    $scope.loader1=true;
		    	appuser.validateUser=function(){
		    		userService.validateUser( $scope.user.email, $scope.user.password)
		    		.then(function(data) {
		    			 $scope.savedUser = angular.copy(data);
		    			 $scope.savedUser.password="";
		    			 console.log(data);
		    			 $scope.user ={};
		    			 loggedInuser = $.jStorage.set('loggedInUser', $scope.savedUser);
		    			 $location.path('/userhome');
		            },
		            function(data) {
		               console.log(data)
		            }); 	
		    	}
		    appuser.validateUser();
	    };
	    
}]);

