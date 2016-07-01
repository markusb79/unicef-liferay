<%@page import="com.rhizome.util.CommonUtil"%>
<%@include file="../init.jsp"%>
<input type="hidden" name='<portlet:namespace/>solutionCommentCount' id='<portlet:namespace/>solutionCommentCount' value="${commentCount}">

<c:forEach items="${comments}" var="solutionComment">
	<c:set var="commentUserId" value="${solutionComment.userId}"/>
	
	<%
		User commentUser = UserLocalServiceUtil.getUser((Long)pageContext.getAttribute("commentUserId"));
		long userPotraitId = commentUser.getPortraitId();
		String userName = commentUser.getFullName();
		String userAvtar = commentUser.getPortraitId() > 0 ? CommonUtil.getUserImagePath(userPotraitId) : CommonUtil.getUserImagePathScreenName(commentUser.getScreenName(), commentUser.getCompanyId());
	%>
<div class="sga-mainbox clearfix">
          <div class="sga-mainbox02 clearfix">
            <div class="sga-user-imgbox"><img src="<%=userAvtar%>"></div>
            <div class="sga-box01">
              <div class="sga-title01"><%=userName %></div>
              <div class="sga-text01 clearfix">${solutionComment.description}</div>
            </div>
          </div>
          <div class="sga-user-buttonbox"> <a href="#" class="sga-user-b1">Reply</a><a href="#" class="sga-user-b2">Like</a><a href="#" class="sga-user-b3">50</a> </div>
        </div>
</c:forEach>