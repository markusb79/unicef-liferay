<%@page import="com.rhizome.service.C4DCheckListService"%>
<%@ page import="com.liferay.portal.model.User" %>
<%@include file="../init.jsp"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<!-- c4d detail view jsp file ---->

<portlet:defineObjects/>
<theme:defineObjects/>
<c:set var="singleArticleId" value="${article.articleId}"/>
<%
String action = (String)request.getAttribute("action");
C4DCheckListService checkListService = (C4DCheckListService)request.getAttribute("c4dCheckListService");
boolean flag = checkListService.checkC4DMyCheckListExistList((Long)pageContext.getAttribute("singleArticleId"), themeDisplay.getUserId());
pageContext.setAttribute("flag",flag);
%>


<portlet:renderURL var="openUnderStandURL">
	<portlet:param name="view" value="underStand"/>
</portlet:renderURL>

<div class="body-container clearfix ani-1" id="main-div">
	<div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
		<div class="un-nsm-link cat-1">    	
			<a href="/web/guest/sop" data-collapse-group="myDivs">+ SOP</a>
		</div>       
      <div class="un-nsm-link cat-2"><a href="/web/guest/c4d">+ C4D</a></div>
      <div class="un-nsm-link cat-3"><a href="http://db.rhizome.work" data-toggle="n-collapse" data-target="#data-submenu" data-collapse-group="myDivs">+ DATA</a></div>
      <c:choose>
      	<c:when test="<%=themeDisplay.isSignedIn() %>">
      		<div class="un-nsm-link"><a href="/group/guest/polio-answer-community">+ MY TOOLKIT</a></div>	
      	</c:when>
      	<c:otherwise>
      		<div class="un-nsm-link"><a href="#loginBox">+ MY TOOLKIT</a></div>
      	</c:otherwise>
      </c:choose>
      
      <!--div class="un-nsm-link"><a href="#">ABOUT</a></div-->
      <div class="un-nsm-link"><a href="/web/guest/contact">CONTACT US</a></div>
      <!--div class="un-nsm-link"><a href="#">REPORT A BUG</a></div>
      <div class="un-nsm-link"><a href="#">SITEMAP</a></div-->
    </div>
