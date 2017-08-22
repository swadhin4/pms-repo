chrisApp.factory("userService", ['$http', '$q',function ($http, $q) {
	//34-209-65-191
	
	 	var UserService = {
	 			user:{},
	            userList: [],
	            retrieveAllUsers:retrieveAllUsers,
	            validateUser:validateUser,
	            getLoggedInUser:getLoggedInUser,
	            registerUser:registerUser,
	            getUserSiteAccess:getUserSiteAccess
	        };
	 	
	 	return UserService;
	 	
	 	 // implementation
        function registerUser(customer) {
            var def = $q.defer();
            $http.post("http://localhost:8080/api/register/customer", customer )
                .success(function(data) {
                	console.log(data)
                    def.resolve(data);
                })
                .error(function(data) {
                	console.log(data)
                    def.reject(data);
                });
            return def.promise;
        }
	 	
	    // implementation
        function validateUser(username,password) {
            var def = $q.defer();
            var user={
            		emailId:username,
            		password:password
            }
            $http.post("https://localhost:8080/api/authenticate/user", user )
                .success(function(data) {
                	console.log(data)
                	UserService.user = data;
                    def.resolve(data);
                })
                .error(function(data) {
                	console.log(data)
                    def.reject(data);
                });
            return def.promise;
        }
        
     // implementation
             
        function getLoggedInUser(loggedInUser) {
        	 // implementation
                var def = $q.defer();
               
                $http.get("http://localhost:8080/user/logged")
                    .success(function(data) {
                    	console.log(data)
                        def.resolve(data);
                    })
                    .error(function() {
                        def.reject("Failed to get albums");
                    });
                return def.promise;
        }
        
        // implementation
        function retrieveAllUsers() {
            var def = $q.defer();
            $http.get("http://localhost:8080/user/list")
                .success(function(data) {
                	console.log(data)
                	UserService.userList = data;
                    def.resolve(data);
                })
                .error(function() {
                    def.reject("Failed to get albums");
                });
            return def.promise;
        }
        
        function getUserSiteAccess(){
        	 var def = $q.defer();
             
             $http.get("http://localhost:8080/user/site/access")
                 .success(function(data) {
                 	console.log(data)
                     def.resolve(data);
                 })
                 .error(function() {
                     def.reject("Failed to get user site access list");
                 });
             return def.promise;
        }
        
        
}]);

chrisApp.factory("siteService", ['$http', '$q',function ($http, $q) {
		var SiteService = {
 			site:{},
            siteList: [],
            retrieveAllSites:retrieveAllSites,
            retrieveSiteDetails:retrieveSiteDetails,
            saveSite:saveSite
        };
		
	 	return SiteService;
	 	
	    function retrieveSiteDetails(site) {
            var def = $q.defer();
            $http.get("http://34.209.65.191:8282/test/api/site/"+site.siteId)
                .success(function(data) {
                     console.log(data)
                     SiteService.site=data;
                    def.resolve(data);
                })
                .error(function(data) {
                     console.log(data)
                    def.reject(data);
                });
            return def.promise;
        }
 
	 	
	    // implementation
        function retrieveAllSites() {
            var def = $q.defer();
            $http.get("http://localhost:8080/test/api/sites")
                .success(function(data) {
                	console.log(data)
                	/*
                	$.each(data,function(key,val){
                		SiteService.siteList.push(val);
                	});*/
                	
                    def.resolve(data);
                })
                .error(function(data) {
                	console.log(data)
                    def.reject(data);
                });
            return def.promise;
        }
        
        

	    // implementation
        function saveSite(siteData) {
            var def = $q.defer();
            $http.post("http://34.209.65.191:8282/test/api/site/save",siteData)
                .success(function(data) {
                	console.log(data)
                	SiteService.site =data;
                    def.resolve(data);
                })
                .error(function(data) {
                	console.log(data)
                    def.reject(data);
                });
            return def.promise;
        }
 }]);

