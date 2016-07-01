<%@include file="../init.jsp"%>
<portlet:resourceURL var="viewSOPLandingControllerScrollURL" id="viewSOPLandingControllerScroll" />
<portlet:resourceURL var="addToCheckListURL" id="addToCheckList" />
<portlet:resourceURL var="addAllTilesToCheckListURL" id="addAllTilesToCheckList" />

<script type="text/javascript">
	<portlet:namespace/>loadFiltersFromCookies();

	var ajaxInProgress = false;

	//	var sopItemsArray = new Array();
	var checkit = window.check_var;
	if (checkit === undefined) { //file never entered. the global var was not set.
		 var sopScrollCount = 0;
		 var mainCategory = '${mainCategory}';
		 var detailView = '${detailView}';
		 if(detailView == 'true'){
			 var subcategoryValue = '${subCategoryValue}';
			 ajaxInProgress = true;

			 displaySOPArticles(sopScrollCount,mainCategory,subcategoryValue);
		 } else {
			 if(mainCategory == ""){
				 mainCategory = "time"
			 }
			 var subFilter = "";
			 var sopArticleSize = 0;
			 ajaxInProgress = true;

			 displaySOPArticles(sopScrollCount,mainCategory,subFilter);
		 }
	     window.check_var = 1;
	}

	$(window).scroll(function() {
		 <portlet:namespace/>adjustFilterSize();

		// user scrolled to bottom of the page?
		if($(window).scrollTop() + $(window).height() == $(document).height()){
			var countValue = $("input[name='<portlet:namespace/>sopCountValue']").last().val();
			var filter = $("input[name='<portlet:namespace/>sopFilterValue']").last().val();
			var subFilter = $("input[name='<portlet:namespace/>sopSubFilterValue']").last().val();

			// Prevent multiple sections of tiles being loaded at the same time:
			if (ajaxInProgress) return;
			ajaxInProgress = true;
			  
			displaySOPArticles(countValue, filter, subFilter);
		}

	});

	$(document).ready(function() {
		$(window).scroll(); // trigger scroll event to make sure the right navigation is shown and margins are adjusted
	});

	function <portlet:namespace/>adjustFilterSize() {
		// Logic for hiding the large navigation when the user scrolls down and for bringing it back up when he scrolls to the top
		var distanceY = window.pageYOffset || document.documentElement.scrollTop;
		var shrinkOn = 400;

		//console.log('distanceY: ' + distanceY);
		if (distanceY > shrinkOn) {
			if ($('#un-sop-navigation-full').is(':visible')) {
				//console.log('Switching to small filter view');
				$('#un-sop-navigation-full').hide(); //slideUp();
				$('#un-sop-navigation-container').show(); //slideDown();
				$('#<portlet:namespace/>sopdContent').css('margin-top', shrinkOn + 'px');
			}
		} else {
			if ($('#un-sop-navigation-container').is(':visible')) {
				//console.log('Switching to large filter view');
				$('#un-sop-navigation-container').hide(); //slideUp();
				$('#un-sop-navigation-full').show(); //slideDown();
				$('#<portlet:namespace/>sopdContent').css('margin-top', '4px');
			}
		}
	}

var listSize = "";

var filterArray = [];

function displayAppliedFilter(filterArray) {
	var alertMessage = "You have selected the following filters : \n ";
	//alert(alertMessage + filterArray.join(", "));
}

function removeFilterFromArray(filterValue) {
	// validate filter index value
	if(filterArray.indexOf(filterValue) >=0 ) { 
		filterArray.splice(filterArray.indexOf(filterValue), 1 );
	}	
}

