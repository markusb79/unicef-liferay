<%@include file="../init.jsp"%>
<portlet:resourceURL var="viewC4DChecklistView" id="viewC4DChecklistView"/>
<portlet:resourceURL var="removeC4DResourceFromCheckList" id="removeC4DResourceFromCheckList"/>
<portlet:resourceURL var="clearAllToolkit" id="clearAllToolkit"/>

<script type="text/javascript">

<portlet:namespace />emailCurrentPageC4D = function() {
	window.location.href="mailto:?subject="+document.title+"&body="+window.location.href;
}

showC4DToolkitDiv = function(){

	// adjust css class to set c4d tiles proper
//	$("#_C4DLanding_WAR_Rhizomeportlet_c4dContent").addClass("sopd-content-rowbox");
//	$("#_C4DLanding_WAR_Rhizomeportlet_c4dContent").removeClass("un-filter-off");
//	$(".sopd-content-rowbox").css('margin-top', '0px');
	
	$.ajax({
	    url :"<%=viewC4DChecklistView.toString()%>",
	    datatype:'html',
	    success : function(result) {
	    	
	    	$("#refilterC4DData").html("");
	    	$("#refilterC4DData").append(result);
	    	
	    	$(".c4dToolkit").css('display', 'block');
	    	$(".sopCheckList").css('display', 'none');
	    	setBroswerHeight();
	   	}
	 });
	
}

setBroswerHeight = function(){
	var windowHeight = $(window).height();
	$('.rh-checklist-mainbox').height(windowHeight - 110);
	$('.np-mcs-content').height(windowHeight - 319);
         
}

$(window).resize(function () {
	setBroswerHeight();
});

<portlet:namespace/>checkUncheckCheckList = function(articleId) {
	if($("#<portlet:namespace/>addFilterAllCheckList_" + articleId ).hasClass("active")) {
		$("#<portlet:namespace/>addFilterAllCheckList_" + articleId).removeClass("active");
	} else {
		$("#<portlet:namespace/>addFilterAllCheckList_" + articleId).addClass("active");
	}
}

<portlet:namespace />viewArticleDescription = function(articleId, sopFilterValue, mainCategory, viewArticleURL){
	
	var c4dURL;
	
	c4dURL = '/web/guest/c4d/-/c4dLanding/viewc4d/' +viewArticleURL +'?action=' + mainCategory;
	console.log('Request to open : ' + c4dURL);

	window.location.href = c4dURL;
}

closeFilters = function(){
	
	// add/remove class to adjust c4d tiles
	$("#_C4DLanding_WAR_Rhizomeportlet_c4dContent").addClass("un-filter-off");
	$("#_C4DLanding_WAR_Rhizomeportlet_c4dContent").removeClass("sopd-content-rowbox");
	
	$(".c4dToolkit").css('display', 'none');
	$(".body-container").css('width', '100%');
	 
}


<portlet:namespace/>clearToolkit = function() {

	// validate toolkit is not empty
	if (!isToolkitEmpty()) {
		// confirm
		if (confirm('Are you sure you want to clear your entire toolkit?')) {
			// clear toolkit
			$.ajax({
				url: "<%=clearAllToolkit.toString()%>",
				contentType: 'application/json; charset=utf-8',
				datatype: 'json',
				success: function (result) {
					var jsonData = JSON.parse(result);
					for (var i = 0; i < jsonData.length; i++) {

						var articleId = jsonData[i].articleId;

						$("#_C4DChecklist_WAR_Rhizomeportlet_addFilterAllCheckList_"+articleId).remove();
			
						// disable added element from checklist
				    	$("#_C4DLanding_WAR_Rhizomeportlet_addMyC4DCheckList_"+articleId).removeClass("n-check-on");
						$("#_C4DLanding_WAR_Rhizomeportlet_addMyC4DCheckList_"+articleId).addClass("n-check-off");
						$("#_C4DLanding_WAR_Rhizomeportlet_checkListC4DText_"+articleId).text("ADD TO MY TOOLKIT");
						$("#_C4DLanding_WAR_Rhizomeportlet_checkListC4DText_"+articleId).css({ 'color': "white" });
						
						// disable clear toolkit button
						$("#c4dChecklistClearItems").css({'display':'none'});
						
						// enable empty message
						$("#c4dEmptyToolkitMessage").css({'display':'block'});
						
						// set empty message
						var emptyMessage = ""	+ 
							"<div class='empty-list-message' id='sopEmptyChecklistMessage'>"	+
				    		"Currently There are no items in Toolkit.";
				    		"</div>";
				    	$(".un-sop-fi-link-box").html("");
				    	$(".un-sop-fi-link-box").append(emptyMessage);
						
					}
					
					showC4DToolkitDiv();
				}
			});
		} // end if
	} // end if
}

