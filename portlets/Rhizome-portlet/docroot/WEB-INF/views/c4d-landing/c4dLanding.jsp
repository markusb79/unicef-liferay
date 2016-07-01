<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<%-- <input type="hidden" id="<portlet:namespace/>action" value="${action}"> --%>

<div class="un-body-container">
  <div class="body-container clearfix ani-1" id="main-div"> 
    
    <!--  Navigation   -->
    <div id="un-navigation-small" class="n-collapse clearfix">
    
        <div id="un-navigation-small" class="clearfix">
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>understandTab_m" onclick="displayC4DArticles(0,'Understand');" style="background-color:#7E9B00;cursor: pointer;"><a href="javascript:void(0);" >1. UNDERSTAND</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>planTab_m" onclick="displayC4DArticles(0,'Plan');" style="background-color:#3A61C9;cursor: pointer;"><a href="javascript:void(0);" >2. PLAN</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>actTab_m" onclick="displayC4DArticles(0,'Act');" style="background-color:#008A54;cursor: pointer;"><a href="javascript:void(0);" >3. ACT</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>toolsTab_m" onclick="displayC4DArticles(0,'Tools');" style="background-color:#33B1B7;cursor: pointer;"><a href="javascript:void(0);" >4. TOOLS</a></div>
    
    </div>
    
    
    </div>
    <div class="clearfix" id="un-navigation-big">
            <div class="un-c4d-navmenu-linkbox">
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>understandTab" onclick="displayC4DArticles(0,'Understand');" style="background-color:#7E9B00;cursor: pointer;"><a href="javascript:void(0);">1. UNDERSTAND</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>planTab" onclick="displayC4DArticles(0,'Plan');" style="background-color:#3A61C9;cursor: pointer;"><a href="javascript:void(0);">2. PLAN</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>actTab" onclick="displayC4DArticles(0,'Act');" style="background-color:#008A54;cursor: pointer;"><a href="javascript:void(0);">3. ACT</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>toolsTab" onclick="displayC4DArticles(0,'Tools');" style="background-color:#33B1B7;cursor: pointer;"><a href="javascript:void(0);">4. TOOLS</a></div>
        </div>
    
    </div>
    <div class="clearfix un-filter-off" id="<portlet:namespace/>c4dContent">
	    <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>c4dContent">
	    </div>
    </div>
    	
    </div>
</div>    
    
<%@include file="c4dLanding_js.jsp" %>