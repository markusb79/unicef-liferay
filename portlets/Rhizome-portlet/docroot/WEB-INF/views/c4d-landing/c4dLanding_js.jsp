<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<liferay-theme:defineObjects />

<portlet:resourceURL var="viewC4DLandingControllerURL" id="viewC4DLandingController" />
<portlet:resourceURL var="addToCheckListC4DURL" id="addToCheckListC4D" />

<script type="text/javascript">

var checkit = window.check_var;
if(checkit === undefined){ //file never entered. the global var was not set.	
	 var c4dScrollCount = 0;
	 var mainCategory = '${action}';
	 displayC4DArticles(c4dScrollCount,mainCategory);
     window.check_var = 1;
}else{
	alert('hello 2');
}


function  displayC4DArticles(c4dScrollCount, mainCategory){
	$.ajax({
	    url :"<%=viewC4DLandingControllerURL%>",
	    datatype:'json',
	    data : {
	    'c4dScrollCount' : c4dScrollCount,
	    'mainCategory' : mainCategory
	   },
	    success : function(result) {
				console.log('hello world it is success');	  
				var oldHtml = $('#<portlet:namespace/>c4dContent').html();
				$('#<portlet:namespace/>c4dContent').html(result);
	    		
				if(mainCategory == 'Understand'){
					$('#<portlet:namespace/>understandTab a').attr('style','color:#FFFFFF !important');
					$('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
					
					$('#<portlet:namespace/>understandTab').attr('style','background-color:#7E9B00 !important');
					$('#<portlet:namespace/>planTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>actTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>toolsTab').attr('style','background-color:#d8dfdd !important');
				}
				if(mainCategory == 'Plan'){
					$('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>planTab a').attr('style','color:#FFFFFF !important');
					$('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');	
					
					$('#<portlet:namespace/>understandTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>planTab').attr('style','background-color:#3A61C9 !important');
					$('#<portlet:namespace/>actTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>toolsTab').attr('style','background-color:#d8dfdd !important');
				}
				if(mainCategory == 'Act'){
					$('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>actTab a').attr('style','color:#FFFFFF !important');
					$('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
					
					$('#<portlet:namespace/>understandTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>planTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>actTab').attr('style','background-color:#008A54 !important');
					$('#<portlet:namespace/>toolsTab').attr('style','background-color:#d8dfdd !important');
				}
				if(mainCategory == 'Tools'){
					$('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
					$('#<portlet:namespace/>toolsTab a').attr('style','color:#FFFFFF !important');
					
					$('#<portlet:namespace/>understandTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>planTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>actTab').attr('style','background-color:#d8dfdd !important');
					$('#<portlet:namespace/>toolsTab').attr('style','background-color:#33B1B7 !important');
				}
	   },
	   async: false
	 });
}

<portlet:namespace/>addToCheckListC4D = function(articleId){
	
	$.ajax({
	    url :"<%=addToCheckListC4DURL%>",
	    data : {
	    'articleId' : articleId
	    },
	    success : function(result) {
	    	
	    	if ($("#<portlet:namespace/>addMyC4DCheckList_"+articleId).hasClass("n-check-off")) {
	    		
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).removeClass("n-check-off");
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).addClass("n-check-on");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).text("ADDED TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).css({ 'color': "red" });
				
				// show c4dToolkit
				showC4DToolkitDiv();
				
				console.log('remove off and add on');
			} else {
				
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).removeClass("n-check-on");
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).addClass("n-check-off");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).text("ADD TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).css({ 'color': "white" });
				
				// show c4dToolkit
				showC4DToolkitDiv();
				
				// remove from toolkit
				removeFromToolkit();
				
				console.log('remove on and add off');
			}			
	    	
	    	disableC4DExpand(articleId);
	   	}
	 });
}

function disableC4DExpand(articleId){
	if($("#"+articleId).hasClass("in")) {
		$("#"+articleId).removeClass("in");

		$("#rotate_curve_collapsible_"+articleId).removeClass("un-menu-active");
	}
}


</script>