<div class="body-container clearfix">
	<!-- Adding code for bug 86 - Ravi -->
	<div class="clearfix" id="un-navigation-big">
		<div class="un-c4d-navmenu-linkbox">
			<c:choose>
				<c:when test='<%= action.equalsIgnoreCase("Understand")%>'>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>understandTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Understand');" style="background-color:#7E9B00;cursor: pointer;"><a style="color: white !important;" href="javascript:void(0);">1. UNDERSTAND</a></div>
				</c:when>
				<c:otherwise>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>understandTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Understand');" style="background-color:#d8dfdd !important;cursor: pointer;"><a href="javascript:void(0);">1. UNDERSTAND</a></div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='<%= action.equalsIgnoreCase("Plan")%>'>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>planTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Plan');" style="background-color:#3A61C9;cursor: pointer;"><a style="color: white !important;" href="javascript:void(0);">2. PLAN</a></div>
				</c:when>
				<c:otherwise>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>planTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Plan');" style="background-color:#d8dfdd !important;cursor: pointer;"><a href="javascript:void(0);">2. PLAN</a></div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='<%= action.equalsIgnoreCase("Act")%>'>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>actTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Act');" style="background-color:#008A54;cursor: pointer;"><a style="color: white !important;" href="javascript:void(0);">3. ACT</a></div>
				</c:when>
				<c:otherwise>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>actTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Act');" style="background-color:#d8dfdd !important;cursor: pointer;"><a href="javascript:void(0);">3. ACT</a></div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='<%= action.equalsIgnoreCase("Tools")%>'>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>toolsTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Tools');" style="background-color:#33B1B7;cursor: pointer;"><a style="color: white !important;" href="javascript:void(0);">4. TOOL</a></div>
				</c:when>
				<c:otherwise>
					<div class="un-c4d-navmenu-link" id="<portlet:namespace/>toolsTab" onclick="<portlet:namespace/>redirecToOriginalAction('<%=openUnderStandURL.toString()%>', 'Tools');" style="background-color:#d8dfdd !important;cursor: pointer;"><a href="javascript:void(0);">4. TOOL</a></div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- Ends -->

	<div class="sopd-detail-banner clearfix" style="background-color:${article.articleColor} !important;">
     	<div class="sopd-detail-closebtn">
     		<a href="<%=openUnderStandURL.toString()+"&action="+ action %>">Close<span></span>
     		</a> 
     	</div>
      <div class="sopd-detail-banner-box clearfix">
        <div class="sopd-detail-banner-img"> <img src="${article.imageArticle}"></div>
        <div class="sopd-detail-banner-text01"> 
        <div class="clearfix sopd-detail-banner-fix002">
        	<span style="color:${article.articleFontColor};">${article.subcategory}</span> <span style="color:${article.articleFontColor};">${article.title} </span>  
        </div>
        </div>
      </div>
    </div>

    <div class="c4d-detail-box1">
    <div class="clearfix">
    	<div class="clearfix">
	      	<div class="sopd-text01">
    		    ${article.articleContent}
        	</div>
    	</div>
    </div>
    
    <div class="un-sp-rightpart ab-content-fix01">
     <div class="sopd-checking-bar clearfix" style="padding-bottom: 4px;">
		<div class="sopd-checking-bar-box1 has-js np-has-js-fix clearfix">
			<c:choose>
				<c:when test="<%= themeDisplay.isSignedIn() %>">
					<c:choose>
						<c:when test="${!flag}">
							<div id="<portlet:namespace/>addMyCheckList_${article.articleId}" class="un-check-link n-check-off" onclick="<portlet:namespace/>addToCheckListC4D(${article.articleId});">
                                   <a id="<portlet:namespace/>checkListTextDetail_${article.articleId}" href="javascript:void(0);">ADD TO MY TOOLKIT</a>
                               </div>
						</c:when>
						<c:otherwise>
							<div id="<portlet:namespace/>addMyCheckList_${article.articleId}" class="un-check-link n-check-on" onclick="<portlet:namespace/>addToCheckListC4D(${article.articleId});">
                                   <a id="<portlet:namespace/>checkListTextDetail_${article.articleId}" href="javascript:void(0);" style="color: red;">ADDED TO MY TOOLKIT</a>
                               </div>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<div id="<portlet:namespace/>addMyC4DCheckList_${article.articleId}" class="un-check-link n-check-off" onclick="$.fancybox.open('#loginBox');">
						<a id="<portlet:namespace/>checkListC4DText_${article.articleId}" href="javascript:void(0);">ADD TO MY TOOLKIT</a>
					</div>
				</c:otherwise>
			</c:choose>
        </div>
      </div>
      
      <div class="sopd-checking-bar-box3 clearfix">
        <div class="clearfix"> 
				<!-- c4dPreviousArticle
				c4dNextArticle -->
		        <c:if test="${c4dPreviousArticle != null}">
			        <liferay-portlet:renderURL var="viewDetailC4DArticleURLPrevious">
				        <portlet:param name="view" value="viewDetailC4DArticle" />
				        <portlet:param name="articleId" value="${c4dPreviousArticle.articleId}" />
			        </liferay-portlet:renderURL>
        		    <a href="javascript:void(0);" class="sopd-prev-link" onclick="viewC4DCArticleDescription('<%= viewDetailC4DArticleURLPrevious %>','${c4dPreviousArticle.aricleURLTitle}', '<%=action%>')">Previous Topic</a>
		        </c:if>
		        <c:if test="${c4dNextArticle != null}">
			        <liferay-portlet:renderURL var="viewDetailC4DArticleURLNext">
				        <portlet:param name="view" value="viewDetailC4DArticle" />
				        <portlet:param name="articleId" value="${c4dNextArticle.articleId}" />
			        </liferay-portlet:renderURL>
			        <a href="javascript:void(0);" class="sopd-next-link" onclick="viewC4DCArticleDescription('<%= viewDetailC4DArticleURLNext%>','${c4dNextArticle.aricleURLTitle}', '<%=action%>')">Next Topic</a>
		        </c:if>

        </div>
        <div class="sopd-icon-box clearfix">
          <div class="sopd-mail-icon"><a href="javascript:<portlet:namespace />emailCurrentPage()">mail</a></div>
          <!--
          	 temporary hidden
	          <div class="sopd-print-icon"> <a href="#">print</a></div>
	          div class="sopd-idea-icon"> <a href="#">mail</a></div
	          <div class="sopd-like-icon" >
	          <a href="javascript:void(0);" data-toggle="n-collapse" data-target="#sopd-like-total-box" data-collapse-group="myDivs">mail</a>
	          <div class="sopd-like-box001 n-collapse" id="sopd-like-total-box">150</div>
	          </div>
	       -->
        </div>
      </div>
      
       <div class="sopd-checking-bar-box5 clearfix">
       		<c:if test="${fn:length(c4dArticlesList) gt 0}">
        		<div class="sopd-title04">Related Topics</div>
			<div class="sopd-detail-fix01">
		        <c:forEach items="${c4dArticlesList}" var="article"  varStatus="articleCounter">
		        
		        <c:set var="loopArticleId" value="${article.articleId}"/>
					<%
					C4DCheckListService checkListServiceLoop = (C4DCheckListService)request.getAttribute("c4dCheckListService");
					boolean flagList = checkListServiceLoop.checkC4DMyCheckListExistList((Long)pageContext.getAttribute("loopArticleId"), themeDisplay.getUserId());
					pageContext.setAttribute("flagList",flagList);
					%>
			        <liferay-portlet:renderURL var="viewDetailC4DArticleURL">
						<portlet:param name="view" value="viewDetailC4DArticle" />
						<portlet:param name="articleId" value="${article.articleId}" />
					</liferay-portlet:renderURL>
		
					<div class="sopd-content-box" style="cursor: pointer;">
					
					 <c:choose>
						<c:when test="${fn:containsIgnoreCase(article.category, 'Tool')}">
							<div class="sopd-content-subbox clearfix" style="background-color: ${article.articleColor} !important;">
						</c:when>
						<c:otherwise>
							<div class="sopd-content-subbox clearfix" style="background-color: ${article.articleColor} !important;cursor: pointer;" onclick="viewC4DCArticleDescription('<%= viewDetailC4DArticleURL %>','${article.aricleURLTitle}', '<%=action%>')">
						</c:otherwise>
					</c:choose>
					 
					   <div class="c4d-category-text" style="color:${article.articleFontColor};"><span>${article.subcategory}</span></div>
					   <div class="c4d-img-box"><div class="c4d-img-box2"><img src="${article.imageArticle}"></div></div>
					   <div class="c4d-article-title" style="color:${article.articleFontColor};"><span>${article.title}</span></div>
					 </div>
					 
					<!--  <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div> -->
					 
					 <c:choose>
						<c:when test="${fn:containsIgnoreCase(article.category, 'Tool')}">
							<div class="sopd-share-but"> <a href="javascript:void(0);" data-toggle="n-collapse" data-target="#t2">share</a></div>
						</c:when>
						<c:otherwise>
						
						<c:choose>
				        <c:when test="<%=themeDisplay.isSignedIn() %>">
				         <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#${article.articleId}">share</a></div>
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
								                    <c:when test="${!flagList}">
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
							                    <div id="<portlet:namespace/>addMyC4DCheckList_${article.articleId}" class="un-check-link n-check-off">
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
				</div>
			</c:if>
      </div>
      
    </div>
    
    </div>
    
    <div class="c4d-detail-box2"> 
 		 <div class="sopd-checking-bar-box4 clearfix">
	        <c:if test="${fn:length(templateLinkList) gt 0}">
		        <div class="sopd-checking-bar-box4-subbox clearfix">
		          	<div class="sopd-c-title01" style="color: ${article.categoryColor};" data-toggle="n-collapse" data-target="#template-box">Templates <div class="sp-filter-link-aero02 ani-1"><img src="<%= request.getContextPath() %>/images/${article.categoryColorImage}"></div></div>
			        <div class="n-collapse" id="template-box">
			        <c:forEach items="${templateLinkList}" var="templateLinks">
			        	<div class="sopd-title03"><a href="${templateLinks.templateUrl}" target="_blank">${templateLinks.templateName}</a></div>
			        </c:forEach>
			        </div>
		        </div>
	        </c:if>
	        <c:if test="${fn:length(referenceLinkList) gt 0}">
		        <div class="sopd-checking-bar-box4-subbox clearfix">
		          	<div class="sopd-c-title01" style="color: ${article.categoryColor};" data-toggle="n-collapse" data-target="#references-box">References <div class="sp-filter-link-aero02 ani-1"><img src="<%= request.getContextPath() %>/images/${article.categoryColorImage}"></div></div>
		          	<div class="n-collapse" id="references-box">
		          	<c:forEach items="${referenceLinkList}" var="referenceLinks">
		          	<div class="sopd-title03"><a href="${referenceLinks.referenceUrl}" target="_blank">${referenceLinks.referenceName}</a></div>
		          	</c:forEach> </div>
		        </div>
	        </c:if> 
      	</div>
	</div>
	
   
 </div>
 
<%@include file="c4dLandingResponse_js.jsp" %>