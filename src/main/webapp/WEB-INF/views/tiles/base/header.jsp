<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html ng-app="chrisApp">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>
<link rel="stylesheet"	href='<c:url value="/resources/theme1/css/bootstrap.min.css"></c:url>' />
<link rel="stylesheet" 	href='<c:url value="/resources/css/ionicons/css/ionicons.min.css"></c:url>'/>

<link rel="stylesheet"	href='<c:url value="/resources/css/jquery-jvectormap-1.2.2.css"></c:url>' />

<link rel="stylesheet"	href='<c:url value="/resources/theme1/font-awesome-4.7.0/css/font-awesome.min.css"></c:url>' />
<%-- <link rel="stylesheet"	href='<c:url value="/resources/theme1/css/ripples.min.css"></c:url>' />
<link rel="stylesheet"	href='<c:url value="/resources/theme1/css/main.css"></c:url>' />
<link rel="stylesheet"	href='<c:url value="/resources/theme1/css/responsive.css"></c:url>' /> --%>
<link rel="stylesheet"	href='<c:url value="/resources/theme1/css/animate.min.css"></c:url>' />

<link rel="stylesheet" href='<c:url value="/resources/theme1/css/jquery-editable-select.min.css"></c:url>' />
<link rel="stylesheet" href='<c:url value="/resources/theme1/css/datepicker3.css"></c:url>' />
<%-- <link rel="stylesheet" href='<c:url value="/resources/css/bootstrap-datetimepicker.min.css"></c:url>' /> --%>


<link rel="stylesheet"	href='<c:url value="/resources/dist/css/AdminLTE.min.css"></c:url>' />
<link rel="stylesheet"	href='<c:url value="/resources/theme1/css/style.css"></c:url>' />
<link rel="stylesheet"	href='<c:url value="/resources/dist/css/skins/skin-black-light.min.css"></c:url>' />

<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/jquery-2.1.4.min.js"></c:url>'></script>
<script type="text/javascript"  src='<c:url value="/resources/theme1/js/bootstrap-datepicker.js"></c:url>'></script>

<script type="text/javascript"  src='<c:url value="/resources/theme1/js/jquery-editable-select.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/angular.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/tether.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/bootstrap.min.js"></c:url>'></script>


<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/transition.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/dist/js/app.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/ripples.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/material.min.js"></c:url>'></script>

<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/jquery.mmenu.min.all.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/count-to.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/jquery.inview.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/classie.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/jquery.nav.js"></c:url>'></script>
<%-- <script type="text/javascript" 	src='<c:url value="/resources/theme1/js/smooth-on-scroll.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/smooth-scroll.js"></c:url>'></script> --%>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/main.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/mdb.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/wow.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/angular-route.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/jstorage.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/theme1/js/app-main.js"></c:url>'></script>


<%-- <script type="text/javascript" 	src='<c:url value="/resources/theme1/js/controller.js"></c:url>'></script> --%>
<%-- <script type="text/javascript" 	src='<c:url value="/resources/theme1/js/services.js"></c:url>'></script> --%>

<%-- <script type="text/javascript" 	src='<c:url value="/resources/js/sockjs.min.js"></c:url>'></script>
<script type="text/javascript" 	src='<c:url value="/resources/js/stomp.min.js"></c:url>'></script> --%>

<script type="text/javascript">


	var webContextPath="${pageContext.request.contextPath}";

</script>
<style>
	 .alert-success {
	
   			display:table;
    		background-color: rgb(122, 221, 0) !important;
    		border-color:#fff !important
    		
    }
    .alert-danger {
      	display:table;
   		 background-color: rgba(237, 73, 10, 0.92) !important;
   		 border-color:#fff !important
    		
    }
   
    .alert{
        padding: 7px;
            margin-bottom: 0px;
            border: 0px solid transparent !important;
    }
    .alert .close{
        color: #000 !important;
   		 opacity: 2.2 !important;
    }
   .alert-dismissable .close {
    position: relative;
    top: -2px;
    color: inherit;
      margin-right: 19px;
} 

</style>
</head>