function  displaySOPArticles(sopScrollCount, filter, subFilter){

	$('.un-filter-link a').removeClass('active');
	$('#<portlet:namespace/>'+filter).addClass('active');
	$('#<portlet:namespace/>_m_'+filter).addClass('active');
	filter = typeof filter == 'undefined' ? '' : filter.toLocaleLowerCase();
	
	if(filter == 'timeremove'){
		$("#<portlet:namespace/>time24Hours").val("");
		$("#<portlet:namespace/>time72Hours").val("");
		$("#<portlet:namespace/>time14Days").val("");
		$("#<portlet:namespace/>time15Days").val("");
		
		$("#SOP_Time_24").removeClass("active");
		$("#SOP_Time_24_m").removeClass("active");
		$("#SOP_Time_24_b").removeClass("active");
		$("#SOP_Time_72").removeClass("active");
		$("#SOP_Time_72_m").removeClass("active");
		$("#SOP_Time_72_b").removeClass("active");
		$("#SOP_Time_14").removeClass("active");
		$("#SOP_Time_14_m").removeClass("active");
		$("#SOP_Time_14_b").removeClass("active");
		$("#SOP_Time_15").removeClass("active");
		$("#SOP_Time_15_m").removeClass("active");
		$("#SOP_Time_15_b").removeClass("active");
		filterArray = [];
	}

	if(filter == 'categoryremove'){
		$("#<portlet:namespace/>catOB").val("");
		$("#<portlet:namespace/>catCoAd").val("");
		$("#<portlet:namespace/>catTechHR").val("");
		$("#<portlet:namespace/>catInfoMg").val("");
		$("#<portlet:namespace/>catExtCom").val("");
		$("#<portlet:namespace/>catFnLg").val("");
		$("#<portlet:namespace/>catContext").val("");
		
		$("#SOP_Cat_OutConf").removeClass("active");
		$("#SOP_Cat_OutConf_m").removeClass("active");
		$("#SOP_Cat_OutConf_b").removeClass("active");
		$("#SOP_Cat_AdvCord").removeClass("active");
		$("#SOP_Cat_AdvCord_m").removeClass("active");
		$("#SOP_Cat_AdvCord_b").removeClass("active");
		$("#SOP_Cat_TechHR").removeClass("active");
		$("#SOP_Cat_TechHR_m").removeClass("active");
		$("#SOP_Cat_TechHR_b").removeClass("active");
		$("#SOP_Cat_InfoMgmt").removeClass("active");
		$("#SOP_Cat_InfoMgmt_m").removeClass("active");
		$("#SOP_Cat_InfoMgmt_b").removeClass("active");
		$("#SOP_Cat_ExtComm").removeClass("active");
		$("#SOP_Cat_ExtComm_m").removeClass("active");
		$("#SOP_Cat_ExtComm_b").removeClass("active");
		$("#SOP_Cat_FinLog").removeClass("active");
		$("#SOP_Cat_FinLog_m").removeClass("active");
		$("#SOP_Cat_FinLog_b").removeClass("active");
		$("#SOP_Cat_Context").removeClass("active");
		$("#SOP_Cat_Context_m").removeClass("active");
		$("#SOP_Cat_Context_b").removeClass("active");
	}
	
	if(filter == 'responsibilityremove'){
		$("#<portlet:namespace/>resCountry").val("");
		$("#<portlet:namespace/>resUnicef").val("");
		$("#<portlet:namespace/>resWho").val("");
		$("#<portlet:namespace/>resRpdRes").val("");
		$("#<portlet:namespace/>resSrgTeam").val("");
		
		$("#SOP_Res_Country").removeClass("active");
		$("#SOP_Res_Country_m").removeClass("active");
		$("#SOP_Res_Country_b").removeClass("active");
		$("#SOP_Res_Unicef").removeClass("active");
		$("#SOP_Res_Unicef_m").removeClass("active");
		$("#SOP_Res_Unicef_b").removeClass("active");
		$("#SOP_Res_Who").removeClass("active");
		$("#SOP_Res_Who_m").removeClass("active");
		$("#SOP_Res_Who_b").removeClass("active");
		$("#SOP_Res_RpdRs").removeClass("active");
		$("#SOP_Res_RpdRs_m").removeClass("active");
		$("#SOP_Res_RpdRs_b").removeClass("active");
		$("#SOP_Res_SrgTm").removeClass("active");
		$("#SOP_Res_SrgTm_m").removeClass("active");
		$("#SOP_Res_SrgTm_b").removeClass("active");
	}
	
	if(subFilter == '24_HOURS'){
		if($("#SOP_Time_24").hasClass("active")){
			$("#SOP_Time_24").removeClass("active");
			$("#SOP_Time_24_m").removeClass("active");
			$("#SOP_Time_24_b").removeClass("active");
			$("#<portlet:namespace/>time24Hours").val("");
			
			removeFilterFromArray("24 HOURS");
			
		}else{
			$("#<portlet:namespace/>time24Hours").val("24_HOURS");
	
			filterArray.push("24 HOURS");
			
			displayAppliedFilter(filterArray);
			
		}
	}
	if(subFilter == '72_HOURS'){
		if($("#SOP_Time_72").hasClass("active")){
			$("#SOP_Time_72").removeClass("active");
			$("#SOP_Time_72_m").removeClass("active");
			$("#SOP_Time_72_b").removeClass("active");
			$("#<portlet:namespace/>time72Hours").val("");
			
			removeFilterFromArray("72 HOURS");
		}else{
			$("#<portlet:namespace/>time72Hours").val("72_HOURS");
			
			filterArray.push("72 HOURS");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == '14_DAYS'){
		if($("#SOP_Time_14").hasClass("active")){
			$("#SOP_Time_14").removeClass("active");
			$("#SOP_Time_14_m").removeClass("active");
			$("#SOP_Time_14_b").removeClass("active");
			$("#<portlet:namespace/>time14Days").val("");
			
			removeFilterFromArray("14 DAYS");
		}else{
			$("#<portlet:namespace/>time14Days").val("14_DAYS");
			
			filterArray.push("14 DAYS");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == '15_DAYS' || subFilter == '15_DAYS-CLOSE'){
		if($("#SOP_Time_15").hasClass("active")){
			$("#SOP_Time_15").removeClass("active");
			$("#SOP_Time_15_m").removeClass("active");
			$("#SOP_Time_15_b").removeClass("active");
			$("#<portlet:namespace/>time15Days").val("");
			
			removeFilterFromArray("15 DAYS-CLOSE");
		}else{
			$("#<portlet:namespace/>time15Days").val("15_DAYS-CLOSE");
			
			filterArray.push("15 DAYS-CLOSE");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Outbreak_Confirmation'){
		if($("#SOP_Cat_OutConf").hasClass("active")){
			$("#SOP_Cat_OutConf").removeClass("active");
			$("#SOP_Cat_OutConf_m").removeClass("active");
			$("#SOP_Cat_OutConf_b").removeClass("active");
			$("#<portlet:namespace/>catOB").val("");
			
			removeFilterFromArray("OUTBREAK CONFIRMATION");
		}else{
			$("#<portlet:namespace/>catOB").val("Outbreak_Confirmation");
			
			filterArray.push("OUTBREAK CONFIRMATION");
			displayAppliedFilter(filterArray);
			
		}
	}
	
	if(subFilter == 'Coordination_And_Advocacy'){
		if($("#SOP_Cat_AdvCord").hasClass("active")){
			$("#SOP_Cat_AdvCord").removeClass("active");
			$("#SOP_Cat_AdvCord_m").removeClass("active");
			$("#SOP_Cat_AdvCord_b").removeClass("active");
			$("#<portlet:namespace/>catCoAd").val("");
			
			removeFilterFromArray("COORDINATION + ADVOCACY");
		}else{
			$("#<portlet:namespace/>catCoAd").val("Coordination_And_Advocacy");

			filterArray.push("COORDINATION + ADVOCACY");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Technical_and_Human_Resources'){
		if($("#SOP_Cat_TechHR").hasClass("active")){
			$("#SOP_Cat_TechHR").removeClass("active");
			$("#SOP_Cat_TechHR_m").removeClass("active");
			$("#SOP_Cat_TechHR_b").removeClass("active");
			$("#<portlet:namespace/>catTechHR").val("");
			
			removeFilterFromArray("TECHNICAL + HUMAN RESOURCES");
		}else{
			$("#<portlet:namespace/>catTechHR").val("Technical_and_Human_Resources");
			
			filterArray.push("TECHNICAL + HUMAN RESOURCES");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Information_Management'){
		if($("#SOP_Cat_InfoMgmt").hasClass("active")){
			$("#SOP_Cat_InfoMgmt").removeClass("active");
			$("#SOP_Cat_InfoMgmt_m").removeClass("active");
			$("#SOP_Cat_InfoMgmt_b").removeClass("active");
			$("#<portlet:namespace/>catInfoMg").val("");
			
			removeFilterFromArray("INFORMATION MANAGEMENT");
		}else{
			$("#<portlet:namespace/>catInfoMg").val("Information_Management");

			filterArray.push("INFORMATION MANAGEMENT");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Communication'){
		if($("#SOP_Cat_ExtComm").hasClass("active")){
			$("#SOP_Cat_ExtComm").removeClass("active");
			$("#SOP_Cat_ExtComm_m").removeClass("active");
			$("#SOP_Cat_ExtComm_b").removeClass("active");
			$("#<portlet:namespace/>catExtCom").val("");
			
			removeFilterFromArray("COMMUNICATION");
		}else{
			$("#<portlet:namespace/>catExtCom").val("Communication");
			
			filterArray.push("COMMUNICATION");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Finances_and_Logistics'){
		if($("#SOP_Cat_FinLog").hasClass("active")){
			$("#SOP_Cat_FinLog").removeClass("active");
			$("#SOP_Cat_FinLog_m").removeClass("active");
			$("#SOP_Cat_FinLog_b").removeClass("active");
			$("#<portlet:namespace/>catFnLg").val("");
			
			removeFilterFromArray("FINANCES + LOGISTICS");
		}else{
			$("#<portlet:namespace/>catFnLg").val("Finances_and_Logistics");

			filterArray.push("FINANCES + LOGISTICS");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'Context'){
		if($("#SOP_Cat_Context").hasClass("active")){
			$("#SOP_Cat_Context").removeClass("active");
			$("#SOP_Cat_Context_m").removeClass("active");
			$("#SOP_Cat_Context_b").removeClass("active");
			$("#<portlet:namespace/>catContext").val("");
			
			removeFilterFromArray("CONTEXT");
		}else{
			$("#<portlet:namespace/>catContext").val("Context");
			
			filterArray.push("CONTEXT");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'country'){
		if($("#SOP_Res_Country").hasClass("active")){
			$("#SOP_Res_Country").removeClass("active");
			$("#SOP_Res_Country_m").removeClass("active");
			$("#SOP_Res_Country_b").removeClass("active");
			$("#<portlet:namespace/>resCountry").val("");
			
			removeFilterFromArray("COUNTRY");
		}else{
			$("#<portlet:namespace/>resCountry").val("country");
			
			filterArray.push("COUNTRY");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'unicef'){
		if($("#SOP_Res_Unicef").hasClass("active")){
			$("#SOP_Res_Unicef").removeClass("active");
			$("#SOP_Res_Unicef_m").removeClass("active");
			$("#SOP_Res_Unicef_b").removeClass("active");
			$("#<portlet:namespace/>resUnicef").val("");
		
			removeFilterFromArray("UNICEF");
		}else{
			$("#<portlet:namespace/>resUnicef").val("unicef");

			filterArray.push("UNICEF");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'who'){
		if($("#SOP_Res_Who").hasClass("active")){
			$("#SOP_Res_Who").removeClass("active");
			$("#SOP_Res_Who_m").removeClass("active");
			$("#SOP_Res_Who_b").removeClass("active");
			$("#<portlet:namespace/>resWho").val("");
			
			removeFilterFromArray("WHO");
		}else{
			$("#<portlet:namespace/>resWho").val("who");

			filterArray.push("WHO");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'rapid_response'){
		if($("#SOP_Res_RpdRs").hasClass("active")){
			$("#SOP_Res_RpdRs").removeClass("active");
			$("#SOP_Res_RpdRs_m").removeClass("active");
			$("#SOP_Res_RpdRs_b").removeClass("active");
			$("#<portlet:namespace/>resRpdRes").val("");
			
			removeFilterFromArray("RAPIC RESPONSE");
		}else{
			$("#<portlet:namespace/>resRpdRes").val("rapid_response");

			filterArray.push("RAPIC RESPONSE");
			displayAppliedFilter(filterArray);
		}
	}
	
	if(subFilter == 'surge_team'){
		if($("#SOP_Res_SrgTm").hasClass("active")){
			$("#SOP_Res_SrgTm").removeClass("active");
			$("#SOP_Res_SrgTm_m").removeClass("active");
			$("#SOP_Res_SrgTm_b").removeClass("active");
			$("#<portlet:namespace/>resSrgTeam").val("");
			
			removeFilterFromArray("SURGE TEAM");
		}else{
			$("#<portlet:namespace/>resSrgTeam").val("surge_team");
			
			filterArray.push("SURGE TEAM");
			displayAppliedFilter(filterArray);
		}
	}
	if ($("#<portlet:namespace/>time24Hours").val() != ''){
		$("#SOP_Time_24").addClass("active");
		$("#SOP_Time_24_m").addClass("active");
		$("#SOP_Time_24_b").addClass("active");
	}
	if ($("#<portlet:namespace/>time72Hours").val() != ''){
		$("#SOP_Time_72").addClass("active");
		$("#SOP_Time_72_m").addClass("active");
		$("#SOP_Time_72_b").addClass("active");
	}
	if ($("#<portlet:namespace/>time14Days").val() != ''){
		$("#SOP_Time_14").addClass("active");
		$("#SOP_Time_14_m").addClass("active");
		$("#SOP_Time_14_b").addClass("active");
	}
	if ($("#<portlet:namespace/>time15Days").val() != ''){
		$("#SOP_Time_15").addClass("active");
		$("#SOP_Time_15_m").addClass("active");
		$("#SOP_Time_15_b").addClass("active");
	}
	
	if ($("#<portlet:namespace/>catOB").val() != ''){
		$("#SOP_Cat_OutConf").addClass("active");
		$("#SOP_Cat_OutConf_m").addClass("active");
		$("#SOP_Cat_OutConf_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catCoAd").val() != ''){
		$("#SOP_Cat_AdvCord").addClass("active");
		$("#SOP_Cat_AdvCord_m").addClass("active");
		$("#SOP_Cat_AdvCord_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catTechHR").val() != ''){
		$("#SOP_Cat_TechHR").addClass("active");
		$("#SOP_Cat_TechHR_m").addClass("active");
		$("#SOP_Cat_TechHR_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catInfoMg").val() != ''){
		$("#SOP_Cat_InfoMgmt").addClass("active");
		$("#SOP_Cat_InfoMgmt_m").addClass("active");
		$("#SOP_Cat_InfoMgmt_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catExtCom").val() != ''){
		$("#SOP_Cat_ExtComm").addClass("active");
		$("#SOP_Cat_ExtComm_m").addClass("active");
		$("#SOP_Cat_ExtComm_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catFnLg").val() != ''){
		$("#SOP_Cat_FinLog").addClass("active");
		$("#SOP_Cat_FinLog_m").addClass("active");
		$("#SOP_Cat_FinLog_b").addClass("active");
	}
	if ($("#<portlet:namespace/>catContext").val() != ''){
		$("#SOP_Cat_Context").addClass("active");
		$("#SOP_Cat_Context_m").addClass("active");
		$("#SOP_Cat_Context_b").addClass("active");
	}
	
	if ($("#<portlet:namespace/>resCountry").val() != ''){
		$("#SOP_Res_Country").addClass("active");
		$("#SOP_Res_Country_m").addClass("active");
		$("#SOP_Res_Country_b").addClass("active");
	}
	if ($("#<portlet:namespace/>resUnicef").val() != ''){
		$("#SOP_Res_Unicef").addClass("active");
		$("#SOP_Res_Unicef_m").addClass("active");
		$("#SOP_Res_Unicef_b").addClass("active");
	}
	if ($("#<portlet:namespace/>resWho").val() != ''){
		$("#SOP_Res_Who").addClass("active");
		$("#SOP_Res_Who_m").addClass("active");
		$("#SOP_Res_Who_b").addClass("active");
	}
	if ($("#<portlet:namespace/>resRpdRes").val() != ''){
		$("#SOP_Res_RpdRs").addClass("active");
		$("#SOP_Res_RpdRs_m").addClass("active");
		$("#SOP_Res_RpdRs_b").addClass("active");
	}
	if ($("#<portlet:namespace/>resSrgTeam").val() != ''){
		$("#SOP_Res_SrgTm").addClass("active");
		$("#SOP_Res_SrgTm_m").addClass("active");
		$("#SOP_Res_SrgTm_b").addClass("active");
	}
	
	listSize = $("input[name='<portlet:namespace/>sopArticlesListSize']").last().val();
	
	if(sopScrollCount==0){
		$(this).scrollTop(0);
	}
	
	if ((listSize >= 0 && listSize < 15) && sopScrollCount!=0){

	} else {
		$('#sopFooter').hide();
		$('#<portlet:namespace />loadingImage').show();
		/* 	if(sopScrollCount==0){
			sopItemsArray = new Array();
		} */
		//var jsonSopItemsArray = JSON.stringify(sopItemsArray);
		<portlet:namespace />storeFilters(sopScrollCount);
	}
}

function <portlet:namespace />storeFilters(sopScrollCount) {
	$('#footer-loading-indicator').show();
	$.ajax({
		url :"<%=viewSOPLandingControllerScrollURL%>",
		datatype:'json',
		data : {
			'sopScrollCountVal' : sopScrollCount,
			'time24Hours' : $("#<portlet:namespace/>time24Hours").val(),
			'time72Hours' : $("#<portlet:namespace/>time72Hours").val(),
			'time14Days' : $("#<portlet:namespace/>time14Days").val(),
			'time15Days' : $("#<portlet:namespace/>time15Days").val(),
			'catOB' : $("#<portlet:namespace/>catOB").val(),
			'catCoAd' : $("#<portlet:namespace/>catCoAd").val(),
			'catTechHR' : $("#<portlet:namespace/>catTechHR").val(),
			'catInfoMg' : $("#<portlet:namespace/>catInfoMg").val(),
			'catExtCom' : $("#<portlet:namespace/>catExtCom").val(),
			'catFnLg' : $("#<portlet:namespace/>catFnLg").val(),
			'catContext' : $("#<portlet:namespace/>catContext").val(),
			'resCountry' : $("#<portlet:namespace/>resCountry").val(),
			'resUnicef' : $("#<portlet:namespace/>resUnicef").val(),
			'resWho' : $("#<portlet:namespace/>resWho").val(),
			'resRpdRes' : $("#<portlet:namespace/>resRpdRes").val(),
			'resSrgTeam' : $("#<portlet:namespace/>resSrgTeam").val()
		},
		success : function(result) {
			var oldHtml = $('#<portlet:namespace/>sopdContent').html();
			if(sopScrollCount == 0){
				$('.un-navmenu-link').removeAttr("style");
				$('.un-navmenu-linkbox').removeClass('np-gray');
				$('#<portlet:namespace/>sopdContent').html(result);
			}else{
				$('#<portlet:namespace/>sopdContent').html(oldHtml + result);
			}
			$('#footer-loading-indicator').hide();

			$(".un-navmenu-filt-text").text('');
			if ($("#<portlet:namespace/>time24Hours").val() != ''){
				var time24Hours = generateHtml($("#<portlet:namespace/>time24Hours").val(),'24 HOURS');
				$(".un-navmenu-filt-text").append(time24Hours);
			}
			if ($("#<portlet:namespace/>time72Hours").val() != ''){
				var time72Hours = generateHtml($("#<portlet:namespace/>time72Hours").val(),'72 HOURS');
				$(".un-navmenu-filt-text").append(time72Hours);
			}
			if ($("#<portlet:namespace/>time14Days").val() != ''){
				var time14Days = generateHtml($("#<portlet:namespace/>time14Days").val(),'14 DAYS');
				$(".un-navmenu-filt-text").append(time14Days);
			}
			if ($("#<portlet:namespace/>time15Days").val() != ''){
				var time15Days = generateHtml($("#<portlet:namespace/>time15Days").val(),'15 DAYS - CLOSE');
				$(".un-navmenu-filt-text").append(time15Days);
			}

			if ($("#<portlet:namespace/>catOB").val() != ''){
				var catOB = generateHtml($("#<portlet:namespace/>catOB").val(),'OUTBREAK CONFIRMATION');
				$(".un-navmenu-filt-text").append(catOB);
			}
			if ($("#<portlet:namespace/>catCoAd").val() != ''){
				var catCoAd = generateHtml($("#<portlet:namespace/>catCoAd").val(),'COORDINATION ADVOCACY');
				$(".un-navmenu-filt-text").append(catCoAd);
			}
			if ($("#<portlet:namespace/>catTechHR").val() != ''){
				var catTechHR = generateHtml($("#<portlet:namespace/>catTechHR").val(),'TECHNICAL COORDINATION');
				$(".un-navmenu-filt-text").append(catTechHR);
			}
			if ($("#<portlet:namespace/>catInfoMg").val() != ''){
				var catInfoMg = generateHtml($("#<portlet:namespace/>catInfoMg").val(),'INFORMATION MANAGEMENT');
				$(".un-navmenu-filt-text").append(catInfoMg);
			}
			if ($("#<portlet:namespace/>catExtCom").val() != ''){
				var catExtCom = generateHtml($("#<portlet:namespace/>catExtCom").val(),'COMMUNICATION');
				$(".un-navmenu-filt-text").append(catExtCom);
			}
			if ($("#<portlet:namespace/>catFnLg").val() != ''){
				var catFnLg = generateHtml($("#<portlet:namespace/>catFnLg").val(),'FINANCES LOGISTICS');
				$(".un-navmenu-filt-text").append(catFnLg);
			}
			if ($("#<portlet:namespace/>catContext").val() != ''){
				var catContext = generateHtml($("#<portlet:namespace/>catContext").val(),'CONTEXT');
				$(".un-navmenu-filt-text").append(catContext);
			}

			if ($("#<portlet:namespace/>resCountry").val() != ''){
				var resCountry = generateHtml($("#<portlet:namespace/>resCountry").val(),'COUNTRY');
				$(".un-navmenu-filt-text").append(resCountry);
			}
			if ($("#<portlet:namespace/>resUnicef").val() != ''){
				var resUnicef = generateHtml($("#<portlet:namespace/>resUnicef").val(),'UNICEF');
				$(".un-navmenu-filt-text").append(resUnicef);
			}
			if ($("#<portlet:namespace/>resWho").val() != ''){
				var resWho = generateHtml($("#<portlet:namespace/>resWho").val(),'WHO');
				$(".un-navmenu-filt-text").append(resWho);
			}
			if ($("#<portlet:namespace/>resRpdRes").val() != ''){
				var resRpdRes = generateHtml($("#<portlet:namespace/>resRpdRes").val(),'RAPID RESPONSE');
				$(".un-navmenu-filt-text").append(resRpdRes);
			}
			if ($("#<portlet:namespace/>resSrgTeam").val() != ''){
				var resSrgTeam = generateHtml($("#<portlet:namespace/>resSrgTeam").val(),'SURGE TEAM');
				$(".un-navmenu-filt-text").append(resSrgTeam);
			}

			if ($(document).height() > $(window).height()) {
				$("#sopFooter").removeAttr("style");

			}else{
				$("#sopFooter").css({
					"position":"fixed",
					"left":"0px",
					"right":"0px",
					"bottom":"0px"
				});
			}

			$('#<portlet:namespace />loadingImage').hide();
			listSize = $("input[name='<portlet:namespace/>sopArticlesListSize']").last().val();
			if((listSize >= 0 && listSize < 15)){
				$('#sopFooter').show();
			}
			ajaxInProgress = false;

			if($(window).width() > '1023'){
				//var panelHeight = $(window).height()-438;
				var scrollCountSOP = Number(sopScrollCount)+Number(1);
				//$(".un-sop-fi-link-box").css("height",panelHeight,"important");
			}

			//$(".un-sop-fi-link.doneItems.active").css("display","none","important");
			$(".myclass").hide();
		},
		async: true // this needs to be true for the ajax loader to work
	});

	// The server is currently only using the parameters to return the right tiles in the response, but not to store the filter settings.
	// That's why we are storing the settings in cookies here:
	<portlet:namespace/>saveFiltersToCookies();
}

function <portlet:namespace/>selectAllFilters() {
	$("#<portlet:namespace/>time24Hours").val("24_HOURS");
	$("#<portlet:namespace/>time72Hours").val("72_HOURS");
	$("#<portlet:namespace/>time14Days").val("14_DAYS");
	$("#<portlet:namespace/>time15Days").val("15_DAYS-CLOSE");
	$("#<portlet:namespace/>catOB").val("Outbreak_Confirmation");
	$("#<portlet:namespace/>catCoAd").val("Coordination_And_Advocacy");
	$("#<portlet:namespace/>catTechHR").val("Technical_and_Human_Resources");
	$("#<portlet:namespace/>catInfoMg").val("Information_Management");
	$("#<portlet:namespace/>catExtCom").val("Communication");
	$("#<portlet:namespace/>catFnLg").val("Finances_and_Logistics");
	$("#<portlet:namespace/>catContext").val("Context");
	$("#<portlet:namespace/>resCountry").val("country");
	$("#<portlet:namespace/>resUnicef").val("unicef");
	$("#<portlet:namespace/>resWho").val("who");
	$("#<portlet:namespace/>resRpdRes").val("rapid_response");
	$("#<portlet:namespace/>resSrgTeam").val("surge_team");

	<portlet:namespace />storeFilters(0);

	$("#SOP_Time_24").addClass("active");
	$("#SOP_Time_24_m").addClass("active");
	$("#SOP_Time_24_b").addClass("active");
	$("#SOP_Time_72").addClass("active");
	$("#SOP_Time_72_m").addClass("active");
	$("#SOP_Time_72_b").addClass("active");
	$("#SOP_Time_14").addClass("active");
	$("#SOP_Time_14_m").addClass("active");
	$("#SOP_Time_14_b").addClass("active");
	$("#SOP_Time_15").addClass("active");
	$("#SOP_Time_15_m").addClass("active");
	$("#SOP_Time_15_b").addClass("active");
	$("#SOP_Cat_OutConf").addClass("active");
	$("#SOP_Cat_OutConf_m").addClass("active");
	$("#SOP_Cat_OutConf_b").addClass("active");
	$("#SOP_Cat_AdvCord").addClass("active");
	$("#SOP_Cat_AdvCord_m").addClass("active");
	$("#SOP_Cat_AdvCord_b").addClass("active");
	$("#SOP_Cat_TechHR").addClass("active");
	$("#SOP_Cat_TechHR_m").addClass("active");
	$("#SOP_Cat_TechHR_b").addClass("active");
	$("#SOP_Cat_InfoMgmt").addClass("active");
	$("#SOP_Cat_InfoMgmt_m").addClass("active");
	$("#SOP_Cat_InfoMgmt_b").addClass("active");
	$("#SOP_Cat_ExtComm").addClass("active");
	$("#SOP_Cat_ExtComm_m").addClass("active");
	$("#SOP_Cat_ExtComm_b").addClass("active");
	$("#SOP_Cat_FinLog").addClass("active");
	$("#SOP_Cat_FinLog_m").addClass("active");
	$("#SOP_Cat_FinLog_b").addClass("active");
	$("#SOP_Cat_Context").addClass("active");
	$("#SOP_Cat_Context_m").addClass("active");
	$("#SOP_Cat_Context_b").addClass("active");
	$("#SOP_Res_Country").addClass("active");
	$("#SOP_Res_Country_m").addClass("active");
	$("#SOP_Res_Country_b").addClass("active");
	$("#SOP_Res_Unicef").addClass("active");
	$("#SOP_Res_Unicef_m").addClass("active");
	$("#SOP_Res_Unicef_b").addClass("active");
	$("#SOP_Res_Who").addClass("active");
	$("#SOP_Res_Who_m").addClass("active");
	$("#SOP_Res_Who_b").addClass("active");
	$("#SOP_Res_RpdRs").addClass("active");
	$("#SOP_Res_RpdRs_m").addClass("active");
	$("#SOP_Res_RpdRs_b").addClass("active");
	$("#SOP_Res_SrgTm").addClass("active");
	$("#SOP_Res_SrgTm_m").addClass("active");
	$("#SOP_Res_SrgTm_b").addClass("active");
}

addAllTilesToChecklist = function() {
	
	$.ajax({
	    url :"<%=addAllTilesToCheckListURL%>",
	    success : function(result) {
	    	
	    	var jsonData = JSON.parse(result);
	    	
		    	for (var i = 0; i < jsonData.length; i++) {
		    		
				    var articleId = jsonData[i].articleId;	
		    		console.log(articleId);
				    
				    $("#<portlet:namespace/>addMyCheckList_"+articleId).removeClass("n-check-off");
					$("#<portlet:namespace/>addMyCheckList_"+articleId).addClass("n-check-on");
					$("#<portlet:namespace/>checkListText_"+articleId).text("ADDED TO MY CHECKLIST");
					$("#<portlet:namespace/>checkListText_"+articleId).css({ 'color': "red" });
					$("#<portlet:namespace/>checkListTextDetail_"+articleId).text("ADDED TO MY CHECKLIST");
					$("#<portlet:namespace/>checkListTextDetail_"+articleId).css({ 'color': "red" });	
					$("#<portlet:namespace/>sopTile_"+articleId).addClass("sop-fs");
					
		    	}
		    	
		    	// mark all filter
		    	$(".un-sop-fi-link").addClass( "active" );
		    	
		    	// display sop checklist
		    	showCheckListDiv();
	   	  }
	 });
}

<portlet:namespace/>addToCheckList = function(articleId,indexNumber,scrollCount){
	$.ajax({
	    url :"<%=addToCheckListURL%>",
	    data : {
	    'articleId' : articleId
	    },
	    success : function(result) {
			
			if ($("#<portlet:namespace/>addMyCheckList_"+articleId).hasClass("n-check-off")) {
				$("#<portlet:namespace/>addMyCheckList_"+articleId).removeClass("n-check-off");
				$("#<portlet:namespace/>addMyCheckList_"+articleId).addClass("n-check-on");
				$("#<portlet:namespace/>checkListText_"+articleId).text("ADDED TO MY CHECKLIST");
				$("#<portlet:namespace/>checkListText_"+articleId).css({ 'color': "red" });
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).text("ADDED TO MY CHECKLIST");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).css({ 'color': "red" });	
				$("#<portlet:namespace/>addFilterAllCheckList_"+scrollCount+"_"+articleId).addClass("active");
				$("#<portlet:namespace/>addFilterAllCheckList_"+scrollCount+"_"+articleId).addClass("doneItems");
				$("#<portlet:namespace/>sopTile_"+articleId).addClass("sop-fs");
				
				var itemlist = $('#<portlet:namespace/>allCheckListItems_'+scrollCount);
				
				console.log('remove off and add on');
			} else {

				// disabled add to checklist..	
				$("#<portlet:namespace/>addMyCheckList_"+articleId).removeClass("n-check-on");
				$("#<portlet:namespace/>addMyCheckList_"+articleId).addClass("n-check-off");
				$("#<portlet:namespace/>checkListText_"+articleId).text("ADD TO MY CHECKLIST");
				$("#<portlet:namespace/>checkListText_"+articleId).css({ 'color': "white" });
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).text("ADD TO MY CHECKLIST");
				$("#<portlet:namespace/>checkListTextDetail_"+articleId).css({ 'color': "black" });
				$("#<portlet:namespace/>addFilterAllCheckList_"+scrollCount+"_"+articleId).removeClass("active");
				$("#<portlet:namespace/>sopTile_"+articleId).removeClass("sop-fs");
				
				// remove element from checklist
				addRemoveFromCheckList(articleId, '');
				
				console.log('remove on and add off');
			}
			
			// display sop checklist
			showCheckListDiv();
			
			//disable expand
			disableExpand(articleId);
			
	   	  }
	 });
}

function disableExpand(articleId){
	if($("#"+articleId).hasClass("in")) {
		$("#"+articleId).removeClass("in");

		$("#rotate_curve_collapsible_"+articleId).removeClass("un-menu-active");
	}
}

function <portlet:namespace/>loadFiltersFromCookies() {
	$("#<portlet:namespace/>time24Hours").val(readCookie('time24Hours'));
	$("#<portlet:namespace/>time72Hours").val(readCookie('time72Hours'));
	$("#<portlet:namespace/>time14Days").val(readCookie('time14Days'));
	$("#<portlet:namespace/>time15Days").val(readCookie('time15Days'));
	$("#<portlet:namespace/>catOB").val(readCookie('catOB'));
	$("#<portlet:namespace/>catCoAd").val(readCookie('catCoAd'));
	$("#<portlet:namespace/>catTechHR").val(readCookie('catTechHR'));
	$("#<portlet:namespace/>catInfoMg").val(readCookie('catInfoMg'));
	$("#<portlet:namespace/>catExtCom").val(readCookie('catExtCom'));
	$("#<portlet:namespace/>catFnLg").val(readCookie('catFnLg'));
	$("#<portlet:namespace/>catContext").val(readCookie('catContext'));
	$("#<portlet:namespace/>resCountry").val(readCookie('resCountry'));
	$("#<portlet:namespace/>resUnicef").val(readCookie('resUnicef'));
	$("#<portlet:namespace/>resWho").val(readCookie('resWho'));
	$("#<portlet:namespace/>resRpdRes").val(readCookie('resRpdRes'));
	$("#<portlet:namespace/>resSrgTeam").val(readCookie('resSrgTeam'));
}

function <portlet:namespace/>saveFiltersToCookies() {
	storeCookie('time24Hours', $("#<portlet:namespace/>time24Hours").val(), 90);
	storeCookie('time72Hours', $("#<portlet:namespace/>time72Hours").val(), 90);
	storeCookie('time14Days', $("#<portlet:namespace/>time14Days").val(), 90);
	storeCookie('time15Days', $("#<portlet:namespace/>time15Days").val(), 90);
	storeCookie('catOB', $("#<portlet:namespace/>catOB").val(), 90);
	storeCookie('catCoAd', $("#<portlet:namespace/>catCoAd").val(), 90);
	storeCookie('catTechHR', $("#<portlet:namespace/>catTechHR").val(), 90);
	storeCookie('catInfoMg', $("#<portlet:namespace/>catInfoMg").val(), 90);
	storeCookie('catExtCom', $("#<portlet:namespace/>catExtCom").val(), 90);
	storeCookie('catFnLg', $("#<portlet:namespace/>catFnLg").val(), 90);
	storeCookie('catContext', $("#<portlet:namespace/>catContext").val(), 90);
	storeCookie('resCountry', $("#<portlet:namespace/>resCountry").val(), 90);
	storeCookie('resUnicef', $("#<portlet:namespace/>resUnicef").val(), 90);
	storeCookie('resWho', $("#<portlet:namespace/>resWho").val(), 90);
	storeCookie('resRpdRes', $("#<portlet:namespace/>resRpdRes").val(), 90);
	storeCookie('resSrgTeam', $("#<portlet:namespace/>resSrgTeam").val(), 90);
}

$('#<portlet:namespace/>allCheckListAdd').on('click', function(){
	  $("#<portlet:namespace/>filterOnOff").toggleClass("un-filter-off");
	  
	  if($("#<portlet:namespace/>filterOnOff").hasClass("un-filter-off")){
		  $("#sopFooter").css("position","fixed");
	  }else{
		  if ($(document).height() > $(window).height()) {
				$("#sopFooter").css("position","relative");
			}else{				
				$("#sopFooter").css({
					"position":"fixed",
					"left":"0px",
					"right":"0px",							
					"bottom":"0px"
				});
			}		  
	  }
});

$('#<portlet:namespace/>allCheckListAdd_m').on('click', function(){	  
	  $("#<portlet:namespace/>filterOnOff").toggleClass("un-filter-off");
});

$('#<portlet:namespace/>sopMytoolkitChecklist').on('click', function(){
	  $("#<portlet:namespace/>filterOnOff").toggleClass("un-filter-off");
});

$('#sop-mytoolkit-link01-checklist').on('click', function(){
	  $("#<portlet:namespace/>filterOnOff").toggleClass("un-filter-off");
});

//Filter By menu
//TIME
$('#un-filter-link-hmenu1').hover(function(){
	$('#sopv2-submenu1').addClass("in");
	$('#sopv2-submenu2').removeClass("in");
	$('#sopv2-submenu3').removeClass("in");

	$('#sopv2-submenu1').hover(function(){
		$('#sopv2-submenu1').addClass("in");
	}, function() {
		$('#sopv2-submenu1').removeClass("in");
	});
}, function() {
	$('#sopv2-submenu1').removeClass("in");
});

//CATEGORY
$('#un-filter-link-hmenu2').hover(function(){
	$('#sopv2-submenu2').addClass("in");
	$('#sopv2-submenu1').removeClass("in");
	$('#sopv2-submenu3').removeClass("in");

	$('#sopv2-submenu2').hover(function(){
		$('#sopv2-submenu2').addClass("in");
	}, function() {
		$('#sopv2-submenu2').removeClass("in");
	});
}, function() {
	$('#sopv2-submenu2').removeClass("in");
});

//RESPONSIBILITY
$('#un-filter-link-hmenu3').hover(function(){
	$('#sopv2-submenu3').addClass("in");
	$('#sopv2-submenu2').removeClass("in");
	$('#sopv2-submenu1').removeClass("in");

	$('#sopv2-submenu3').hover(function(){
		$('#sopv2-submenu3').addClass("in");
	}, function() {
		$('#sopv2-submenu3').removeClass("in");
	});
}, function() {
	$('#sopv2-submenu3').removeClass("in");
});

// My TOOLKIT
$('.un-icons-external-link').hover(function(){ // #sop-sm-mytoolkit-box 
	$('#sop-big-mytoolkit-box').addClass("in");
	
	$('#sop-big-mytoolkit-box').hover(function(){
		$('#sop-big-mytoolkit-box').addClass("in");
	}, function() {
		$('#sop-big-mytoolkit-box').removeClass("in");
	});
	
}, function() {
	$('#sop-big-mytoolkit-box').removeClass("in");
});

function generateHtml(result,tagValue){
	//alert("result " + result);
	var messageHtml = '';
		var x ="X";
		messageHtml += "<a href='javascript:void(0);' onclick='displaySOPArticles(0,\"Time\",\""+result+"\");'>X</a>"+tagValue+"</span>";
		return messageHtml;
}
</script>
