

chrisApp.controller('siteController',  ['$rootScope', '$scope', '$filter','siteService','authService',
                                        'siteCreationService','companyService','userService','districtService',
                                        'areaService','clusterService','countryService',
                              function  ($rootScope, $scope , $filter,siteService, authService,
                                        siteCreationService,companyService,userService,districtService,
                                        areaService,clusterService,countryService) {
		
		$scope.siteData={};
		$scope.sessionUser={};
		$scope.selectedArea={};
		$scope.area={
				selected:{},
				list:[]
		}
		$scope.district={
				selected:{},
				list:[]
		}
		$scope.cluster={
				selected:{},
				list:[]
		}
		$scope.salesTimes={
			selected:{},
			days:null,
			fromlist:[],
			toList:[]
		}
		$scope.deliveryTimes={
				selected:{},
				days:null,
				fromlist:[],
				toList:[]
		}
		angular.element(document).ready(function(){
			
			$scope.getLoggedInUserAccess();
			 $(".licensedate").datepicker({
				 format:'dd-mm-yyyy',
			 });
			 
			 var time=0.00;
				var daysList = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
				var dayLength=7;
				for(i=0;i<24;i++){
					time=time+1;
					
					$scope.salesTimes.fromlist.push({
						opId:null,
						days:daysList[7-dayLength],
						val:time+":00",
						text:time+":00"
					});
					$scope.salesTimes.toList.push({
						opId:null,
						days:daysList[7-dayLength],
						val:time+":00",
						text:time+":00"
					});
					
					$scope.deliveryTimes.fromlist.push({
						opId:null,
						days:daysList[7-dayLength],
						val:time+":00",
						text:time+":00"
					});
					$scope.deliveryTimes.toList.push({
						opId:null,
						days:daysList[7-dayLength],
						val:time+":00",
						text:time+":00"
					});
					dayLength=dayLength-1;
				}
			
		});
		
		
		 $scope.getLoggedInUserAccess =function(){
				authService.loggedinUserAccess()
	    		.then(function(data) {
	    			console.log(data)
	    			if(data.statusCode == 200){
	    				$scope.sessionUser=data;
	    				$scope.getLoggedInUser($scope.sessionUser);
	    				
	    			}
	            },
	            function(data) {
	                console.log('Unauthorized Access.')
	            }); 
				
		    }
		    
		$scope.getAllSites=function(){
			$scope.findAllSites();
		}
		
		
		
		$scope.getLoggedInUser=function(loginUser){
			userService.getLoggedInUser(loginUser)
    		.then(function(data) {
    			console.log(data)
    			if(data.statusCode == 200){
    				$scope.siteData ={};
    				$scope.sessionUser=angular.copy(data.object);
    				$scope.siteData.company=$scope.sessionUser.company;
    				$scope.getAllSites();
   				 	$('.dpedit').editableSelect();
    			}
            },
            function(data) {
                console.log('No User available')
            });
		}
		$scope.retrieveAllCountries=function(loginUser){
			countryService.retrieveAllCountries(loginUser)
    		.then(function(data) {
    			console.log(data)
    			if(data.length>0){
    				$.each(data,function(key,val){
    					if(val.countryId == val.countryId){
    						$scope.siteData.country=val;
    						return false;
    					}
    				})
    			}
    		},
    		 function(data) {
                console.log(data);
            });
		}
		$scope.getDistrictByCountry=function(loginUser){
			districtService.retrieveDistrictByCountry(loginUser)
    		.then(function(data) {
    			console.log(data)
    			if(data.statusCode == 200){
    				$scope.district.list=[];
    				$("#districtSelect").empty();
    				if(data.object.length>0){
    					$.each(data.object,function(key,val){
    						var district={
    								districtId:val.districtId,
    								districtCode:val.districtCode,
    								districtName:val.districtName
    						}
    						$scope.district.list.push(district);
    					});
    					var options = $("#districtSelect");
    					options.append($("<option />").val(0).text("Select District"));
    					$.each($scope.district.list,function() {
    						options.append($("<option />").val(	this.districtId).text(this.districtName));
    					});
    					if($scope.selectedSite!=null){
    					 $("#districtSelect option").each(function() {
    							if ($(this).val() == $scope.selectedSite.district.districtId) {
    								$(this).attr('selected', 'selected');
    							return false;
    							}
    					 	});
    					}
    				}
    			}
            },
            function(data) {
                console.log(data)
            });
		}
		
		$scope.getArea=function(){
			areaService.retrieveAllAreas()
    		.then(function(data) {
    			console.log(data)
    				$scope.area.list=[];
    			$("#areaSelect").empty();
    				if(data.length>0){
    					$.each(data,function(key,val){
    						var area={
    								areaId:val.areaId,
    								areaName:val.areaName,
    						}
    						$scope.area.list.push(area);
    					});
    					var options = $("#areaSelect");
    					options.append($("<option />").val(0).text("Select Area"));
    					$.each($scope.area.list,function() {
    						options.append($("<option />").val(	this.areaId).text(this.areaName));
    					});
    					if($scope.selectedSite!=null){
       					 $("#areaSelect option").each(function() {
       							if ($(this).val() == $scope.selectedSite.area.areaId) {
       								$(this).attr('selected', 'selected');
       							return false;
       							}
       					 	});
       					}
    				}
            },
            function(data) {
                console.log(data)
            });
		}

		$scope.getCluster=function(){
			clusterService.retrieveAllClusters()
    		.then(function(data) {
    			console.log(data)
    				$scope.cluster.list=[];
    			$("#clusterSelect").empty();
    				if(data.length>0){
    					$.each(data,function(key,val){
    						var cluster={
    								clusterID:val.clusterID,
    								regionId:val.regionId,
    								districtId:val.districtId,
    								countryId:val.countryId,
    								areaId:val.area,
    								clusterName:val.clusterName,
    								clusterDesc:val.clusterDesc
    						}
    						var districtId = $("#districtSelect").val();
    						var areaId = $("#areaSelect").val();
    						var countryId = $scope.sessionUser.company.countryId;
    						if(districtId==0 || areaId == 0){
    							
    						}else{
    							if(cluster.countryId == countryId && cluster.districtId == parseInt(districtId) 
    									&& cluster.areaId == parseInt(areaId)){
    								$scope.cluster.list.push(cluster);
    							}
    						}
    					});
    					
    					var options = $("#clusterSelect");
    					options.append($("<option />").val(0).text("Select Cluster"));
    					$.each($scope.cluster.list,function() {
    						options.append($("<option />").val(	this.clusterID).text(this.clusterName));
    					});
    					if($scope.selectedSite!=null){
    					 $("#clusterSelect option").each(function() {
    							if ($(this).val() == $scope.selectedSite.cluster.clusterID) {
    								$(this).attr('selected', 'selected');
    							return false;
    							}
    					 	});
    					}
    				}
            },
            function(data) {
                console.log(data)
            });
		}
		
		
		$scope.getAllCompanies=function(){
		}
		
		$scope.findAllSites=function(){
			siteService.retrieveAllSites()
			.then(function(data) {
    			console.log(data)
    				$scope.siteList=[];
    				if(data.length>0){
    					$.each(data,function(key,val){
    						$scope.siteList.push(val);
    						$scope.getSiteDetails($scope.siteList[0]);
    					});
    					
    				}else{
    					console.log("No sites assigned to the user.")
    					$('#messageWindow').hide();
	    				$('#infoMessageDiv').hide();
    				}
            },
            function(data) {
                console.log(data)
                	$scope.InfoMessage="No sites assigned to the user."
					$('#messageWindow').show();
    				$('#infoMessageDiv').show();
    				$('#infoMessageDiv').alert();
            });
		}
		
		//License related logic
		$scope.licenseDetails = [
	      {
	        'licenseName':'',
	        'validfrom':'',
	        'validto':''
	    }];
	              			 
		$scope.addNewLicense = function(licenseDetails){
			 $scope.licenseDetails.push({ 
			  'licenseName': "", 
			  'validfrom': "" ,
			  'validto': "",
			 });
			 $scope.LD = {};
			 
			 $(".licensedate").datepicker("destroy");
		};
			 
		$scope.removeLicense = function(){
			  var newDataList=[];
			  $scope.selectedAll = false;
			  angular.forEach($scope.licenseDetails, function(selected){
			      if(!selected.selected){
			         newDataList.push(selected);
			       }
			    }); 
			   $scope.licenseDetails = newDataList;
		};
		   
    $scope.checkAllLicense = function () {
    	if (!$scope.selectedAll) {
		   $scope.selectedAll = true;
		  } else {
		    $scope.selectedAll = false;
		     }
		   angular.forEach($scope.licenseDetails, function(licenseDetail) {
			   licenseDetail.selected = $scope.selectedAll;
		    });
		 };


		//Sales Operation and delivery operation details//
		              			 
	$scope.operatingTimes = [		                         
  			 { id: 1,name: '1:00'},
             {id: 2, name: '2:00'},
             {id: 3, name: '3:00' },
             {id: 4, name: '4:00' },
             {id: 5, name: '5:00' },
             {id: 6, name: '6:00' },
             {id: 7, name: '7:00' },
             {id: 8, name: '8:00' },
             {id: 9, name: '9:00' },
             {id: 10,name: '10:00' },
             {id: 11,name: '11:00' },
             {id: 12,name: '12:00' },
             {id: 13, name: '13:00'},
             {id: 14, name: '14:00'},
             {id: 15, name: '15:00'},
             {id: 16, name: '16:00'},
             {id: 17, name: '17:00'},
             {id: 18, name: '18:00'},
             {id: 19, name: '19:00'},
             {id: 20, name: '20:00'},
             {id: 21, name: '21:00'},
             {id: 22, name: '22:00'},
             {id: 23, name: '23:00'},
             {id: 24, name: '24:00'},
		   ];
		              
		              
		              			 
	$scope.salesoperationDetails = [
        {
        	 "opId":null,
            'days':'Monday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Tuesday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Wednesday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Thursday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Friday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Saturday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Sunday',
            'from':'',
            'to':''
        }
       ];
		              			
		             //Delivery Operation details
 $scope.deliveryoperationDetails = [
        {
        	 "opId":null,
            'days':'Monday',
            'from':'',
            'to':''
            
        },
        {
        	 "opId":null,
            'days':'Tuesday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Wednesday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Thursday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Friday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Saturday',
            'from':'',
            'to':''
        },
        {
        	 "opId":null,
            'days':'Sunday',
            'from':'',
            'to':''
        }];
		    
 		$scope.setStartTime=function(value,targetId, from){
 			var selectedStartTime = value.from;	
 			$("#"+targetId+""+from).val(selectedStartTime.name)
 			$("#"+targetId+""+from).attr("style","background-color:#5ccaae;color:#fff")
 		}
 		
 		$scope.setEndTime=function(value,targetId,to){
 			var selectedEndTime = value.to;	
 			$("#"+targetId+""+to).val(selectedEndTime.name);
 			$("#"+targetId+""+to).attr("style","background-color:#5ccaae;color:#fff")
 		}
 
 
 		
		$scope.changeOperationTime = function(operatingTime) {
	        $scope.myTime = operatingTime;    
	    };
		              			 
		             //Submeter details
		$scope.submeterDetails = [{
	        'subMeterNumber': '',
	        'subMeterUser':''
	        
	    }];
		
		$scope.defaultSalesOps = angular.copy($scope.salesoperationDetails);
 		$scope.defaultDeliveryOps = angular.copy($scope.deliveryoperationDetails);
 		$scope.defaultsSubmeterDetails = angular.copy($scope.submeterDetails);
 		
		              			 
		$scope.addNewSubmeter = function(submeterDetails){
			 $scope.submeterDetails.push({ 
			  'subMeterNumber': '', 
			 'subMeterUser': ''				 
			 });
			 $scope.SD = {};
		 };
		              				 
		 $scope.removeSubmeter = function(){
			  var newDataList=[];
			  $scope.selectedAll = false;
			  angular.forEach($scope.submeterDetails, function(selected){
			      if(!selected.selected){
			         newDataList.push(selected);
			       }
			    }); 
			        $scope.submeterDetails = newDataList;
		  };
		              			   
  	    $scope.checkAllSubmeter = function () {
  	    	if (!$scope.selectedAll) {
  			   $scope.selectedAll = true;
  			  } else {
  			    $scope.selectedAll = false;
  			     }
  			   angular.forEach($scope.submeterDetails, function(submeterDetail) {
  				   submeterDetail.selected = $scope.selectedAll;
  			    });
  	    };
  	    
  	    
  	    
  	  $scope.addNewSite=function(){
  		  $scope.onedit=false;
  		$scope.siteData={};
  		  $('#siteModalLabel').text("Create New Site");
			$scope.getAllCompanies()
			//$scope.getLoggedInUser($scope.sessionUser);
			//$scope.getAreaByDistrict();
			//$scope.getClusterByArea();
			$scope.retrieveAllCountries($scope.sessionUser);
			$scope.getDistrictByCountry($scope.sessionUser);
			//$scope.selectedSite.district=null;
			$scope.getArea();
			//$scope.selectedSite.area=null;
			$scope.getCluster();
			//$scope.selectedSite.cluster=null;
			$scope.licenseDetails=[];
			
			//$scope.salesoperationDetails=$scope.defaultSalesOps;
			//$scope.deliveryoperationDetails=$scope.defaultDeliveryOps;
			
			
			$scope.submeterDetails = [];
			$('#createSiteModal').modal('show');
		}
  	    
  	    $scope.salesOperations=[];
  	    $scope.deliveryOperations=[]; 
  	    
  	    $scope.getSelectedDistrict=function(district){
	    	$scope.siteData.district = district;
	    }
  	    
  	    $scope.getSelectedArea=function(area){
  	    	$scope.siteData.area = area;
  	    }
  	    
  	    $scope.getSelectedCluster=function(cluster){
	    	$scope.siteData.cluster = cluster;
	    }
  	    
	    $scope.saveSiteForm=function(formObj){
	    	$scope.salesOperations=[];
	    	$scope.deliveryOperations=[];
	    	for(var i=0;i<7;i++){
	    		var salesStartTime= $("#salesDayFrom"+i).val();
	    		var salesEndTime=$("#salesDayTo"+i).val();
	    		
	    		var deliveryStartTime= $("#deliveryDayFrom"+i).val();
	    		var deliveryEndTime=$("#deliveryDayTo"+i).val();
	    			    						
	    				
	    		var salesDayIndex={
	    				opId:$scope.salesoperationDetails[i].opId,
	    				days:$scope.salesoperationDetails[i].days,
	    				from:salesStartTime,
	    				to:salesEndTime,
	    		}
	    		$scope.salesOperations.push(salesDayIndex);
	    		
	    		var deliveryDayIndex={
	    				opId:$scope.deliveryoperationDetails[i].opId,
	    				days:$scope.deliveryoperationDetails[i].days,
	    				from:deliveryStartTime,
	    				to:deliveryEndTime,	
	    		}
	    		$scope.deliveryOperations.push(deliveryDayIndex);
	    	}
	    	$scope.siteData.operator = $scope.sessionUser.company;
	    	var finalSiteObj = {
	    			siteData: $scope.siteData,
	    			siteLicense:$scope.licenseDetails,
	    			siteOperation:$scope.salesOperations,
	    			siteDelivery:$scope.deliveryOperations,
	    			siteSubmeter:$scope.submeterDetails,
	    			createdBy:$scope.sessionUser.loggedInUserMail
	    	
	    	};
	    	console.log(finalSiteObj);
	    	var isOperationDetails = false;
	    	if(finalSiteObj.siteOperation.length==7){
		    	$.each(finalSiteObj.siteOperation,function(key,val){
		    		if(val.from == "" && val.to==""){
		    				$('#modalMessageDiv').show();
		    				$('#messageWindow').hide();
		    				$('#successMessageDiv').hide();
		    				$('#errorMessageDiv').show();
		    				$('#errorMessageDiv').alert();
		    				$scope.modalErrorMessage = "Please enter sales operation timing for" + val.days;
		    				isOperationDetails=false;
		    			return false;
		    		}else{
		    			isOperationDetails=true;
		    		}
		    	})
	    	}
	    
	    	 if(finalSiteObj.siteDelivery.length==7){
		    	$.each(finalSiteObj.siteDelivery,function(key,val){
		    		if(val.from == "" && val.to==""){
		    			$('#modalMessageDiv').show();
	    				$('#messageWindow').hide();
	    				$('#successMessageDiv').hide();
	    				$('#errorMessageDiv').show();
	    				$('#errorMessageDiv').alert();
	    				$scope.modalErrorMessage = "Please enter delivery operation timing for"+ val.days;
	    				isOperationDetails=false;
		    			return false;
		    		}else{
		    			isOperationDetails=true;
		    		}
		    	})
	    	}
	    	 if(isOperationDetails==true){
	    		$scope.createSiteVOObject(finalSiteObj);
	    		$scope.modalErrorMessage ="";
	    	 }else{
	    		 $('#modalMessageDiv').show();
 				$('#messageWindow').hide();
 				$('#successMessageDiv').hide();
 				$('#errorMessageDiv').show();
 				$('#errorMessageDiv').alert();
 				$scope.modalErrorMessage = "Please enter all the required fields for operation timings";
	    	 }
	    	
	    	
     };
	     $scope.createSiteVOObject=function(finalSiteObj){
	    	var finalObject = siteCreationService.createSiteObject(finalSiteObj)
	    	console.log(finalObject);
	    	siteCreationService.saveSiteObject(finalObject)
    		.then(function(data) {
    			console.log(data)
    			if(data.statusCode == 200){
    				$('#messageWindow').show();
    				$('#successMessageDiv').show();
    				$('#successMessageDiv').alert();
    				$('#errorMessageDiv').hide();
    				$('#siteModalCloseBtn').click();
    				$scope.successMessage = data.message;
    				$scope.getAllSites();
    			}else{
    				 $('#modalMessageDiv').show();
    				$('#messageWindow').hide();
    				$('#successMessageDiv').hide();
    				$('#errorMessageDiv').show();
    				$('#errorMessageDiv').alert();
    				$scope.modalErrorMessage = data.message;
    			}
            },
            function(data) {
                console.log(data)
                $('#messageWindow').hide();
                $('#modalMessageDiv').show();
                $('#successMessageDiv').hide();
                $('#errorMessageDiv').show();
				$('#errorMessageDiv').alert();
				$scope.modalErrorMessage = data.message;
            });
	    	
	     }
	     $scope.closeMessageWindow=function(){
				$('#messageWindow').hide();
				$('#successMessageDiv').hide();
				$('#errorMessageDiv').hide();
				$('#modalMessageDiv').hide();
				$scope.modalErrorMessage="";
				$scope.successMessage="";
			}
	     //----------------------- View Site ------------------------------------
	     
	     
		 console.log("allsite retrived");
		 $scope.equipmentData={
					
			};
		 $scope.serviceData={
					
			};
		 
		 
		 $scope.getSiteDetails=function(site){
			// console.log(site);
			 	$scope.selectedSite={};
				$scope.selectedSite=angular.copy(site);
				$scope.selectedSite.siteName = site.siteName;
				$scope.selectedSite.siteNumber1 = site.siteNumber1;
				$scope.selectedSite.siteNumber2 = site.siteNumber2;
				$scope.selectedSite.siteAddress = site.address;
				
				
				$scope.selectedSite.district = site.district;
				$scope.selectedSite.area=site.area;
				$scope.selectedSite.cluster=site.cluster;
				$scope.district.selected=$scope.selectedSite.district;
				 $scope.getDistrictByCountry($scope.sessionUser);
				
				
				 $scope.getArea();
				 $scope.area.selected = $scope.selectedSite.area;
				
				 $scope.cluster.selected = $scope.selectedSite.cluster;
				
				 $scope.getCluster();
				
				$scope.selectedSite.retailerName=site.owner;
				$scope.selectedSite.primaryContact=site.primaryContact;
				$scope.selectedSite.secondaryContact=site.secondaryContact;
				
				$scope.selectedSite.LicenseDetail = site.siteLicense;
				$scope.selectedSite.SalesOperation = site.siteOperation;
				$scope.selectedSite.DeliveryOperation = site.siteDelivery;
				$scope.selectedSite.submeterDetails = site.siteSubmeter;
				 
				$scope.siteLicense = $scope.selectedSite.LicenseDetail;
				$scope.siteSalesOperation = $scope.selectedSite.SalesOperation;
				$scope.siteDeliveryOperation = $scope.selectedSite.DeliveryOperation;
				
				$scope.siteSubmeterDetails = $scope.selectedSite.submeterDetails;
				/*$scope.siteowner = $scope.siteToDisplay.siteOwner;
				$scope.siteoperator = $scope.siteToDisplay.operator;
				$rootScope.siteoperator = $scope.siteToDisplay.operator*/
				//console.log($scope.selectedSite);
				//console.log($scope.siteLicense);
				
				/*console.log($scope.owner);*/
				
				 
				 $.each($scope.siteSalesOperation, function(key,val){
					 var fromTiming={
							 id:key,
							 name:val.from,
					 }
					 var toTiming={
							 id:key,
							 name:val.to,
					 }
					 var salesTimingObject={
							 opId:val.opId,
							 days:val.days,
							 from:fromTiming,
							 to:toTiming
					 }
					
					 
				 })
				
				// $scope.selectedSite.areaList=$scope.siteData.areaData.list;
			}
		 
		 $scope.updateSiteModal = function(selectedSite) {
			 console.log(selectedSite);
			 $scope.siteData = angular.copy($scope.selectedSite);
			 $('#siteModalLabel').text("Update site");
			 $scope.retrieveAllCountries($scope.sessionUser);
			 $scope.onedit=false;
			// $scope.siteData = angular.copy(selectedSite);
			 console.log($scope.siteData);
			 
			 $scope.licenseDetails = [] ;
			 $scope.licenseDetails =  selectedSite.LicenseDetail;
			
			 $scope.salesoperationDetails = [] ;
			 $scope.deliveryoperationDetails = [];
			
			 $.each($scope.siteSalesOperation, function(key,val){
				 var fromTiming={
						 id:key,
						 name:val.from,
				 }
				 var toTiming={
						 id:key,
						 name:val.to,
				 }
				 var salesTimingObject={
						 opId:val.opId,
						 days:val.days,
						 from:fromTiming,
						 to:toTiming
				 }
				 //$("#salesSelectFrom"+key "option").val(fromTiming.name);
				
				 $scope.salesoperationDetails.push(salesTimingObject);
			 })
			 
			
			 
			  $.each($scope.siteDeliveryOperation, function(key,val){
				 var fromTiming={
						 id:key,
						 name:val.from,
				 }
				 var toTiming={
						 id:key,
						 name:val.to,
				 }
				 var deliveryTimingObject={
						 opId:val.opId,
						 days:val.days,
						 from:fromTiming,
						 to:toTiming
				 }
				 $scope.deliveryoperationDetails.push(deliveryTimingObject);
			 })
			 $scope.submeterDetails = [];
			 $scope.submeterDetails = selectedSite.submeterDetails;
			 $scope.showUpdateModal();
			 
			}
		 
		 $scope.showUpdateModal=function(){
			 $('#createSiteModal').modal('show');
		 }
		 
		 $scope.openCreateEquipment = function(selectedSite) {
			 
			 console.log("Equipment modal");
			 $scope.siteData=[];
			 $scope.siteData = angular.copy(selectedSite);
			 console.log($scope.siteData);
			 
			  }


$scope.saveAssetEquipmentForm=function(){
 console.log("save equipment form");

	 	
	var finalAssetEquipmentObj = {
			AssetEquipment: $scope.equipmentData,
			siteData:$scope.siteData 			
	
	};
	console.log(finalAssetEquipmentObj);
	
};

$scope.onlyNumbers = /^\d+$/;
$scope.filterValue = function($event){
    if(isNaN(String.fromCharCode($event.keyCode))){
        $event.preventDefault();
    }
};
			 
}]);
function validateDropdownValues(dropDownId){
	var scope = angular.element("#siteWindow").scope();
	 var valueId = parseInt($("#"+dropDownId).val());
	 if(valueId == 0){
	 
	 }else{
		 if(dropDownId.toUpperCase() == "DISTRICTSELECT"){
			 var district={
					 districtId:parseInt($("#districtSelect").val()),
			 		 districtName:$("#districtSelect option:selected").text()
			 }
			scope.district.selected=district;
			 scope.siteData.district = district;
		 }
		 
		 if(dropDownId.toUpperCase() == "AREASELECT"){
			 var area={
					 areaId:parseInt($("#areaSelect").val()),
			 		 areaName:$("#areaSelect option:selected").text()
			 }
			scope.area.selected=area;
			 scope.siteData.area = area;
			 scope.getCluster();
		 }
		 
		 if(dropDownId.toUpperCase() == "CLUSTERSELECT"){
			 var cluster={
					 clusterID:parseInt($("#clusterSelect").val()),
			 		 clusterName:$("#clusterSelect option:selected").text()
			 }
			scope.cluster.selected=cluster;
			 scope.siteData.cluster = cluster;
			
		 }
	 }
}

