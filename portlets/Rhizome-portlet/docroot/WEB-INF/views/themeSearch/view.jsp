<%@include file="../init.jsp"%>
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@page import="com.liferay.portal.service.LayoutLocalServiceUtil" %>

<div class="un-search-bar">
  <aui:input name="rhizomeThemeSearch" placeholder="Type Here"></aui:input>
</div>

<portlet:resourceURL var="suggestWords" id="suggestWords">
</portlet:resourceURL>


<%
	long structureId = PortalUtil.getPlidFromPortletId(themeDisplay.getScopeGroupId(), "RhizomeSearch_WAR_Rhizomeportlet"); 
/*	long structureId=LayoutLocalServiceUtil.getFriendlyURLLayout(themeDisplay.getScopeGroupId(), false, "/search").getPlid(); */
%>

<liferay-portlet:renderURL portletName="RhizomeSearch_WAR_Rhizomeportlet"  var="searchRhizomeURL" plid="<%=structureId %>" varImpl="searchRhizomeURL" windowState="<%=LiferayWindowState.NORMAL.toString()%>">
</liferay-portlet:renderURL>
		
<script type="text/javascript">

$(document).ready(function () {
	  $("#<portlet:namespace/>rhizomeThemeSearch").keypress(function (e) {
	         var code = (e.keyCode ? e.keyCode : e.which);
	         if (code == 13 && !e.shiftKey) {
	            var keyword = $("#<portlet:namespace/>rhizomeThemeSearch").val();
	            var searchURL = '<%=searchRhizomeURL.toString()%>&keywords='+keyword;
	            javascript:<portlet:namespace />viewSearchResultLink(searchURL);
	         }else{
	    return;
	   }
	     });
});

<portlet:namespace />viewSearchResultLink = function(url){
	window.location.href = url;
} 
</script>
<aui:script>
AUI().use('autocomplete-list','aui-base','aui-io-request','autocomplete-filters','autocomplete-highlighters','aui-datepicker',
 function(A)
 {
  var url = '<%=suggestWords.toString()%>';
  A.io.request(url,
  {
   dataType:'json',
   method:'GET',
   on: {
    success: function() 
    {
     new A.AutoCompleteList(
     {
      allowBrowserAutocomplete: 'true',
      activateFirstItem: 'true',
      inputNode: '#<portlet:namespace />rhizomeThemeSearch',
      resultTextLocator: 'key',
      resultTextLocator: 'name',
      render: 'true',
      resultHighlighter: 'phraseMatch',
      resultFilters:['phraseMatch'],
      source:this.get('responseData')
     });
    }
   }
  });
  });
</aui:script>
<style>
.control-label{
	display: none !important;
}
</style>