<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<div id="wrapper1">
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			     	<div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-backyard">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        
                        <div  class="navbar-brand">
                    <a id="menu-toggle" href="#" class="btn-menu toggle" style="font-size: 1.5em;">
                        <i class="fa fa-bars"></i>
                    </a>
    				<%-- <a class="navbar-brand site-name" href="#top">
    				<img src="${contextPath}/resources/img/sigma.png" style="width: 29%;
    margin-top: -3px;"></a> --%>
                </div>
                    </div>
                    <div id="navbar-scroll" class="collapse navbar-collapse navbar-backyard navbar-right">
                        <div id="greetings"></div>
                       <ul class="nav navbar-nav">
                      
          
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">5</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 5 notifications</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> Notification 1
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-warning text-yellow"></i> Notification 2
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-red"></i> Notification 3
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-shopping-cart text-green"></i> Notification 4
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-user text-red"></i> Notification 5
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
              <!-- User Account Menu -->
              <li class="dropdown user user-menu">
                <!-- Menu Toggle Button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <!-- The user image in the navbar-->
                 <i class="fa fa-user" aria-hidden="true"></i>
                  <!-- hidden-xs hides the username on small devices so only the image appears. -->
                  <span class="hidden-xs">${user.firstName}  ${user.lastName}</span>
                </a>
                <ul class="dropdown-menu " style="margin-top: 9px;border:0px">
                 <li class="header" style="margin-left: 10px;">You have following Roles</li>
                  <ul class="menu">
                   <c:forEach items="${user.userRoles}" var="roles">
                  <li>
                    <a href="#">
                     
                      <h4>
                       <i class="fa fa-users text-aqua"> ${roles.role.description}</i>
                      </h4>
                     
                    </a>
                  </li>
                  </c:forEach>
                  </ul>
                               
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="${contextPath}/user/profile" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                    <sec:authorize access="isAuthenticated()">
                      <a href="${contextPath}/logout" class="btn btn-default btn-flat">Sign out</a>
                     </sec:authorize> 
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
                    </div>
		</div>
	</nav>
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
    
   <ul class="list-group">
  	<li class="list-group-item">
  		<a href="${contextPath}/appdashboard"><i class="fa fa-home" aria-hidden="true"></i> <span class="menulink">HOME</span> </a>
  	</li>
  	<li class="list-group-item">
  		<a href="${contextPath}/appdashboard"><i class="fa fa-home" aria-hidden="true"></i> <span class="menulink">PREFERENCES</span></a>
  	</li>
  	<li class="list-group-item">
	  <a  class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
	  <i class="fa fa-cog" arial="hidden"></i> <span class="menulink">MANAGE </span> </a>
	  <ul  role="menu" style="padding: 24px 12px;
    margin: -9px 0 0;
    font-size: 16px;">
	  	
	  	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
	  	<li class="list-group-item"><a href="${contextPath}/user/details">
	  	<i class="fa fa-users" aria-hidden="true"></i> <span class="menulink">Users</span></a></li>
		</sec:authorize>
		<sec:authorize access="hasAnyRole('ROLE_SITE_STAFF','ROLE_SALES_MANAGER','ROLE_OPS_MANAGER')">
	    <li class="list-group-item"><a href="${contextPath}/site/details"><i class="fa fa-sitemap" aria-hidden="true"></i> <span class="menulink">Sites <span></a></li>
	    <li class="list-group-item"><a href="${contextPath}/asset/details"><i class="fa fa-sitemap" aria-hidden="true"></i> <span class="menulink">Assets</a> <span></li>
	    <li class="list-group-item"><a href="#"><i class="fa fa-ticket" aria-hidden="true"></i> <span class="menulink">Incidents<span></a></li>
	    <li class="list-group-item"><a href="${contextPath}/serviceprovider/details"><i class="fa fa-sitemap" aria-hidden="true"></i> <span class="menulink">Service Provider<span></a></li>
	    </sec:authorize>
	    <!-- <li class="divider"></li>
	    	<li><a href="#">Separated link</a></li> -->
	  </ul>      
      
  </li>
</ul>
 
		 
    </div>
