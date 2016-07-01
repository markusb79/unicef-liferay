<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<%
	ThemeDisplay td = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	pageContext.setAttribute("signedIn", td.isSignedIn());
%>

<c:if test="${not signedIn}">
	<style>  
		@media only screen and (min-width:1277px) and (max-width:1378px) {
			/* .sopd-content-rowbox { margin-top: 107px !important; } */
		}
	</style>
</c:if>

<liferay-theme:defineObjects />

<input type="hidden" id="<portlet:namespace/>time24Hours" value="${time24Hours}" />
<input type="hidden" id="<portlet:namespace/>time72Hours" value="${time72Hours}" />
<input type="hidden" id="<portlet:namespace/>time14Days" value="${time14Days}" />
<input type="hidden" id="<portlet:namespace/>time15Days" value="${time15Days}" />

<input type="hidden" id="<portlet:namespace/>catOB" value="${catOB}" />
<input type="hidden" id="<portlet:namespace/>catCoAd" value="${catCoAd}" />
<input type="hidden" id="<portlet:namespace/>catTechHR" value="${catTechHR}" />
<input type="hidden" id="<portlet:namespace/>catInfoMg" value="${catInfoMg}" />
<input type="hidden" id="<portlet:namespace/>catExtCom" value="${catExtCom}" />
<input type="hidden" id="<portlet:namespace/>catFnLg" value="${catFnLg}" />
<input type="hidden" id="<portlet:namespace/>catContext" value="${catContext}" />

<input type="hidden" id="<portlet:namespace/>resCountry" value="${resCountry}" />
<input type="hidden" id="<portlet:namespace/>resUnicef" value="${resUnicef}" />
<input type="hidden" id="<portlet:namespace/>resWho" value="${resWho}" />
<input type="hidden" id="<portlet:namespace/>resRpdRes" value="${resRpdRes}" />
<input type="hidden" id="<portlet:namespace/>resSrgTeam" value="${resSrgTeam}" />
<input type="hidden" id="<portlet:namespace/>result" value=""/>

 <div class="un-body-container">
