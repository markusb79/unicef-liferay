<%@page import="com.rhizome.service.C4DCheckListService"%>
<%@include file="../init.jsp"%>
 
<div class="clearfix">
     <div id="<portlet:namespace/>allCheckListItems_${sopScrollCount}">
     <c:choose> 
     	<c:when test="${fn:length(c4dArticles) gt 0}">
		     <c:forEach items="${c4dArticles}" var="article"  varStatus="articleCounter"> 
		     <c:set var="articleId" value="${article.articleId}"/>
				<%
					C4DCheckListService checkListService = (C4DCheckListService)request.getAttribute("c4dCheckListService");
					boolean flag = checkListService.checkC4DMyCheckListExistList((Long)pageContext.getAttribute("articleId"), themeDisplay.getUserId());
					pageContext.setAttribute("flag",flag);
				%>
	     		<c:choose>
					<c:when test="${flag eq false}">
						<div id="<portlet:namespace/>addFilterAllCheckList_${article.articleId}" class="nph-un-sop-fi-link inactive" onclick="<portlet:namespace/>checkUncheckCheckList('${article.articleId}');">
							<a href="javascript:void(0);" class="fi-link-fix01" onclick="<portlet:namespace />viewArticleDescription('${article.articleId}','','${article.category}','${article.aricleURLTitle}');">${article.title}</a>
							<span class=".nph-un-sop-fi-close-box" onclick="removeFromToolkit(${article.articleId},this);">X</span>
						</div>
					</c:when>
					<c:otherwise>
						<div id="<portlet:namespace/>addFilterAllCheckList_${article.articleId}" class="nph-un-sop-fi-link doneItems active" onclick="<portlet:namespace/>checkUncheckCheckList('${article.articleId}');">
							<a href="javascript:void(0);" class="fi-link-fix01" onclick="<portlet:namespace />viewArticleDescription('${article.articleId}','','${article.category}','${article.aricleURLTitle}');">${article.title}</a>
							<span class="nph-un-sop-fi-close-box" onclick="removeFromToolkit(${article.articleId},this);">X</span>
						</div>
					</c:otherwise>
				</c:choose>				
		     		
		    </c:forEach>
		    </c:when>
		    <c:otherwise> 
		    	<div class="empty-list-message" id="c4dEmptyToolkitMessage">
		    		Currently there are no items in Toolkit.
		    	</div>
		    </c:otherwise>
	    </c:choose> 
     </div>
     
     
     <div class="clearfix" style="position:fixed; bottom:10px; right:96px;">
     	<!--
     		Hidden temporary
     		<div class="sopd-mail-icon">
     			<a href="javascript:void(0);" onclick="<portlet:namespace/>emailCurrentPageC4D();">mail</a>
     		</div>
     	 	
     		<div class="sopd-print-icon">
     			<a href="javascript:void(0);">print</a>
     		</div> 
     	-->
        
        <div class="clear-buttons">
     	<c:if test="${fn:length(c4dArticles) gt 0}">
	     	<a onclick="<portlet:namespace/>clearToolkit();" href="javascript:void(0);" class="c4d-toolkit-buttons" id="c4dChecklistClearItems">
	     		Clear Toolkit
	     	</a>
	     </c:if>	
     </div>
     		<portlet:resourceURL var="printC4DToolkitURL" id="printC4DToolkit" escapeXml="false" />
		     <c:if test="${fn:length(c4dArticles) gt 0}">
			     <div class="sopd-print-icon">
			     	<a href="<%=printC4DToolkitURL%>" target="_blank">print</a>
			     </div> 
	     	</c:if>
     	
    </div>
    
    
</div>
</div>
<%@include file="c4dChecklist_js.jsp"%>


<style>
.fi-link-fix01{ padding:0px !important; height:20px !important;}
</style>

