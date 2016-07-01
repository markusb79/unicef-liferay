<%@include file="../init.jsp"%>
<portlet:resourceURL var="postSolutionCommentUrl" id="postSolutionComment" />
<portlet:resourceURL var="solutionCommentViewURL" id="solutionComment" />
<portlet:resourceURL var="likeCommentUrl" id="likeComment" />
<portlet:resourceURL var="replyCommentUrl" id="replyComment" />
<portlet:resourceURL var="replyCommentView" id="replyCommentView" />

<script type="text/javascript">

/*When Page loads call Solution Comment Method For Get Solution Comment */
 
$(document).ready(function () {
	 displaySolutionCommentView("${solution.solutionId}");
});

function  displaySolutionCommentView(solutionId){
	 $.ajax({
	    url :"<%=solutionCommentViewURL%>",
	    data : {
	    'solutionId' : solutionId,
	   },
	    success : function(result) {
	    	 $('#<portlet:namespace/>solutionComments').html(''); 
	    	 $('#<portlet:namespace/>solutionComments').html(result);
	    	 			 
	    	 if ($(document).height()-16 > $(window).height()) {						
					$("#footerSolutionView").removeAttr("style");
					$("#footerSolutionView").css({
						"position":"absolute",
						"left":"0px",
						"right":"0px"
					});	
				}else{			
					$("#footerSolutionView").css({
						"position":"fixed",
						"left":"0px",
						"right":"0px",							
						"bottom":"0px"
					});						
				}
	   }
	 });
}

/*Open Solution Div For First Level Comment */

<portlet:namespace />openFirstlvlCommentDiv=function(){
	$("#<portlet:namespace/>firstLvlCommentTxt" ).val('');
	
	if ($("#<portlet:namespace/>firstLvlComment" ).css('display') == 'none') {
		$("#<portlet:namespace/>firstLvlComment").toggle(function(){
			   $('#<portlet:namespace/>firstLvlCommentTextArea').removeClass("has-error");
			   $("#<portlet:namespace/>firstLvlComment").slideDown();
			});
		}else{
		  $("#<portlet:namespace/>firstLvlComment").toggle(function(){
				$("#<portlet:namespace/>firstLvlComment").slideUp();
			});
		}
}

/*Method For Post First Level Comment */

<portlet:namespace />postFirstLvlComment = function(solutionId){
	 var solutionCommentText = $('#<portlet:namespace/>firstLvlCommentTxt').val();
	 if($.trim(solutionCommentText) == ''){
		 $('#<portlet:namespace/>firstLvlCommentTextArea').addClass("has-error");
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
	     $('#<portlet:namespace/>firstLvlCommentTextArea').removeClass("has-error");
	     $('#<portlet:namespace/>firstLvlCommentTxt').val('');
	     displaySolutionCommentView(solutionId);
	   }
	 });
}
	
/*Open Second Level Comment Div */

<portlet:namespace />openSecondLvlCommentDiv = function(commentId,solutionId){
	   $.ajax({
		    url :"<%=replyCommentView%>",
		    data : {
		    'solutionId' : solutionId,
		    'commentId':commentId
		    },
		    success : function(result) {
		    	$('#<portlet:namespace/>commentAnswerDiv_'+commentId).html(result);
		    	
		    	if ($("#<portlet:namespace/>commentReply_"+commentId).css('display') == 'none') {
		    		$("#<portlet:namespace/>commentReply_"+commentId).toggle(function(){
		    			    $("#<portlet:namespace/>commentReplyText_"+commentId ).val('');
		    			    $('#<portlet:namespace/>commentReplyErroDiv_'+commentId).removeClass("has-error");
		    			    $('#<portlet:namespace />activeA_'+commentId).addClass('un-menu-active');
		    			    $("#<portlet:namespace/>commentReply_"+commentId).slideDown();
		    			    
		    			});
		    		}else{
		    		  $("#<portlet:namespace/>commentReply_"+commentId).toggle(function(){
		    			  	$('#<portlet:namespace />activeA_'+commentId).removeClass('un-menu-active');
		    				$("#<portlet:namespace/>commentReply_"+commentId).slideUp();
		    				 
		    			});
		    		}
		   },
		   async: false
		 });
}

/* Post Second Level Comment */
 
 
<portlet:namespace />postSecondLvlComment = function(commentId,solutionId){
	var replyComment = $("#<portlet:namespace/>commentReplyText_"+commentId ).val();
	if($.trim(replyComment) == ''){
		  $('#<portlet:namespace/>commentReplyErroDiv_'+commentId).addClass("has-error");
		  return;
	}
	$.ajax({
	    url :"<%=replyCommentUrl%>",
	    data : {
	    'solutionId' : solutionId,
	    'commentId':commentId,
	    'replyComment' : replyComment
	    },
	    success : function(result) {
	    	$('#<portlet:namespace/>commentAnswerDiv_'+commentId).html(result);
	    	$('#<portlet:namespace/>commentReplyText_'+commentId).val('');
	    	$('#<portlet:namespace/>commentReplyErroDiv_'+commentId).removeClass("has-error");
	   },
	   async: false
	 });
}
<portlet:namespace/>commentLike = function(solutionId, commentId){
	var like= document.getElementById('<portlet:namespace />likeUnlikeCommentText_'+commentId).innerHTML;
	
	$.ajax({
	    url :"<%=likeCommentUrl%>",
	    data : {
	    'solutionId' : solutionId,
	    'commentId':commentId,
	    'like' : like
	    },
	    success : function(result) {
	    	if(like == 'Liked'){
	    		document.getElementById('<portlet:namespace />likeUnlikeCommentText_'+commentId).innerHTML = 'Like';
	    	}else if(like == 'Like'){
	    		document.getElementById('<portlet:namespace />likeUnlikeCommentText_'+commentId).innerHTML = 'Liked';
	    	}
	    	document.getElementById('<portlet:namespace />likeCommentCount_'+commentId).innerHTML = result;
	   },
	   async: false
	 });
}


</script>