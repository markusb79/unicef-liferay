<%@include file="../init.jsp"%>
<script type="text/javascript">
<portlet:namespace />viewArticleDescription = function(articleId,sopFilterValue,sopSubFilterValue,viewArticleURL){
	var sopURL = "";
	//var redirectURL = <portlet:namespace />generateFilterValueStoredURL(); 
	sopURL = '/web/guest/sop/-/landing/viewsop/'+viewArticleURL;
	console.log('SOP URL ' + sopURL);
	window.location.href = sopURL;
	//javascript:<portlet:namespace />openArticleDisplay(sopURL);
}

 <portlet:namespace />openArticleDisplay = function(url){
	console.log('SOP2 URL ' + url);
	window.location.href = url;
} 

<portlet:namespace/>closeFilters = function(){
	 $("#<portlet:namespace/>filterOnOff").toggleClass("un-filter-off");
}

<portlet:namespace/>clearDoneItems = function(){
	$(".un-sop-fi-link.doneItems.active").css("display","none","important");
}

<portlet:namespace />emailCurrentPageSOP = function() {
	window.location.href="mailto:?subject="+document.title+"&body="+window.location.href;
}



</script>