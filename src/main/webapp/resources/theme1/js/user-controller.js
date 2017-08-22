

chrisApp.controller('userController',  ['$rootScope', '$scope', '$filter', '$location','userService','authService',
                                        'companyService','registrationService','roleService','siteService',
                                        function ($rootScope, $scope , $filter,$location,userService,authService,
                                        companyService,registrationService,roleService,siteService) {
	$scope.selectedRow =0;
	$scope.user ={};
	$scope.appUsers=[];
	$scope.selectedUser ={};
		angular.element(document).ready(function(){
			 $scope.findAllUsers();
			 $scope.rowHighilited(0);
			 $scope.findLoggedInUserAccess();
			 $('#toggle-event').change(function() {
			      $('#console-event').html($(this).prop('checked'));
			      $('#enabledUser').val($(this).prop('checked'));
			      $scope.user.isEnabled=$(this).prop('checked');
			      console.log($scope.user);
			    });
			 $('.select2').select2()
		});
		
		$scope.rowHighilited=function(row){
	      $scope.selectedRow = row;    
	    }
		
		$scope.closeMessageWindow=function(){
			$('#messageWindow').hide();
			$('#successMessageDiv').hide();
			$('#errorMessageDiv').hide();
		}
		
		//---------------------X----------------------
		$scope.findAllUsers=function(){
		  $scope.getAllUsers();
	    };
		    
	    $scope.findLoggedInUserAccess=function(){
	    	$scope.getLoggedInUserAccess();
	    };
	    
	    $scope.addNewUser=function(){
	    	$('#resetAddUserForm').click();
	    //	$scope.getAllROCompanies();
	    	$scope.getAllRoles();
	    };
	    
	    $scope.saveNewUser=function(){
	    	//$scope.user.isEnabled = $('#enabledUser').val();
	    	console.log($scope.user);
	    	$scope.persistUser($scope.user);
	    };
	    $scope.getUserDetail=function(user){
	    	console.log(user)
	    	$scope.selectedUser = angular.copy(user);
	    };
		    
   //--------- Services Call from User Controller -------------------	
		    
		    $scope.getAllUsers=function(){
		    	
		    	//var appuser=this;
			  //  appuser.userList=[];
		    	//appuser.retrieveAllUsers=function(){
	    		userService.retrieveAllUsers()
	    		.then(function(data) {
	    			console.log(data)
	    			if(data.statusCode == 200){
	    				$scope.appUsers=[];
	    				$.each(data.object,function(key,val){
	    					var roleName ="";
	    					if(val.roleNames.length>0){
	    						var roles = val.roleNames[0].split(",");
	    						roleName=roles[1];
	    					}
	    					var userData={
	    							userId:val.userId,
	    							firstName:val.firstName,
	    							lastName:val.lastName,
	    							email:val.emailId,
	    							role:roleName,
	    							createdAt:val.createdAt,
	    							company:val.company
	    					}
	    					$scope.appUsers.push(userData);
	    					$scope.getUserDetail($scope.appUsers[0])
	    				});
	    				console.log($scope.appUsers)
	    			}
	            },
	            function(data) {
	                console.log('UserList retrieval failed.')
	            }); 	
		    	//}
		    	// appuser.retrieveAllUsers();
		    	
		    }
		    
		    $scope.getLoggedInUserAccess =function(){
			   // var authUser=this;
				//$scope.userAccessDetail={};
				//authUser.featureList={};
				//authUser.authorizeUserAccess=function(){
				authService.loggedinUserAccess()
	    		.then(function(data) {
	    			console.log(data)
	    			if(data.statusCode == 200){
	    				
	    			}
	            },
	            function(data) {
	                console.log('Unauthorized Access.')
	            }); 	
		    	//}
				//authUser.authorizeUserAccess();
		    }
		    
		    $scope.getAllROCompanies=function(){
		    	//var adminUser=this;
				$scope.roCompanyList=[];
				
				//adminUser.retrieveAllROCompanies=function(){
					companyService.retrieveAllROCompanies()
		    		.then(function(data) {
		    			console.log(data)
		    				
			    			$.each(data,function(key,val){
			    				$scope.roCompanyList.push(val);
			    			});
		            },
		            function(data) {
		                console.log('Unable to get company List')
		            }); 	
		    	//}
				//adminUser.retrieveAllROCompanies();
		    }
		    
		    $scope.getAllRoles=function(){
		    	//adminUser.retrieveRoles=function(){
		    	$scope.roles=[];
					roleService.retrieveRoles()
		    		.then(function(data) {
		    			console.log(data)
		    			if(data.statusCode == 200){	
		    			$.each(data.object,function(key,val){
		    				$scope.roles.push(val);
		    			});
		    			$('#createUserModal').modal('show');
		    			}
		            },
		            function(data) {
		                console.log('Unable to get role List')
		            }); 	
		    	//}
				//adminUser.retrieveRoles();
		    }
		    
		   
		    
		    $scope.persistUser=function(persitedUser){
		    	//var registerObj=this;
		    	//registerObj.registerUser=function(){
					registrationService.registerUser(persitedUser)
		    		.then(function(data) {
		    			console.log(data)
		    			if(data.statusCode == 200){
		    				$('#newUserCloseBtn').click();
		    				$('#messageWindow').show();
		    				$scope.successMessage = data.message;
		    				$('#successMessageDiv').show();
		    				$('#successMessageDiv').alert();
		    				$('#errorMessageDiv').hide();
		    				$scope.findAllUsers();
		    			}else{
		    				$scope.modalErrorMessage = data.message;
		    				$('#modalMessageDiv').show();
		    				$('#modalMessageDiv').alert();
		    				$('#errorMessageDiv').hide();
		    			}
		            },
		            function(data) {
		                console.log('Unable to register user')
		              $('#messageWindow').show();
		                $scope.errorMessage = data.message;
		                $('#successMessageDiv').hide();
		                $('#errorMessageDiv').alert();
		                $('#errorMessageDiv').show();
	    				
		            }); 	
		    	//}
		    	//registerObj.registerUser();
		    }
}]);
