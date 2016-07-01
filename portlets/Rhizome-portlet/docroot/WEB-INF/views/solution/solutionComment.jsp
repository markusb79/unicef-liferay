<%@page import="com.rhizome.service.SolutionCommentLikeService"%>
<%@page import="com.rhizome.util.CommonUtil"%>
<%@page import="com.rhizome.domain.SolutionComment" %>
<%@page import="com.rhizome.service.SolutionCommentService" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@include file="../init.jsp"%>
<input type="hidden" name='<portlet:namespace/>solutionCommentCount' id='<portlet:namespace/>solutionCommentCount' value="${commentCount}">

<c:forEach items="${comments}" var="solutionComment">
	<c:set var="commentUserId" value="${solutionComment.userId}"/>
	<c:set var="commentId" value="${solutionComment.commentId}"/>
	<c:set var="solutionId" value="${solutionComment.solution.solutionId}"/>
	<c:set var="commentCreateDate" value="${solutionComment.createdDate}"/>
	<%
		User loggedInUser = themeDisplay.getUser();
		String currentUserAvtar = loggedInUser.getPortraitId() > 0 ?  CommonUtil.getUserImagePath(loggedInUser.getPortraitId()) : CommonUtil.getUserImagePathScreenName(loggedInUser.getScreenName(), loggedInUser.getCompanyId());
		
		User commentUser = UserLocalServiceUtil.getUser((Long)pageContext.getAttribute("commentUserId"));
		long userPotraitId = commentUser.getPortraitId();
		String userName = commentUser.getFullName();
		String userAvtar = commentUser.getPortraitId() > 0 ? CommonUtil.getUserImagePath(userPotraitId) : CommonUtil.getUserImagePathScreenName(commentUser.getScreenName(), commentUser.getCompanyId());
		User userU = themeDisplay.getUser();
		SolutionCommentLikeService commentLikeService = (SolutionCommentLikeService)request.getAttribute("solutionCommentLikeService");
		SolutionCommentService commentService = (SolutionCommentService)request.getAttribute("solutionCommentService");
		boolean like = commentLikeService.getSolutionCommentLikeStatus(userU.getUserId(), (Long)pageContext.getAttribute("solutionId"), (Long)pageContext.getAttribute("commentId"));
		long likeCount = commentLikeService.getCurrentCommentLikeCount((Long)pageContext.getAttribute("solutionId"), (Long)pageContext.getAttribute("commentId"));
		List<SolutionComment> solutionComments = commentService.getListOfSolutionReplyComment((Long)pageContext.getAttribute("solutionId"),(Long)pageContext.getAttribute("commentId"));
		pageContext.setAttribute("likeCount",likeCount);
		pageContext.setAttribute("solutionComments", solutionComments);
		Date commentCreatedDate = (Date)pageContext.getAttribute("commentCreateDate");
		String formatedCreateDate = new SimpleDateFormat("MMM dd, YYYY").format(commentCreatedDate).toUpperCase();
		pageContext.setAttribute("formatedCreateDate", formatedCreateDate);
	%>
	  <div class="ans-block06 clearfix">
         <div class="clearfix">
            <div class="ans-userimg-box">
              <div class="ans-userimg-box02"><img src="<%=userAvtar%>"></div>
              <div class="ans-user-text01"><%=userName %><br></div>
            </div>
            <div class="ans-user-textbox01">
            	${solutionComment.description}
          	</div>
          </div>
          <div class="clearfix ans-user-button-panel">
            <div class="ans-user-button-panel-b1"><span>date</span><span>${formatedCreateDate}</span></div>
            <div class="ans-user-button-panel-b2">
            	<a href="javascript:void(0);" id='<portlet:namespace />activeA_${solutionComment.commentId}' onclick="<portlet:namespace />openSecondLvlCommentDiv('${solutionComment.commentId}','${solutionId}');">Reply <span class="ans-but-aero ani-1"></span>
            	</a>
            </div>
            <div class="sga-user-buttonbox">
            	<c:choose>
          			<c:when test="<%=like%>">
          				<a href="javascript:void(0);" class="sga-user-b2" onclick="<portlet:namespace/>commentLike(${solutionComment.solution.solutionId},${solutionComment.commentId})">
          					<span id="<portlet:namespace/>likeUnlikeCommentText_${solutionComment.commentId}">Liked</span>
          				</a>	
          			</c:when>
          			<c:otherwise>
          				<a href="javascript:void(0);" class="sga-user-b2" onclick="<portlet:namespace/>commentLike(${solutionComment.solution.solutionId},${solutionComment.commentId})">
          					<span id="<portlet:namespace/>likeUnlikeCommentText_${solutionComment.commentId}">Like</span>
          				</a>
          			</c:otherwise>
          		</c:choose>
          		<a href="javascript:void(0);" class="sga-user-b3">
	          		<span id="<portlet:namespace/>likeCommentCount_${solutionComment.commentId}">
	          			<%= likeCount %>
	          		</span>
          		</a> 
            </div>
          </div>
          		<div id="<portlet:namespace />commentReply_${solutionComment.commentId}" style="display: none;">
		          <div class="ans-block07 clearfix">
		            <div class="ans-userimg-box03 clearfix">
		              <div class="ans-userimg-box02"><img src="<%=currentUserAvtar%>"></div>
		            </div>
		            <div class="ans-user-commentbox" id='<portlet:namespace/>commentReplyErroDiv_${commentId}'>
		              <textarea placeholder="Type here" name='<portlet:namespace/>commentReplyText_${solutionComment.commentId}' id='<portlet:namespace/>commentReplyText_${solutionComment.commentId}' class="auto-textheight" ></textarea>
		              <div class="ans-user-submit-box">
		                <input type="button" value="ok" class="ans-user-submit-button" name="ok" onclick="<portlet:namespace />postSecondLvlComment('${solutionComment.commentId}','${solutionId}');">
		              </div>
		            </div>
		          </div>
		          <div id="<portlet:namespace />commentAnswerDiv_${solutionComment.commentId}"></div>
		         </div>
        </div> 

</c:forEach>
<style>
	.has-error textarea{
 		border:1px solid #a94442 !important;
 	}
</style>