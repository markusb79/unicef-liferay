<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@page import="com.liferay.portlet.blogs.model.BlogsEntry"%>
<%@page import="com.rhizome.domain.Solution"%>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ include file="../facets/init.jsp" %>
<div class="search-facet search-asset_entries" data-facetFieldName="entryClassName" id="assetEntryfacet">
	<c:set value="${keywords}" var="keyword"></c:set>
	
	<ul class="asset-type nav nav-pills nav-stacked">
	 <%
	 			String keyword = ((String)pageContext.getAttribute("keyword"));
	            PortletURL actionURL = renderResponse.createActionURL();
	            actionURL.setParameter("action", "filter");
	            actionURL.setParameter("keywords", keyword); 
	%>            
		<li class="facet-value">
			<a data-value="" href="<%=actionURL.toString()%>&time=7">Last Week</a>
		</li>
		<li class="facet-value">
			<a data-value="" href="javascript:void(0);">Last Month</a>
		</li>
		<li class="facet-value">
			<a data-value="" href="javascript:void(0);">Last 6 months</a>
		</li>
		<li class="facet-value">
			<a data-value="" href="javascript:void(0);">Last year</a>
		</li>
		<li class="facet-value">
			<a data-value="" href="javascript:void(0);">older than 1 year</a>
		</li>
     </ul>
</div>
<style>
.seleted-filter{
 background-color: #eeeeee;
 color: #009ae5 !important;
}
</style>