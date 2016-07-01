<%@page import="com.rhizome.domain.C4DCheckList" %>
<%@page import="com.rhizome.service.C4DCheckListService"%>
<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<c:forEach items="${c4dArticlesList}" var="article"  varStatus="articleCounter">

	<c:set var="articleId" value="${article.articleId}"/>

	<%
	   C4DCheckListService checkListService = (C4DCheckListService)request.getAttribute("c4dCheckListService");
	   boolean flag = checkListService.checkC4DMyCheckListExistList((Long)pageContext.getAttribute("articleId"), themeDisplay.getUserId());
	   pageContext.setAttribute("flag",flag);

	%>

	<liferay-portlet:renderURL var="viewDetailC4DArticleURL">
		<portlet:param name="view" value="viewDetailC4DArticle" />
		<portlet:param name="articleId" value="${article.articleId}" />
	</liferay-portlet:renderURL>

		<div class="sopd-content-box">
			<div class="sopd-content-subbox clearfix" style="background-color: ${article.articleColor} !important;cursor: pointer;" onclick="viewC4DCArticleDescription('<%= viewDetailC4DArticleURL %>','${article.aricleURLTitle}', '${action}')">

		    <div class="c4d-category-text" style="color:${article.articleFontColor};"><span>${article.subcategory}</span></div>
		    <div class="c4d-img-box"><div class="c4d-img-box2"><img src="${article.imageArticle}"></div></div>
		    <div class="c4d-article-title" style="color:${article.articleFontColor};"><span>${article.title}</span></div>
		</div>

		<c:choose>
			<c:when test="${fn:containsIgnoreCase(article.category, 'Tool')}">
				<div class="sopd-share-but"> <a href="javascript:void(0);" data-toggle="n-collapse" data-target="#t2">share</a></div>
			</c:when>
			<c:otherwise>

			<c:choose>
	        <c:when test="<%=themeDisplay.isSignedIn() %>">
	         <div class="sopd-share-but">
	            <a href="javascript:void(0);" id="rotate_curve_collapsible_${article.articleId}" data-toggle="n-collapse" data-target="#${article.articleId}">share</a></div>
	        </c:when>
	        <c:otherwise>
	         <div class="sopd-share-but"> <a href="#loginBox" class="various3">share</a></div>
	        </c:otherwise>
	       </c:choose>

				<!-- <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#${article.articleId}">share</a></div> -->
				<div class="un-user-bookmark-box clearfix n-collapse" id="${article.articleId}" aria-expanded="false">
	                    <div class="un-user-checking-bar-box1 has-js">
		                    <c:choose>
			                    <c:when test="<%= themeDisplay.isSignedIn() %>">
									<c:choose>
										<c:when test="${!flag}">
											<div id="<portlet:namespace/>addMyC4DCheckList_${article.articleId}" class="un-check-link n-check-off" onclick="<portlet:namespace/>addToCheckListC4D(${article.articleId});">
			                                    <a id="<portlet:namespace/>checkListC4DText_${article.articleId}" href="javascript:void(0);">ADD TO MY TOOLKIT</a>
			                                </div>
										</c:when>
										<c:otherwise>
											<div id="<portlet:namespace/>addMyC4DCheckList_${article.articleId}" class="un-check-link n-check-on" onclick="<portlet:namespace/>addToCheckListC4D(${article.articleId});">
			                                    <a id="<portlet:namespace/>checkListC4DText_${article.articleId}" href="javascript:void(0);" style="color: red;">ADDED TO MY TOOLKIT</a>
			                                </div>
										</c:otherwise>
									</c:choose>
			                    </c:when>
			                    <c:otherwise>
				                    <div id="<portlet:namespace/>addMyC4DCheckList_${article.articleId}" class="un-check-link n-check-off" onclick="$.fancybox.open('#loginBox');">
					                    <a id="<portlet:namespace/>checkListC4DText_${article.articleId}" href="#loginBox">ADD TO MY TOOLKIT</a>
				                    </div>
			                    </c:otherwise>
		                    </c:choose>
						</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

</c:forEach>

<%@include file="c4dLandingResponse_js.jsp" %>