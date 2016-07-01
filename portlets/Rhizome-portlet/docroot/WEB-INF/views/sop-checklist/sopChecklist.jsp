<%@page import="com.rhizome.domain.SOPArticles"%>
<%@page import="com.rhizome.domain.SOPCheckList" %>
<%@page import="com.rhizome.service.SOPCheckListService"%>
<%@include file="../init.jsp"%>





 <div class="clearfix">
	     <div class="" id="<portlet:namespace/>allCheckListItems_${sopScrollCount}">
	     <c:choose>
	     	<c:when test="${fn:length(sopArticles) gt 0}">
			     <c:forEach items="${sopArticles}" var="article"  varStatus="articleCounter"> 
			     	<c:set var="articleId" value="${article.id}"/>
						<%
							SOPCheckListService checkListService = (SOPCheckListService)request.getAttribute("sopCheckListService");
							SOPCheckList item = checkListService.checkSOPMyCheckListExist((Long)pageContext.getAttribute("articleId"), themeDisplay.getUserId());
							pageContext.setAttribute("item", item);
						%>
			     		<c:choose>
							<c:when test="${item.checked eq true}">
								<div class="nph-un-sop-fi-link" id="<portlet:namespace/>addFilterDivAllCheckList_${article.id}">
									<span id="<portlet:namespace/>addFilterAllCheckList_${article.id}" class="nph-un-sop-fi-link-redbox active doneItems" onclick="<portlet:namespace/>checkUncheckCheckList('${article.id}');" ></span>
									<a href="javascript:void(0);" onclick="<portlet:namespace />viewArticleDescription('${article.id}','','','${article.aricleURLTitle}');">${article.title}</a>
									<span class="nph-un-sop-fi-close-box" onclick="addRemoveFromCheckList(${article.id},this);">X</span>
								</div>
							</c:when>
							<c:otherwise>
								<div class="nph-un-sop-fi-link" id="<portlet:namespace/>addFilterDivAllCheckList_${article.id}">
									<span id="<portlet:namespace/>addFilterAllCheckList_${article.id}" class="nph-un-sop-fi-link-redbox doneItems inactive" onclick="<portlet:namespace/>checkUncheckCheckList('${article.id}');"></span>
									<a href="javascript:void(0);" onclick="<portlet:namespace />viewArticleDescription('${article.id}','','','${article.aricleURLTitle}');">${article.title}</a>
								 <span class="nph-un-sop-fi-close-box" onclick="addRemoveFromCheckList(${article.id},this);">X</span> 
								</div>
							</c:otherwise>
						</c:choose>				
			    </c:forEach>
			    </c:when>
			    <c:otherwise>
			    	<div class="empty-list-message" id="sopEmptyChecklistMessage">
			    		Currently there are no items in Checklist.
			    	</div>
			    </c:otherwise>
		    </c:choose> 
	     </div>
		 <div class="clearfix" style="position:fixed; bottom:10px; right:96px;">
			 <div class="clear-buttons">
				 <c:if test="${isChecklistEmpty}">
					<a onclick="<portlet:namespace/>clearDoneItems();" href="javascript:void(0);" class="sop-checklist-buttons" id="<portlet:namespace/>clearSopChecklistDoneItems">
						Clear Done Items
					</a>
				</c:if>	
				<br/>
				<c:if test="${fn:length(sopArticles) gt 0}">
					<a onclick="<portlet:namespace/>clearCheckList();" href="javascript:void(0);" class="sop-checklist-buttons" id="sopChecklistClearChecklistItems">
						Clear Checklist
					</a>
				</c:if>
			 </div>
			 <!--
			   --	Hidden Temporary
					<div style="width:110px; margin:0 auto 10px auto;" class="clearfix"><div class="sopd-mail-icon">
						<a href="javascript:void(0);" onclick="<portlet:namespace/>emailCurrentPageSOP();">mail</a>
					 </div>
			 -->
		 
			<portlet:resourceURL var="printSOPChecklistURL" id="printSOPChecklist" escapeXml="false" />
		     <c:if test="${fn:length(sopArticles) gt 0}">
			     <div class="sopd-print-icon">
			     	<a href="<%=printSOPChecklistURL%>" target="_blank">print</a>
			     </div> 
	     	</c:if>

		</div>
	 </div>
<%@include file="sopChecklist_js.jsp"%> 