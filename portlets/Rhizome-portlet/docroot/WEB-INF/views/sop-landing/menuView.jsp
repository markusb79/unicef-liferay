<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<%
	ThemeDisplay td = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	boolean signedIn = td.isSignedIn();
	pageContext.setAttribute("signedIn", signedIn);
%>

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

 <c:choose>
	<c:when test="${signedIn}">
		<style>/*  .main-container{ margin-top:148px !important;}  */
			@media only screen and (min-width:300px) and (max-width:767px) {
				.main-container {     margin-top: 0 !important; }
				}
		 </style>
	</c:when>
	<c:otherwise>
		<style> .main-container{ margin-top:96px !important;}  
		
			@media only screen and (min-width:300px) and (max-width:767px) {
			.main-container {     margin-top: 0 !important; }
			}
		
		</style>
		
	</c:otherwise>
</c:choose> 

<div class="un-body-container">
    <div class="body-container clearfix ani-1" id="main-div">
    
   <div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
		<div class="un-nsm-link cat-1">
			<a href="/web/guest/sop">+ SOP</a>
		</div>
      
      <div class="n-collapse clearfix" id="sop-sm-submenu" aria-expanded="false">
        <div class="un-filter-linkbox">
          <div class="un-filter-linkbox02 clearfix">
          </div>
        </div>
        <div class="un-navmenu-linkbox">
        </div>
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
    
    <div class="un-sop-filter-graybox clearfix">
        <div class="un-sop-filterbox">
            <div class="un-sop-fi-title01 clearfix">
            <span>Please select the filters you would like to use</span>   
            <span class="clearfix">
            	<div class="unnp-linkpart01"><a href="javascript:void(0);" id="<portlet:namespace/>selectAll">Select All</a></div>
            	<div class="unnp-linkpart01"><a href="javascript:void(0);" id="<portlet:namespace/>clearFilters">Clear All</a></div>
            </span>
            </div>
            
            <div class="clearfix">
            	<div class="un-sop-filterbox02">
                	<div class="un-sop-fi-title02">TIME</div>
	                	<div class="un-sop-fi-link-box clearfix">
	                    <div class="un-sop-fi-link" id="24_HOURS"><a href="javascript:void(0);">24 HOURS</a></div>
	                    <div class="un-sop-fi-link" id="72_HOURS"><a href="javascript:void(0);">72 HOURS</a></div>
	                    <div class="un-sop-fi-link" id="14_DAYS"><a href="javascript:void(0);">14 DAYS</a></div>
	                    <div class="un-sop-fi-link" id="15_DAYS_CLOSE"><a href="javascript:void(0);">15 DAYS - CLOSE</a></div>
                    </div>
                </div>
            
            	<div class="un-sop-filterbox02">
                	<div class="un-sop-fi-title02">CATEGORY	</div>
                	<div class="un-sop-fi-link-box clearfix">
	                    <div class="un-sop-fi-link" id="Outbreak_Confirmation"><a href="javascript:void(0);">OUTBREAK<br>CONFIRMATION</a></div>
	                    <div class="un-sop-fi-link" id="Coordination_And_Advocacy"><a href="javascript:void(0);">COORDINATION + <br>ADVOCACY</a></div>
	                    <div class="un-sop-fi-link" id="Technical_And_Human_Resource"><a href="javascript:void(0);">TECHNICAL + <br>HUMAN RESOURCES</a></div>
	                    <div class="un-sop-fi-link" id="Information_Management"><a href="javascript:void(0);">INFORMATION <br>MANAGEMENT</a></div>
	                    <div class="un-sop-fi-link" id="External_Communication"><a href="javascript:void(0);">COMMUNICATION</a></div>
	                    <div class="un-sop-fi-link" id="Finances_and_Logistics"><a href="javascript:void(0);">FINANCES + <br>LOGISTICS</a></div>
	                    <div class="un-sop-fi-link" id="context"><a href="javascript:void(0);">CONTEXT</a></div>
                    </div>
                </div>
            
            	<div class="un-sop-filterbox02">
                	<div class="un-sop-fi-title02">RESPONSIBILITY</div>
                	<div class="un-sop-fi-link-box clearfix">
	                    <div class="un-sop-fi-link" id="country"><a href="javascript:void(0);">COUNTRY</a></div>
	                    <div class="un-sop-fi-link" id="unicef"><a href="javascript:void(0);">UNICEF</a></div>
	                    <div class="un-sop-fi-link" id="who"><a href="javascript:void(0);">WHO</a></div>
	                    <div class="un-sop-fi-link" id="rapid_response"><a href="javascript:void(0);">RAPID RESPONSE</a></div>
	                    <div class="un-sop-fi-link" id="surge_team"><a href="javascript:void(0);">SURGE TEAM</a></div>
                    </div>
                </div>
            </div>
            
            <div>
            	<c:choose>
            		<c:when test="${empty noResults}">
						<input class="un-sop-filter-submit-button" onclick="submitMenuBar();" name="SUBMIT" type="submit" value="Submit">	            		
            		</c:when>
            		<c:otherwise>
            			<input class="un-sop-filter-submit-button" onclick="submitMenuBar();" name="NoResult" type="submit" value="No results - please refine your selection">
            		</c:otherwise>
            	</c:choose>
            </div>
        </div>
      </div>
    </div>
  </div>