<portlet:namespace/>clearDoneItems = function() {
	
	// validate list is not empty
	if(!isToolkitEmpty()) {
		// validate item is selected
		if(isThereAnyItemSelectedFromToolkit()) {
			// confirm
			if(confirm('Are you sure you want to clear your entire toolkit?')) {
				
				var criteria = [];
				
				<c:forEach items="${c4dArticles}" var="article" varStatus="articleCounter">
					criteria.push({'id':'${article.articleId}'});
				</c:forEach>

				for(var i = 0; i < criteria.length; i++) {
					  var articleId = criteria[i].id;
					  if($("#<portlet:namespace/>addFilterAllCheckList_"+articleId).hasClass("active")) {
							$("#<portlet:namespace/>addFilterAllCheckList_"+articleId).remove();
							removeFromToolkit(articleId, '');
						} // end if
				} // end for
				
			} // end if
		} else {
			alert('Please select done item from toolkit.');			
		}// end if
	} // end if
	
}

isThereAnyItemSelectedFromToolkit = function() { 
	var criteria = [];
	
	<c:forEach items="${c4dArticles}" var="article" varStatus="articleCounter">
		criteria.push({'id':'${article.articleId}'});
	</c:forEach>

	for(var i = 0; i < criteria.length; i++){
		  var articleId = criteria[i].id;
		  if($("#<portlet:namespace/>addFilterAllCheckList_"+articleId).hasClass("active")) {
				return true;
			}
	} // end for
	return false;
}

isToolkitEmpty = function() {
	return '${c4dArticles.size()}' <= 0 ? true : false;
}

removeFromToolkit = function(articleId, indexNumber){

	$.ajax({
	    url :"<%=removeC4DResourceFromCheckList.toString()%>",
	   data : {
	    'articleId' : articleId
	    },
	    contentType:'application/json; charset=utf-8',
	    datatype:'json',
	    success : function(result) {
			
	    	// remove element from checklist
	    	$("#_C4DChecklist_WAR_Rhizomeportlet_addFilterAllCheckList_"+articleId).remove();
	    	
	    	// disable added element from checklist
	    	$("#_C4DLanding_WAR_Rhizomeportlet_addMyC4DCheckList_"+articleId).removeClass("n-check-on");
			$("#_C4DLanding_WAR_Rhizomeportlet_addMyC4DCheckList_"+articleId).addClass("n-check-off");
			$("#_C4DLanding_WAR_Rhizomeportlet_checkListC4DText_"+articleId).text("ADD TO MY TOOLKIT");
			$("#_C4DLanding_WAR_Rhizomeportlet_checkListC4DText_"+articleId).css({ 'color': "white" });
			
			// sync c4d toolkit to c4d detail page
			$("#_C4DLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).removeClass("n-check-on");
			$("#_C4DLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).addClass("n-check-off");
			$("#_C4DLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).text("ADD TO MY TOOLKIT");
			$("#_C4DLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).css({ 'color': "black" });
			
	    	
	    }
	 });
}

</script>