<div class="body-container clearfix ani-1" id="main-div">
	<div id="un-sop-navigation-container">
		<div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
	      <div class="un-nsm-link cat-1"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#sop-sm-submenu" data-collapse-group="myDivs">+ SOP</a></div>
	      <div class="n-collapse clearfix" id="sop-sm-submenu" aria-expanded="false">
	        <div class="un-filter-linkbox">

	          <div class="un-sop-fil-head01" data-toggle="n-collapse" data-target="#un-fi-time" data-collapse-group="myDivs02">Time</div>
	          <div id="un-fi-time" class="n-collapse clearfix" aria-expanded="false">
	<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Time_24_m" onclick="displaySOPArticles(0,'Time','24_HOURS');"> <a href="javascript:void(0);">24 HOURS</a> </div>
						<div class="un-sop-fi-link" id="SOP_Time_72_m" onclick="displaySOPArticles(0,'Time','72_HOURS');"><a href="javascript:void(0);">72 HOURS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_14_m" onclick="displaySOPArticles(0,'Time','14_DAYS');"><a href="javascript:void(0);">14 DAYS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_15_m" onclick="displaySOPArticles(0,'Time','15_DAYS');"><a href="javascript:void(0);">15 DAYS - CLOSE</a></div>
	                    <div class="un-sop-fi-title01 clearfix"><span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'TimeRemove','TimeRemove');">Clear filters</a></span> </div>
					</div>


	</div>

	          <div class="un-sop-fil-head01"  data-toggle="n-collapse" data-target="#un-fi-category" data-collapse-group="myDivs02">Category</div>
	          <div id="un-fi-category" class="n-collapse clearfix" aria-expanded="false">
				<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Cat_OutConf_m" onclick="displaySOPArticles(0,'Time','Outbreak_Confirmation');"><a href="javascript:void(0);">OURBREAK<br>CONFIRMATION</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_AdvCord_m" onclick="displaySOPArticles(0,'Time','Coordination_And_Advocacy');"><a href="javascript:void(0);">COORDINATION + <br>ADVOCACY</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_TechHR_m" onclick="displaySOPArticles(0,'Time','Technical_and_Human_Resources');"><a href="javascript:void(0);">TECHNICAL + <br>HUMAN RESOURCES</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_InfoMgmt_m" onclick="displaySOPArticles(0,'Time','Information_Management');"><a href="javascript:void(0);">INFORMATION <br>MANAGEMENT</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_ExtComm_m" onclick="displaySOPArticles(0,'Time','Communication');"><a href="javascript:void(0);">COMMUNICATION</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_FinLog_m" onclick="displaySOPArticles(0,'Time','Finances_and_Logistics');"><a href="javascript:void(0);">FINANCES + <br>LOGISTICS</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_Context_m" onclick="displaySOPArticles(0,'Time','Context');"><a href="javascript:void(0);">CONTEXT</a></div>
	                    <div class="un-sop-fi-title01 clearfix"><span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'CategoryRemove','Outbreak');">Clear filters</a></span> </div>
					</div>
				</div>

	          <div class="un-sop-fil-head01"  data-toggle="n-collapse" data-target="#un-filter-respons" data-collapse-group="myDivs02">Responsibility</div>
	          <div id="un-filter-respons" class="n-collapse clearfix" aria-expanded="false">
					<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Res_Country_m" onclick="displaySOPArticles(0,'Time','country');"><a href="javascript:void(0);">COUNTRY</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_Unicef_m" onclick="displaySOPArticles(0,'Time','unicef');"><a href="javascript:void(0);">UNICEF</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_Who_m" onclick="displaySOPArticles(0,'Time','who');"><a href="javascript:void(0);">WHO</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_RpdRs_m" onclick="displaySOPArticles(0,'Time','rapid_response');"><a href="javascript:void(0);">RAPID RESPONSE</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_SrgTm_m" onclick="displaySOPArticles(0,'Time','surge_team');"><a href="javascript:void(0);">SURGE TEAM</a></div>
	                    <div class="un-sop-fi-title01 clearfix"><span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'ResponsibilityRemove','Unicef');">Clear filters</a></span> </div>
					</div>
				</div>
	        </div>

	      </div>
	      <div class="un-nsm-link cat-2"><a href="/web/guest/c4d">+ C4D</a></div>
	      <div class="un-nsm-link cat-3"><a href="http://db.rhizome.work" data-toggle="n-collapse" data-target="#data-submenu" data-collapse-group="myDivs">+ DATA</a></div>
	      <c:choose>
	        <c:when test="<%=themeDisplay.isSignedIn() %>">
	            <div class="un-nsm-link cat-3"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#sop-sm-mytoolkit-box" data-collapse-group="myDivs">+ MY TOOLKIT</a></div>
	        </c:when>
	        <c:otherwise>
	            <div class="un-nsm-link cat-3"><a href="#loginBox" class="various3">+ MY TOOLKIT</a></div>
	        </c:otherwise>
	      </c:choose>
	      <div id="sop-sm-mytoolkit-box" class="n-collapse clearfix" aria-expanded="false">
	        <div class="sop-mytoolkit-link01">
	         <!--a href="#">Bookmarks</a-->
	         <a href="#" id="<portlet:namespace/>sopMytoolkitChecklist">Checklist</a>
	         <a href="#">Profile</a>
	         <a href="/c/portal/logout">Log out</a>
	        </div>
	      </div>


	      <!--div class="un-nsm-link"><a href="#">ABOUT</a></div>
	      <div class="un-nsm-link"><a href="#">REPORT A BUG</a></div>
	      <div class="un-nsm-link"><a href="#">SITEMAP</a></div-->
			<div class="un-nsm-link"><a href="/web/guest/contact">CONTACT US</a></div>
	    </div>
		<div class="clearfix" id="un-navigation-big">
			<div class="un-navmenu-mainbox clearfix animaton" id="sop-big-submenu" >
			<div class="un-filter-linkbox">
			    <div class="un-filter-text"><spring:message code="filter-by" text="Filter By"></spring:message> </div>
			    <div class="un-filter-linkbox02 clearfix">

				 <div class="un-filter-link" id="un-filter-link-hmenu1" style="width: 19%; margin-left:5%;" ><a href="javascript:void(0);"><span>TIME</span></a> </div>
		         <div class="un-filter-link" id="un-filter-link-hmenu2" style="width: 35%; margin-left:-2%;"><a href="javascript:void(0);"><span>CATEGORY</span></a> </div>
		         <div class="un-filter-link" id="un-filter-link-hmenu3" style="width: 35%;"><a href="javascript:void(0);"><span>RESPONSIBILITY</span></a> </div>

		         <div class="un-fil-dd-01 n-collapse clearfix" id="sopv2-submenu1" aria-expanded="false">
	                <div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Time_24" onclick="displaySOPArticles(0,'Time','24_HOURS');"> <a href="javascript:void(0);">24 HOURS</a> </div>
						<div class="un-sop-fi-link" id="SOP_Time_72" onclick="displaySOPArticles(0,'Time','72_HOURS');"><a href="javascript:void(0);">72 HOURS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_14" onclick="displaySOPArticles(0,'Time','14_DAYS');"><a href="javascript:void(0);">14 DAYS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_15" onclick="displaySOPArticles(0,'Time','15_DAYS');"><a href="javascript:void(0);">15 DAYS - CLOSE</a></div>
	                    <div class="un-sop-fi-title01 clearfix"><span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'TimeRemove','TimeRemove');">Clear filters</a></span> </div>
					</div>
				</div>
		         <div class="un-fil-dd-02 n-collapse clearfix" id="sopv2-submenu2" aria-expanded="false">
	                <div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Cat_OutConf" onclick="displaySOPArticles(0,'Time','Outbreak_Confirmation');"><a href="javascript:void(0);">OURBREAK<br>CONFIRMATION</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_AdvCord" onclick="displaySOPArticles(0,'Time','Coordination_And_Advocacy');"><a href="javascript:void(0);">COORDINATION + <br>ADVOCACY</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_TechHR" onclick="displaySOPArticles(0,'Time','Technical_and_Human_Resources');"><a href="javascript:void(0);">TECHNICAL + <br>HUMAN RESOURCES</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_InfoMgmt" onclick="displaySOPArticles(0,'Time','Information_Management');"><a href="javascript:void(0);">INFORMATION <br>MANAGEMENT</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_ExtComm" onclick="displaySOPArticles(0,'Time','Communication');"><a href="javascript:void(0);">COMMUNICATION</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_FinLog" onclick="displaySOPArticles(0,'Time','Finances_and_Logistics');"><a href="javascript:void(0);">FINANCES + <br>LOGISTICS</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Cat_Context" onclick="displaySOPArticles(0,'Time','Context');"><a href="javascript:void(0);">CONTEXT</a></div>
	                    <div class="un-sop-fi-title01 clearfix"><span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'CategoryRemove','Outbreak');">Clear filters</a></span> </div>
					</div>
				</div>
		         <div class="un-fil-dd-03 n-collapse clearfix" id="sopv2-submenu3" aria-expanded="false">
	                <div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Res_Country" onclick="displaySOPArticles(0,'Time','country');"><a href="javascript:void(0);">COUNTRY</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_Unicef" onclick="displaySOPArticles(0,'Time','unicef');"><a href="javascript:void(0);">UNICEF</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_Who" onclick="displaySOPArticles(0,'Time','who');"><a href="javascript:void(0);">WHO</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_RpdRs" onclick="displaySOPArticles(0,'Time','rapid_response');"><a href="javascript:void(0);">RAPID RESPONSE</a></div>
	                    <div class="un-sop-fi-link" id="SOP_Res_SrgTm" onclick="displaySOPArticles(0,'Time','surge_team');"><a href="javascript:void(0);">SURGE TEAM</a></div>
	                    <div class="un-sop-fi-title01 clearfix"> <span><a href="javascript:void(0);" onclick="displaySOPArticles(0,'ResponsibilityRemove','Unicef');">Clear filters</a></span> </div>
					</div>
				</div>
			   </div>
			  </div>

			  <div class="un-navmenu-linkbox">
				<div class="un-navmenu-filt-box">Selected filters </div>
				<div class="un-navmenu-filt-box">
					<div class="un-navmenu-filt-text"></div>
				</div>

				<c:choose>
					<c:when test="<%=themeDisplay.isSignedIn() %>">
						<div class="un-navmenu-filt-box" onclick="addAllTilesToChecklist();">
							<a href="javascript:void(0);" id="<portlet:namespace/>allCheckListAdd">Add all tiles to my checklist</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="un-navmenu-filt-box"><a href="#loginBox" class="various3">Add all tiles to my checklist</a> </div>
					</c:otherwise>
				</c:choose>


			  </div>

			</div>
		</div>
	</div>

	<!-- Full filter navigation - only visible if user is at the top of the tile list -->
	<div id="un-sop-navigation-full" class="un-sop-filter-graybox clearfix">
		<div class="un-sop-filterbox">
			<div class="un-sop-fi-title01 clearfix">
				<span>Please select the filters you would like to use</span>
            <span class="clearfix">
            	<div class="unnp-linkpart01" onclick="<portlet:namespace/>selectAllFilters();">
		            <a href="javascript:void(0);" id="<portlet:namespace/>selectAll">Select All</a>
	            </div>
            	<div class="unnp-linkpart01" onclick="displaySOPArticles(0,'TimeRemove','TimeRemove'); displaySOPArticles(0,'CategoryRemove','Outbreak'); displaySOPArticles(0,'ResponsibilityRemove','Unicef');">
		            <a href="javascript:void(0);" id="<portlet:namespace/>clearFilters">Clear All</a>
	            </div>
            </span>
			</div>

			<div class="clearfix">
				<div class="un-sop-filterbox02">
					<div class="un-sop-fi-title02">TIME</div>
					<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Time_24_b" onclick="displaySOPArticles(0,'Time','24_HOURS');"><a href="javascript:void(0);">24 HOURS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_72_b" onclick="displaySOPArticles(0,'Time','72_HOURS');"><a href="javascript:void(0);">72 HOURS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_14_b" onclick="displaySOPArticles(0,'Time','14_DAYS');"><a href="javascript:void(0);">14 DAYS</a></div>
						<div class="un-sop-fi-link" id="SOP_Time_15_b" onclick="displaySOPArticles(0,'Time','15_DAYS');"><a href="javascript:void(0);">15 DAYS - CLOSE</a></div>
					</div>
				</div>

				<div class="un-sop-filterbox02">
					<div class="un-sop-fi-title02">CATEGORY	</div>
					<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Cat_OutConf_b" onclick="displaySOPArticles(0,'Time','Outbreak_Confirmation');"><a href="javascript:void(0);">OUTBREAK CONFIRMATION</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_AdvCord_b" onclick="displaySOPArticles(0,'Time','Coordination_And_Advocacy');"><a href="javascript:void(0);">COORDINATION + ADVOCACY</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_TechHR_b" onclick="displaySOPArticles(0,'Time','Technical_and_Human_Resources');"><a href="javascript:void(0);">TECHNICAL + HUMAN RESOURCES</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_InfoMgmt_b" onclick="displaySOPArticles(0,'Time','Information_Management');"><a href="javascript:void(0);">INFORMATION MANAGEMENT</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_ExtComm_b" onclick="displaySOPArticles(0,'Time','Communication');"><a href="javascript:void(0);">COMMUNICATION</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_FinLog_b" onclick="displaySOPArticles(0,'Time','Finances_and_Logistics');"><a href="javascript:void(0);">FINANCES + LOGISTICS</a></div>
						<div class="un-sop-fi-link" id="SOP_Cat_Context_b" onclick="displaySOPArticles(0,'Time','Context');"><a href="javascript:void(0);">CONTEXT</a></div>
					</div>
				</div>

				<div class="un-sop-filterbox02">
					<div class="un-sop-fi-title02">RESPONSIBILITY</div>
					<div class="un-sop-fi-link-box clearfix">
						<div class="un-sop-fi-link" id="SOP_Res_Country_b" onclick="displaySOPArticles(0,'Time','country');"><a href="javascript:void(0);">COUNTRY</a></div>
						<div class="un-sop-fi-link" id="SOP_Res_Unicef_b" onclick="displaySOPArticles(0,'Time','unicef');"><a href="javascript:void(0);">UNICEF</a></div>
						<div class="un-sop-fi-link" id="SOP_Res_Who_b" onclick="displaySOPArticles(0,'Time','who');"><a href="javascript:void(0);">WHO</a></div>
						<div class="un-sop-fi-link" id="SOP_Res_RpdRs_b" onclick="displaySOPArticles(0,'Time','rapid_response');"><a href="javascript:void(0);">RAPID RESPONSE</a></div>
						<div class="un-sop-fi-link" id="SOP_Res_SrgTm_b" onclick="displaySOPArticles(0,'Time','surge_team');"><a href="javascript:void(0);">SURGE TEAM</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- <div class="clearfix un-filter-off"> -->
    <div id="<portlet:namespace/>filterOnOff" class="clearfix un-filter-off">
		<div id="un-ss-filter-box">
		 <div class="un-navmenu-linkbox">
			<div class="un-navmenu-filt-box">Selected filters </div>
				<div class="un-navmenu-filt-box clearfix">
					<div class="un-navmenu-filt-text"></div>
				</div>
			<c:choose>
				<c:when test="<%=themeDisplay.isSignedIn() %>">
					<div class="un-navmenu-filt-box" >
						<a href="javascript:void(0);" id="<portlet:namespace/>allCheckListAdd_m">Add all tiles to my checkliT</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="un-navmenu-filt-box"><a href="#loginBox" class="various3">Add all tiles to my checklist</a> </div>
				</c:otherwise>
			</c:choose>

		  </div>
		</div>

	    <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>sopdContent">
	    </div>

	    <div id="<portlet:namespace />loadingImage" style="display: none;text-align: center;">
	        <img src="<%=request.getContextPath()%>/images/content-loading.GIF">
	    </div>
    </div>
</div>     
</div>

<%@include file="view_js.jsp" %>