chrisApp.factory("companyService", ['$http', '$q',function ($http, $q) {
	var CompanyService = {
			company:{},
        companyList: [],
        retrieveAllROCompanies:retrieveAllROCompanies,
        retrieveAllSPCompanies:retrieveAllSPCompanies,
        
    };
	
 	return CompanyService;
 	
    // implementation
    function retrieveAllROCompanies() {
        var def = $q.defer();
        $http.get("http://localhost:8080/test/api/companies")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		CompanyService.companyList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    // implementation
    function retrieveAllSPCompanies() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/asset/serviceprovider")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		CompanyService.companyList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);

/*chrisApp.factory("assetService", ['$http', '$q',function ($http, $q) {
	var AssetService = {
		asset:{},
        assetList: [],
        retrieveAllAsset:retrieveAllAsset,
        serviceProvider:{},
		getServiceProviderDetail:getServiceProviderDetail
    };
 	return AssetService;
 	
    // implementation
    function retrieveAllAsset(siteSelected) {
    	var siteId = siteSelected.siteId;
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/asset/site/"+siteId)
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		var asset={
            				assetId:val.assetId,
            				assetName:val.assetName
            		}
            		AssetService.assetList.push(asset);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    function getServiceProviderDetail(companyId) {
    	var serviceProviderId = companyId;
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/ticket/assignedto/"+serviceProviderId)
            .success(function(data) {
            	console.log(data)
            	AssetService.serviceProvider=angular.copy(data);
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);*/


chrisApp.factory("countryService", ['$http', '$q',function ($http, $q) {
	var CountryService = {
			country:{},
        countrylist: [],
        retrieveAllCountries:retrieveAllCountries,
        retrieveUserCountry:retrieveUserCountry,
        getCountryList:getCountryList,
        getCountryByRegion:getCountryByRegion
    };
	
 	return CountryService;
 	
    // implementation
    function retrieveAllCountries(user) {
        var def = $q.defer();
        $http.get("http://localhost:8080/test/api/countries")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		CountryService.countrylist.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    // implementation
    function getCountryList(user) {
    	var countryList = 	[];
    	 var def = $q.defer();
    	 var userCountry = {};
    	$http.get("http://localhost:8080/test/api/countries")
        .success(function(data) {
        	console.log(data)
        	$.each(data,function(key,val){
        		countryList.push(val);
        	});
        	
        	 $.each(countryList,function(key,val){
        		 if(val.countryId == user.company.countryId){
        			 userCountry = angular.copy(val);
        			 return false;
        		 }
        	 });
        	
            def.resolve(data);
        })
        .error(function(data) {
        	console.log(data)
            def.reject(data);
        });
    	
    	
    	 return userCountry;
    }
    
    // implementation
    function getCountryByRegion(region) {
    	var countryList = 	[];
    	 var def = $q.defer();
    	$http.get("http://localhost:8080/test/api/country/"+region.regionId)
        .success(function(data) {
        	console.log(data)
            def.resolve(data);
        })
        .error(function(data) {
        	console.log(data)
            def.reject(data);
        });
    	 return def.promise;
    }
    
 // implementation
    function retrieveUserCountry() {
    	
    }
    
    
}]);

chrisApp.factory("areaService", ['$http', '$q',function ($http, $q) {
	var AreaService = {
		area:{},
        areaList: [],
        retrieveAllAreas:retrieveAllAreas,
    };
 	return AreaService;
 	
    // implementation
    function retrieveAllAreas() {
        var def = $q.defer();
        $http.get("http://localhost:8080/test/api/areas")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		AreaService.areaList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
}]);

chrisApp.factory("districtService", ['$http', '$q',function ($http, $q) {
	var DistrictService = {
		district:{},
        districtList: [],
        retrieveAllDistricts:retrieveAllDistricts,
        retrieveDistrictByCountry:retrieveDistrictByCountry
    };
 	return DistrictService;
 	
    // implementation
    function retrieveAllDistricts() {
        var def = $q.defer();
        $http.get("http://localhost:8080/test/api/districts")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		DistrictService.districtList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
 // implementation
    function retrieveDistrictByCountry(loginUser) {
        var def = $q.defer();
        $http.get("http://localhost:8080/district/api/country/"+loginUser.company.countryId)
            .success(function(data) {
            	console.log(data)
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
}]);


chrisApp.factory("clusterService", ['$http', '$q',function ($http, $q) {
	var ClusterService = {
		cluster:{},
       clusterList: [],
        retrieveAllClusters:retrieveAllClusters,
    };
 	return ClusterService;
 	
    // implementation
    function retrieveAllClusters() {
        var def = $q.defer();
        $http.get("http://localhost:8080/test/api/clusters")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		ClusterService.clusterList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
}]);

chrisApp.factory("ticketCategoryService", ['$http', '$q',function ($http, $q) {
	var TicketCategoryService = {
		category:{},
        categories: [],
        retrieveAllCategories:retrieveAllCategories,
    };
	
	
 	return TicketCategoryService;
 	
    // implementation
    function retrieveAllCategories() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/ticketcategories")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		var category={
            				categoryId:val.id,
            				categoryName:val.ticketCategory
            		}
            		TicketCategoryService.categories.push(category);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);

chrisApp.factory("statusService", ['$http', '$q',function ($http, $q) {
	var StatusService = {
		status:{},
        statusList: [],
        retrieveAllStatus:retrieveAllStatus,
    };
	
	
 	return StatusService;
 	
    // implementation
    function retrieveAllStatus() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/status/CT")
            .success(function(data) {
            	console.log(data)
            	$.each(data,function(key,val){
            		StatusService.statusList.push(val);
            	});
            	
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);
chrisApp.factory("ticketService", ['$http', '$q',function ($http, $q) {
	var TicketService = {
		ticket:{},
        ticketList: [],
        openTicketList:[],
        approachingTicketList:[],
        priorityTicketList:[],
        escalatedTicketList:[],
        saveTicket:saveTicket,
        displayAllOpenTickets:displayAllOpenTickets,
        summaryViewOfOpenTickets:summaryViewOfOpenTickets,
        summaryViewSLATickets:summaryViewSLATickets,
        retrieveTicketDetails:retrieveTicketDetails,
        getPriorityTickets:getPriorityTickets,
        getSPTickets:getSPTickets,
        
    };
	
 	return TicketService;
 	
    // implementation
    function saveTicket(customerTicket) {
        var def = $q.defer();
        $http.post("http://34.209.65.191:8282/test/api/ticket/save",customerTicket)
            .success(function(data) {
            	console.log(data)
            	TicketService.ticket=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    
 // implementation
    function retrieveTicketDetails(ticket) {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/ticket/"+ticket.id)
            .success(function(data) {
            	console.log(data)
            	TicketService.ticket=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    // implementation
    function displayAllOpenTickets() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/tickets")
            .success(function(data) {
            	console.log(data)
            	TicketService.ticketList=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
 // implementation
    function summaryViewOfOpenTickets() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/siteticketstatus")
            .success(function(data) {
            	console.log(data)
            	TicketService.openTicketList=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    
 // implementation
    function summaryViewSLATickets() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/slatickets")
            .success(function(data) {
            	console.log(data)
            	TicketService.approachingTicketList=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
    
 // implementation
    function getPriorityTickets() {
        var def = $q.defer();
       /* $http.get("http://34.209.65.191:8282/test/api/siteticketstatus")
            .success(function(data) {
            	console.log(data)
            	TicketService.priorityTicketList=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });*/
        return def.promise;
    }
    
    // implementation
    function getSPTickets() {
        var def = $q.defer();
        $http.get("http://34.209.65.191:8282/test/api/sptickets")
            .success(function(data) {
            	console.log(data)
            	TicketService.escalatedTicketList=data;
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
    
}]);

chrisApp.factory("authService", ['$http', '$q',function ($http, $q) {
	var AuthService = {
        featureAccessList:{},
        loggedinUserAccess:loggedinUserAccess,
    };
	
	
 	return AuthService;
 	
    // implementation
    function loggedinUserAccess() {
        var def = $q.defer();
        $http.get("http://localhost:8080/auth/user/access")
            .success(function(data) {
            	console.log(data)
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);

chrisApp.factory("registrationService", ['$http', '$q',function ($http, $q) {
	var RegisterService = {
        featureAccessList:{},
        registerUser:registerUser,
    };
 	return RegisterService;
 	
    // implementation
    function registerUser(user) {
        var def = $q.defer();
        $http.post("http://localhost:8080/user/register",user)
            .success(function(data) {
            	console.log(data)
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);

chrisApp.factory("roleService", ['$http', '$q',function ($http, $q) {
	var RoleService = {
        role:{},
        retrieveRoles:retrieveRoles,
    };
 	return RoleService;
 	
    // implementation
    function retrieveRoles() {
        var def = $q.defer();
        $http.get("http://localhost:8080/user/roles")
            .success(function(data) {
            	console.log(data)
                def.resolve(data);
            })
            .error(function(data) {
            	console.log(data)
                def.reject(data);
            });
        return def.promise;
    }
}]);