function setTimeValues(dropDownId, option){
	var scope = angular.element("#siteWindow").scope();
	var selectedVal = dropDownId.id;
	console.log(selectedVal)
	if(option=="from"){
		$.each(scope.salesTimes.fromlist,function(key,val){
			if(selectedVal.toUpperCase() == "SALESSELECTFROM"+key){
				console.log("SALESSELECTFROM"+key)
				var object={
						opId:val.opId,
						days:val.days,
						val:$('#'+selectedVal).val(),
						text:$('#'+selectedVal).val()
				}
				scope.salesTimes.selected=object;
				console.log(scope.salesTimes.selected)
				return false;
			}
		});
		$.each(scope.salesTimes.fromlist,function(key,val){
			if(selectedVal.toUpperCase() == "DELIVERYFROM"+key){
				console.log("DELIVERYFROM"+key)
				var object={
						opId:val.opId,
						days:val.days,
						val:$('#'+selectedVal).val(),
						text:$('#'+selectedVal).val()
				}
				scope.salesTimes.selected=object;
				console.log(scope.salesTimes.selected)
				return false;
			}
		});
	}
	if(option=="to"){
		$.each(scope.salesTimes.toList,function(key,val){
			if(selectedVal.toUpperCase() == "SALESSELECTTO"+key){
				console.log("SALESSELECTTO"+key)
				var object={
						opId:val.opId,
						days:val.days,
						val:$('#'+selectedVal).val(),
						text:$('#'+selectedVal).val()
				}
				scope.salesTimes.selected=object;
				console.log(scope.salesTimes.selected)
				return false;
			}
		});
		$.each(scope.salesTimes.toList,function(key,val){
			if(selectedVal.toUpperCase() == "DELIVERYTO"+key){
				console.log("DELIVERYTO"+key)
				var object={
						opId:val.opId,
						days:val.days,
						val:$('#'+selectedVal).val(),
						text:$('#'+selectedVal).val()
				}
				scope.salesTimes.selected=object;
				console.log(scope.salesTimes.selected)
				return false;
			}
		});
	}
		
	}
	
