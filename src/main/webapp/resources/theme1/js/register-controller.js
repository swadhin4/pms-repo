chrisApp.controller('registerController', 
		 ['$rootScope', '$scope', '$filter','userService',
function  ($rootScope, $scope , $filter,userService) {

		$scope.customer={};	 
		$scope.responseMessage={};
		
	    $scope.saveCustomer=function(){
    		var customer=this;
    		var newCustomer = angular.copy($scope.customer);
    		customer.registerUser=function(){
	    		userService.registerUser(newCustomer)
	    		.then(function(data) {
	    			 console.log(data);
	    			 if(data.statusCode == 200){
	    				 $scope.responseMessage={
	    						 info:data.message,
	    						 color:"green"
	    				 };
	    				 $scope.customer.setPristine();
	    				 $scope.customer={};
	    			 }else{
	    				 $scope.responseMessage={
    						 info:data.message,
    						 color:"red"
	    			 	 };
	    			 }
	            },
	            function(data) {
	            	console.log(data)
	            	 $scope.responseMessage={
						 info:data.message,
						 color:"red"
   			 	    };
	            }); 	
	    	}
    		customer.registerUser();
      };
			 
}]);
