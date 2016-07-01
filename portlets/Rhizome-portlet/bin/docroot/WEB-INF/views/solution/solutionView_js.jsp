<%@include file="../init.jsp"%>
<portlet:resourceURL var="postSolutionCommentUrl" id="postSolutionComment" />
<portlet:resourceURL var="solutionCommentViewURL" id="solutionComment" />

<script type="text/javascript">
$(document).ready(function () {
	 displaySolutionCommentView("${solution.solutionId}");
});
<portlet:namespace />solutionComment = function(){
	$("#<portlet:namespace/>solutionCommentTxt" ).val('');
		if ($("#<portlet:namespace/>commentDiv" ).css('display') == 'none') {
		$("#<portlet:namespace/>commentDiv").toggle(function(){
			   $('#<portlet:namespace/>solutionCommentDiv').removeClass("text-error");
			   $("#<portlet:namespace/>commentDiv").slideDown();
			});
		}else{
		  $("#<portlet:namespace/>commentDiv").toggle(function(){
				$("#<portlet:namespace/>commentDiv").slideUp();
			});
		}
}
<portlet:namespace />postSolutionComment = function(solutionId){
	 var solutionCommentText = $('#<portlet:namespace/>solutionCommentTxt').val();
	 if($.trim(solutionCommentText) == ''){
		 $('#<portlet:namespace/>solutionCommentDiv').addClass("text-error");
	  return;
	 }
	 $.ajax({
	    url :"<%=postSolutionCommentUrl%>",
	    data : {
	    'solutionId' : solutionId,
	    'commentText' : solutionCommentText,
	    },
	    success : function(result) {
	     $('#<portlet:namespace/>solutionCommentTxt').val('');
	     $('#<portlet:namespace/>comment').removeClass("has-error");
	     displaySolutionCommentView(solutionId);
	   }
	 });
	}
function  displaySolutionCommentView(solutionId){
	 $.ajax({
	    url :"<%=solutionCommentViewURL%>",
	    data : {
	    'solutionId' : solutionId,
	   },
	    success : function(result) {
	    	 $('#<portlet:namespace/>solutionCommentView').html(''); 
	    	 $('#<portlet:namespace/>solutionCommentView').html(result);
	    	 var commentCount = $('#<portlet:namespace/>solutionCommentCount').val();
	    	 
	    	 if(commentCount == 0){
	    		 $('#<portlet:namespace/>noMoreImage').show();	    		 
	    	 }else if(commentCount == 1){
	    		 $('#<portlet:namespace/>commentText').text('View all answer('+commentCount+')');
	    		 $('#<portlet:namespace/>noMoreImage').hide();
	    	 }else{
	    		 $('#<portlet:namespace/>commentText').text('View all answers('+commentCount+')');
	    		 $('#<portlet:namespace/>noMoreImage').hide();
	    	 }
	    	 
	    	 $('#<portlet:namespace/>commentCountDisplay').text(commentCount);
	   }
	 });
}
</script>