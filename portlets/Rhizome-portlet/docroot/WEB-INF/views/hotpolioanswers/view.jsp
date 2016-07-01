<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%
	ThemeDisplay td  = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
	pageContext.setAttribute("currentURL", td.getURLCurrent());
%>

<c:choose>
	<c:when test="${fn:contains(currentURL, 'viewSolution') || fn:contains(currentURL, 'viewMostRecentURL')}"></c:when>
	<c:otherwise>
		
<c:choose>
	<c:when test="${fn:contains(currentURL, 'SolutionGenerator_WAR_Rhizomeportlet')}">
		<div class="sg-ans-rightpart clearfix sg-ans-rightpart-detail">	
	</c:when>
	<c:otherwise>
		<div class="sg-ans-rightpart clearfix">				
	</c:otherwise>
</c:choose>
		

<div class="clearfix">
<div class="sg-title01 clearfix">Hot Topics</div>
		<div class="hot-idea-container clearfix">
	         <c:forEach items="${hotSolutionTopicsList}" var="solution"  varStatus="solutionCounter">
	         	<c:if test="${solutionCounter.count gt 0 && solutionCounter.count lt 10}">
		         
	         	<%
					long structureId = PortalUtil.getPlidFromPortletId(themeDisplay.getScopeGroupId(), "SolutionGenerator_WAR_Rhizomeportlet");
				%>
		
	         	<liferay-portlet:renderURL portletName="SolutionGenerator_WAR_Rhizomeportlet"  var="solutionPortletURL" plid="<%=structureId %>" varImpl="solutionPortletURL" windowState="<%=LiferayWindowState.NORMAL.toString()%>">
					<portlet:param name="view" value="viewSolution" />
					<portlet:param name="solutionId" value="${solution.solutionId}" />
				</liferay-portlet:renderURL>
		
	         	<a href="javascript:void(0);" onclick="javascript:<portlet:namespace />viewSolutionLink('<%=solutionPortletURL.toString()%>')">
		         	<div class="hot-idea-mainbox clearfix">
		            <div class="hot-idea-greybox clearfix">
		              <div class="hot-icea-question-text01">Question ${solutionCounter.count}</div>
		              <div class="hot-icea-question-text02"><div class="hot-icea-question-text02-fixer">${solution.solutionTitle}</div></div>
		              <div class="sg-tq-share-box">
		                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
		              </div>
		              <div class="hot-idea-a-c-mainbox">
		                <div class="hot-idea-a-c-box1">Comments: ${solution.totalComments}</div>
		                <div class="hot-idea-a-c-box2">Likes: ${solution.totalLikes}</div>
		              </div>
		            </div>
		          </div>
	          </a>
			  </c:if>
	         </c:forEach>
        </div>
	</div>
</div>

</c:otherwise>
</c:choose>
<%@include file="view_js.jsp" %>