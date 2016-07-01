<%@include file="../init.jsp"%>
<%@page import="com.rhizome.util.CommonUtil"%>
<c:if test="${solutionComments.size() > 0 }">
   		<c:forEach items="${solutionComments}" var="solutionComments">
   			<c:set var="commentUserId" value="${solutionComments.userId}"/>
   			<c:set var="commentId" value="${solutionComments.commentId}"/>
   		
   		<%
			User commentUser = UserLocalServiceUtil.getUser((Long)pageContext.getAttribute("commentUserId"));
			long userPotraitId = commentUser.getPortraitId();
			String userNameReplyComment = commentUser.getFullName();
			String userAvtarReplyComment = commentUser.getPortraitId() > 0 ? CommonUtil.getUserImagePath(userPotraitId) : CommonUtil.getUserImagePathScreenName(commentUser.getScreenName(), commentUser.getCompanyId());
		%>
		
		<div class="ans-block08 clearfix">
            <div class="ans-replyed-box1 clearfix">
              <div class="ans-replyed-userimgbox1 clearfix">
                <div class="ans-replyed-userimg"><img src="<%=userAvtarReplyComment%>"></div>
              </div>
              <div class="ans-replyed-usertitle01">
                <div class="txt-b1"><%=userNameReplyComment %></div>
                <div class="txt-b2"><span>date </span><span>august 10, 2015</span></div>
              </div>
            </div>
            <div class="ans-replyed-box2 clearfix">${solutionComments.description}</div>
         </div>
   		</c:forEach>
</c:if>
      
