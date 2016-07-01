<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<liferay-theme:defineObjects />
<portlet:resourceURL var="addToCheckListC4DURL" id="addToCheckListC4D" />

<script type="text/javascript">

function viewC4DCArticleDescription(url, viewC4DArticleURL, action){
	
	var c4dURL = '/web/guest/c4d/-/c4dLanding/viewc4d/'+viewC4DArticleURL+'?action='+action;
	
	<portlet:namespace />openC4DArticleDisplay(c4dURL);
}

<portlet:namespace />openC4DArticleDisplay = function(url){
	window.location.href = url;
}

<portlet:namespace />emailCurrentPage = function() {
	window.location.href="mailto:?subject="+document.title+"&body="+window.location.href;
}

<portlet:namespace/>addToCheckListC4D = function(articleId){
	$.ajax({
	    url :"<%=addToCheckListC4DURL%>",
	    data : {
	    'articleId' : articleId
	    },
	    success : function(result) {
	    	
	    	if ($("#<portlet:namespace/>addMyC4DCheckList_"+articleId).hasClass("n-check-off") || $("#<portlet:namespace/>addMyCheckList_"+articleId).hasClass("n-check-off")) {
	    		
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).removeClass("n-check-off");
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).addClass("n-check-on");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).text("ADDED TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).css({ 'color': "red" });
				
				$("#<portlet:namespace/>addMyCheckList_"+articleId).removeClass("n-check-off");
				$("#<portlet:namespace/>addMyCheckList_"+articleId).addClass("n-check-on");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).text("ADDED TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).css({ 'color': "red" });
				
			} else {
				
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).removeClass("n-check-on");
				$("#<portlet:namespace/>addMyC4DCheckList_"+articleId).addClass("n-check-off");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).text("ADD TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListC4DText_"+articleId).css({ 'color': "white" });
				
				$("#<portlet:namespace/>addMyCheckList_"+articleId).removeClass("n-check-on");
				$("#<portlet:namespace/>addMyCheckList_"+articleId).addClass("n-check-off");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).text("ADD TO MY TOOLKIT");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).css({ 'color': "black" });
			}
	    	
	    	showC4DToolkitDiv();
	    	
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

<portlet:namespace/>redirecToOriginalAction = function(url, action){
	console.log('action url ' + url + "&action=" + action);
	window.location.href = url + "&action=" + action;
}

</script>