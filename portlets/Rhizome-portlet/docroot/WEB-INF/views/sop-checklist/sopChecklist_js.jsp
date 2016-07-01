<%@include file="../init.jsp"%>
<portlet:resourceURL var="removeArticleFromChecklist" id="removeArticleFromChecklist"/>
<portlet:resourceURL var="generateCheckListFromDB" id="generateCheckListFromDB"/>
<portlet:resourceURL var="checkUnCheckList" id="checkUnCheckList"/>
<portlet:resourceURL var="clearAllCheckLeast" id="clearAllCheckLeast"/>
<portlet:resourceURL var="getSOPChecklist" id="getSOPChecklist"/>	

<script type="text/javascript">

<portlet:namespace />emailCurrentPageSOP = function() {
	window.location.href="mailto:?subject="+document.title+"&body="+window.location.href;
}

<portlet:namespace />viewArticleDescription = function(articleId,sopFilterValue,sopSubFilterValue,viewArticleURL){
	var sopURL = "/web/guest/sop/-/landing/viewsop/"+viewArticleURL;
	console.log('Request to open : ' + sopURL);
	window.location.href = sopURL;
}

showCheckListDiv = function() {
	
	$.ajax({
	    url :"<%=getSOPChecklist.toString()%>",
	    datatype:'html',
	    success : function(result) {
	    	//debugger;
	    	$("#refilterData").html("");
	    	$("#refilterData").append(result);
	    	 
	    	
	    	$(".sopCheckList").css('display', 'block');
	    	$(".c4dToolkit").css('display', 'none');
	    	setBroswerHeight();
	    	//$("#sopCheckListDiv").mCustomScrollbar();
	        
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
/* 
setHeightDynamicallyOnWindowResize = function(windowHeight){
	console.log('Height check -in ' + windowHeight);
	$('.rh-checklist-mainbox').height(windowHeight - 110);
	$('.np-mcs-content').height(windowHeight - 303);
	
}
 */

closeFilters = function(){
	 $(".sopCheckList").css('display', 'none');
	 $(".body-container").css('width', '100%');
	 
	// $("#_SOPLanding_WAR_Rhizomeportlet_filterOnOff").addClass("un-filter-off");

}

<portlet:namespace/>clearDoneItems = function() {
	
	// check list is not empty
	if(!isCheckListEmpty()) {
		
		// validate item is selected or not
		if(isThereAnyItemfromChecklistSelected()) {
			
			// confirm
			if(confirm('Are you sure you want to clear your done items?')) {
				
				var criteria = [];
				<c:forEach items="${sopArticles}" var="article" varStatus="articleCounter">
					criteria.push({'id':'${article.id}'});
				</c:forEach>
			
				for(var i = 0; i < criteria.length; i++){
				  var articleId = criteria[i].id;
				  
				  	if($("#<portlet:namespace/>addFilterAllCheckList_"+articleId).hasClass("active")) {
						$("#<portlet:namespace/>addFilterAllCheckList_"+articleId).remove();
						
						addRemoveFromCheckList(articleId, '');
						
					} // end if
				} // end for
				
				$("#<portlet:namespace/>clearSopChecklistDoneItems").css('display', 'none');
				
			} // end if
		} else {
			alert('Please select done item from checklist.');
		}// end if
	} // end if

}

<portlet:namespace/>clearCheckList = function() {
	
	if(!isCheckListEmpty() && confirm('Are you sure you want to clear your entire checklist?')) {	 	
	
		$.ajax({
		    url :"<%=clearAllCheckLeast.toString()%>",
		    contentType:'application/json; charset=utf-8',
		    datatype:'json',
		    success : function(result) {
		    	var jsonData = JSON.parse(result);
		    	for (var i = 0; i < jsonData.length; i++) {
				    var articleId = jsonData[i].articleId;
				    
				    // remove element
				    $("#<portlet:namespace/>addFilterAllCheckList_"+articleId).remove();
				    $("#<portlet:namespace/>addFilterDivAllCheckList_"+articleId).remove();
				    
				    // disable all element from checklist 
				    $("#_SOPLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).removeClass("n-check-on");
					$("#_SOPLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).addClass("n-check-off");
					$("#_SOPLanding_WAR_Rhizomeportlet_checkListText_"+articleId).text("ADD TO MY CHECKLIST");
					$("#_SOPLanding_WAR_Rhizomeportlet_checkListText_"+articleId).css({ 'color': "white" });
					$("#_SOPLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).text("ADD TO MY CHECKLIST");
					$("#_SOPLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).css({ 'color': "black" });
					$("#_SOPLanding_WAR_Rhizomeportlet_sopTile_"+articleId).removeClass("sop-fs");
					
					// disable clear checklist button
					$("#sopChecklistClearChecklistItems").css({'display':'none'});
					// enable empty message
					$("#sopEmptyChecklistMessage").css({'display':'block'});
					
					// set empty message
					var emptyMessage = ""	+ 
						"<div class='empty-list-message' id='sopEmptyChecklistMessage'>"	+
			    		"Currently there are no items in checklist.";
			    		"</div>";
			    	$(".un-sop-fi-link-box").html("");
			    	$(".un-sop-fi-link-box").append(emptyMessage);

		    	}
		   	  }
		 });
	    
		} 
}

isThereAnyItemfromChecklistSelected = function() {
	
	var criteria = [];

	<c:forEach items="${sopArticles}" var="article" varStatus="articleCounter">
		criteria.push({'id':'${article.id}'});
	</c:forEach>
	
	for(var i = 0; i < criteria.length; i++){
		  var articleId = criteria[i].id;
		  if($("#<portlet:namespace/>addFilterAllCheckList_"+articleId).hasClass("active")) {
			  return true;
			} // end if
			
	} // end for
	return false;
} // end if


isCheckListEmpty = function() {
	return '${sopArticles.size()}' <= 0 ? true : false ;
}

addRemoveFromCheckList = function(articleId, indexNumber) {
	
	$.ajax({
	    url :"<%=removeArticleFromChecklist.toString()%>",
	   data : {
	    'articleId' : articleId
	    },
	    contentType:'application/json; charset=utf-8',
	    datatype:'json',
	    success : function(result) {
	    	$("#<portlet:namespace/>addFilterDivAllCheckList_"+articleId).remove();
	    	$("#_SOPLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).removeClass("n-check-on");
			$("#_SOPLanding_WAR_Rhizomeportlet_addMyCheckList_"+articleId).addClass("n-check-off");
			$("#_SOPLanding_WAR_Rhizomeportlet_checkListText_"+articleId).text("ADD TO MY CHECKLIST");
			$("#_SOPLanding_WAR_Rhizomeportlet_checkListText_"+articleId).css({ 'color': "white" });
			$("#_SOPLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).text("ADD TO MY CHECKLIST");
			$("#_SOPLanding_WAR_Rhizomeportlet_checkListTextDetail_"+articleId).css({ 'color': "black" });
			$("#_SOPLanding_WAR_Rhizomeportlet_sopTile_"+articleId).removeClass("sop-fs");
	   	  }
	 });
}

<portlet:namespace/>checkUncheckCheckList = function(articleId) {

	$.ajax({
	    url :"<%=checkUnCheckList.toString()%>",
	   data : {
	    'articleId' : articleId
	    },
	    contentType:'application/json; charset=utf-8',
	    datatype:'json',
	    success : function(result) { 
	    	showCheckListDiv();
	   	}
	 });
	
}
</script>