<%@include file="../footer.jsp" %>  
 
<portlet:renderURL var="viewSOPLandingMenu">
	<portlet:param name="view" value="viewSOPLandingMenu" />
</portlet:renderURL>
			
		
  <script type="text/javascript">
  
  if($("#<portlet:namespace/>time24Hours").val() != ''){
		$("#24_HOURS").addClass( "active" );
	  } 

	if($("#<portlet:namespace/>time72Hours").val() != ''){
		$("#72_HOURS").addClass( "active" );
	  }
	if($("#<portlet:namespace/>time14Days").val() != ''){
		$("#14_DAYS").addClass( "active" );
	  }
	if($("#<portlet:namespace/>time15Days").val() != ''){
		$("#15_DAYS_CLOSE").addClass( "active" );
	  }

	if($("#<portlet:namespace/>catOB").val() != ''){
		$("#Outbreak_Confirmation").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catCoAd").val() != ''){
		$("#Coordination_And_Advocacy").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catTechHR").val() != ''){
		$("#Technical_And_Human_Resource").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catInfoMg").val() != ''){
		$("#Information_Management").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catExtCom").val() != ''){
		$("#External_Communication").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catFnLg").val() != ''){
		$("#Finances_and_Logistics").addClass( "active" );
	  }
	if($("#<portlet:namespace/>catContext").val() != ''){
		$("#context").addClass( "active" );
	  }
	
	if($("#<portlet:namespace/>resCountry").val() != ''){
		$("#country").addClass( "active" );
	  }
	if($("#<portlet:namespace/>resUnicef").val() != ''){
		$("#unicef").addClass( "active" );
	  }
	if($("#<portlet:namespace/>resWho").val() != ''){
		$("#who").addClass( "active" );
	  }
	if($("#<portlet:namespace/>resRpdRes").val() != ''){
		$("#rapid_response").addClass( "active" );
	  }
	if($("#<portlet:namespace/>resSrgTeam").val() != ''){
		$("#surge_team").addClass( "active" );
	  }
	
		  $('#24_HOURS').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#72_HOURS').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#14_DAYS').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#15_DAYS_CLOSE').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#Outbreak_Confirmation').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#Coordination_And_Advocacy').on('click', function(){
			  $(this).toggleClass("active");
		  });
  
		  $('#Technical_And_Human_Resource').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#Information_Management').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#External_Communication').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#Finances_and_Logistics').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#context').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#country').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#unicef').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#who').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#rapid_response').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#surge_team').on('click', function(){
			  $(this).toggleClass("active");
		  });
		  
		  $('#<portlet:namespace/>clearFilters').on('click', function(){
			  $(".un-sop-fi-link").removeClass( "active" );
		  });
		  
		  $('#<portlet:namespace/>selectAll').on('click', function(){
			  $(".un-sop-fi-link").addClass( "active" );
		  });
		  
	  submitMenuBar = function(){
		  if(!$(".un-sop-fi-link").hasClass("active")){
			  alert('Please select the filters you would like to use');
		  }else{
			  javascript:<portlet:namespace />menuViewDisplay('<%=viewSOPLandingMenu.toString() %>');	
		  }
	  }
	  
	  <portlet:namespace />menuViewDisplay = function(url){
	
			var time24Hours = $('#24_HOURS').attr('class'); 
			var time72Hours = $('#72_HOURS').attr('class');
			var time14Days = $('#14_DAYS').attr('class');
			var time15Days = $('#15_DAYS_CLOSE').attr('class');
			
			var catOutBreak = $('#Outbreak_Confirmation').attr('class');
			var catCoAndAdv = $('#Coordination_And_Advocacy').attr('class');
			var catTechAndHR = $('#Technical_And_Human_Resource').attr('class');
			var catInfoMgmt = $('#Information_Management').attr('class');
			var catExtComm = $('#External_Communication').attr('class');
			var catFinAndLog = $('#Finances_and_Logistics').attr('class');
			var catContext = $('#context').attr('class');
			
			var resCountry = $('#country').attr('class');
			var resUnicef = $('#unicef').attr('class');
			var resWho = $('#who').attr('class');
			var resRapidRes = $('#rapid_response').attr('class');
			var resSurgeTeam = $('#surge_team').attr('class');
			
			var time24HoursId='';
			var time72HoursId='';
			var time14DaysId='';
			var time15DaysId='';
			
			if(time24Hours.indexOf('active') != -1){
				time24HoursId='&time24=24_HOURS';
			}
			
			if(time72Hours.indexOf('active') != -1){
				time72HoursId='&time72=72_HOURS';
			}
			
			if(time14Days.indexOf('active') != -1){
				time14DaysId='&time14=14_DAYS';
			}
			
			if(time15Days.indexOf('active') != -1){
				time15DaysId='&time15=15_DAYS-CLOSE';
			}
			
			var catOutBreakId='';
			var catCoAndAdvId='';
			var catTechAndHRId='';
			var catInfoMgmtId='';
			var catExtCommId='';
			var catFinAndLogId='';
			var catContextId='';
			
			if(catOutBreak.indexOf('active') != -1){
				catOutBreakId='&catOB=Outbreak_Confirmation';
			}
			
			if(catCoAndAdv.indexOf('active') != -1){
				catCoAndAdvId = '&catCoAd=Coordination_And_Advocacy';
			}
			
			if(catTechAndHR.indexOf('active') != -1){
				catTechAndHRId = '&catTechHR=Technical_and_Human_Resources';
			}
			
			if(catInfoMgmt.indexOf('active') != -1){
				catInfoMgmtId = '&catInfoMg=Information_Management';
			}
			
			if(catExtComm.indexOf('active') != -1){
				catExtCommId = '&catExtCom=Communication';
			}
			
			if(catFinAndLog.indexOf('active') != -1){
				catFinAndLogId = '&catFnLg=Finances_and_Logistics';
			}
			
			if(catContext.indexOf('active') != -1){
				catContextId = '&catContext=Context';
			}
			
			var resCountryId='';
			var resUnicefId='';
			var resWhoId='';
			var resRapidResId='';
			var resSurgeTeamId='';
			
			if(resCountry.indexOf('active') != -1){
				resCountryId = '&resCountry=country';
			}
			
			if(resUnicef.indexOf('active') != -1){
				resUnicefId = '&resUnicef=unicef';
			}
			
			if(resWho.indexOf('active') != -1){
				resWhoId = '&resWho=who';
			}
			
			if(resRapidRes.indexOf('active') != -1){
				resRapidResId = '&resRpdRes=rapid_response';
			}
			
			if(resSurgeTeam.indexOf('active') != -1){
				resSurgeTeamId = '&resSrgTeam=surge_team';
			}
			console.log("WINDOW2 " + url+time24HoursId+time72HoursId+time14DaysId+time15DaysId
					+catOutBreakId+catCoAndAdvId+catTechAndHRId+catInfoMgmtId+catExtCommId+catFinAndLogId+catContextId+
					resCountryId+resUnicefId+resWhoId+resRapidResId+resSurgeTeamId);
			window.location.href = url+time24HoursId+time72HoursId+time14DaysId+time15DaysId
			+catOutBreakId+catCoAndAdvId+catTechAndHRId+catInfoMgmtId+catExtCommId+catFinAndLogId+catContextId+
			resCountryId+resUnicefId+resWhoId+resRapidResId+resSurgeTeamId;
	  } 
  
  </script>