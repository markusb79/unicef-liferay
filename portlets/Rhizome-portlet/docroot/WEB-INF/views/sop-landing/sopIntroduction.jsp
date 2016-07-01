<%@ page import="com.liferay.portal.model.User" %>
<%@page import="com.rhizome.domain.SOPCheckList" %>
<%@page import="com.rhizome.service.SOPCheckListService"%>
<%@include file="../init.jsp"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<div class="body-container clearfix ani-1" id="main-div">
<script>

$(function($){ // on document load
 

$('#verticalspymenu').ddscrollSpy({ // initialize 2nd demo
spytarget: document.getElementById('contentcontainer'),
scrollduration: 300 // <-- no comma after last option!
})
}) 

</script>


<div class="body-container clearfix">
  <div class="sopd-detail-banner clearfix">
      <div class="sopd-detail-banner-box clearfix">
        <div class="sopd-detail-banner-img"> <img src="<%= request.getContextPath() %>/images/SOP_General_Icon-30.png""></div>
        <div class="sopd-detail-banner-text01"> <span>Outbreak Response</span> <span>Conduct a Media Landscape Analysis hello Conduct a Media Landscape Analysis</span> </div>
      </div>
    </div>
    <div class="un-sp-container clearfix">
       
      <div class="un-sp-leftpart clearfix">
      <div class="un-spi-title01">Table of Content</div>
      <ul id="verticalspymenu" class="shadowblockmenu-v">
        <li><a href="#introduction">Introduction</a></li>
        <li><a href="#outbreakRes">Outbreak response</a></li>
        <li><a href="#grading">Grading</a></li>
        <li><a href="#strategies">Strategies</a></li>
        <li><a href="#criticalFun">Critical functions</a></li>
        <li><a href="#essenPolicies">Essential policies</a></li>
        <li><a href="#performanceStand">Performance standards</a></li>
        <li><a href="#within24">Within 24 hours</a></li>
        <li><a href="#within72">Within 72 hours</a></li>
        <li><a href="#within14">Within 14 days</a></li>
        <li><a href="#untilClose">Until Closure</a></li>
      </ul>
      
      <div>
      	<a href="${fileURL}" target="_blank">
	         <span><img src="<%= request.getContextPath() %>/images/sopGen.png"></span> 
        </a>
      </div>
      
      </div>
      
      <div class="un-sp-rightpart clearfix">
      <div style="width:100%; overflow:hidden">
      <div id="contentcontainer" class="sopi-txt01" style="margin-right:-20px; padding-right:20px; height:430px; overflow-y:scroll;   position:relative; ">
      
      <%-- ********************** INTRODUCTION ************************* --%>
      
      <div id="introduction" style="margin-bottom:30px; ">
	
    	<div class="sopi-title01">Introduction B</div>
      	<p>The Global Polio Eradication Initiative (GPEI) seeks to ensure that future generations of children, no matter where they live or grow, will be free from the threat of polio paralysis. The achievement of this goal depends on interrupting poliovirus transmission in three countries where endemic wild poliovirus (WPV) continues to circulate and paralyse children – Afghanistan, Nigeria and Pakistan. Equally important to success is to ensure a rapid and effective response to polioviruses reintroduced into polio-free countries from the remaining endemic countries or another polio outbreak country.</p>
      	<p>
      		As the world moves ever closer to eradication, Member States of the World Health Organization have established new obligations for countries reporting polio outbreaks. The mechanisms of the International Health Regulations (IHR) are now being used to reduce the risk of the international spread of poliovirus and to ensure a robust response to new polio outbreaks in polio-free countries. In addition, in 2012, the World Health Assembly endorsed new obligations for responding to humanitarian emergencies, outlined in the Emergency Response Framework (ERF). These Standard Operating Procedures (SOPs) for a new polio outbreak in a polio-free country provide precise details for responding to a polio outbreak that are consistent with the IHR, the provisions of the ERF, previous resolutions of the World Health Assembly on polio outbreak response, and past experience of the GPEI in successfully interrupting polio outbreaks.
      	</p>
      	<p>
      		This document provides revised Standard Operating Procedures (SOPs) for the GPEI and national governments experiencing a polio outbreak to mount a rapid and effective response to interrupt poliovirus transmission (within four months) and prevent any further spread. The SOPs are written to ensure a common understanding of the critical actions needed to support one or more Member States in responding to a new polio outbreak. The SOPs document the roles and responsibilities of GPEI partners who are mandated to support government-led action. These roles and responsibilities are clearly assigned at each level of each organization and have clear timelines and quality expectations. They provide a standard against which outbreak response can be assessed. Most importantly, implementing the activities outlined in this SOP will ensure that the full strength of GPEI partners and proven strategies are available to support polio-free countries experiencing a polio outbreak to rapidly control it and re-establish polio-free status. These SOPs also incorporate lessons learnt from the recent outbreaks.
      	</p>
      	
      	<div  class="sopi-title01">These SOPs introduce the following new concepts for polio outbreak response:</div> 
      	
      	 <ul>
      		<li> "grading" a polio outbreak to rightsize the response and required resources;</li>
			<li> expanding the SOP to include responses to circulating vaccine-derived polioviruses (cVDPVs) in order for the procedures to be relevant through the duration of the global Polio Eradication & Endgame Strategic Plan 2013-2018;</li>
			<li> identifying the essential policies and strategies required for successful outbreak response;</li>
			<li> specifying six critical functions that the GPEI will fulfil in polio outbreak response;</li>
			<li> identifying the staffing of key roles for immediate and longer-term outbreak response and expansion to include the multiple disciplines required for outbreak response;</li>
			<li> establishing a GPEI interagency list of "on-call" staff who can be rapidly deployed to the outbreak zone within 72 hours for a duration of up to one month (also known as "Rapid Response Team A");</li>
			<li> actively managing the currently existing roster for the longer-term surge response (also called "Surge Team B");</li>
			<li> establishing performance standards for GPEI responses to a polio outbreak.</li>
      	</ul>
      	
      	<p>
      		The GPEI updated the outbreak response SOPs and, at their 24 June meeting, the heads of agencies of the core GPEI partners (the Polio Oversight Board) endorsed the proposed modifications to the outbreak response procedures to ensure agency mechanisms and resources are in place to enable an effective response.
      	</p>
      </div>
      
      <%-- ********************** OUTBREAK RESPONSE ************************* --%>
      <div id="outbreakRes" style="margin-bottom:30px;">
      <div class="sopi-title01">Outbreak Response</div>
      
      <p>
      	Since its launch at the World Health Assembly in 1988, the GPEI has provided guidance to countries on the optimal strategies and tools to rapidly interrupt polio transmission.
      </p>
      <p>
      	As the number of polio endemic countries and overall number of polio cases detected continue to fall, additional resolutions have been adopted, increasing the speed and quality expectations of polio outbreak response activities.
      </p>
      <p>
      	In May 2006, the Fifty-ninth World Health Assembly adopted a resolution outlining international outbreak response guidelines. The resolution urged all poliomyelitis-free Member States to respond rapidly to the detection of circulating polioviruses by conducting an initial investigation, activating local responses and initiating an international expert risk assessment within 72 hours of confirmation of the index case in order to establish an emergency action plan. Furthermore, countries were urged to implement large-scale rounds of house-to-house immunization campaigns, the first round to be conducted rapidly (within four weeks of confirmation of the index case).
      </p>
      <p>
      	The Polio Eradication & Endgame Strategic Plan 2013-2018 aims to stop any new polio outbreak within 120 days of confirmation of the index case.
      </p>
      <p>
      	In 2012, the World Health Assembly adopted a landmark resolution declaring that the completion of polio eradication is a programmatic emergency for global public health. The resolution urges all polio-infected countries to declare polio as a national public health emergency requiring the implementation of emergency action plans monitored at the highest levels; calls on all countries to fully apply vaccination recommendations for all travellers to/from polio-infected countries; and encourages all Member States to rapidly make available the finances required to achieve a polio-free world.
      </p>
      <p>
      	In May 2014, the WHO Director-General declared the international spread of WPV to be a public health emergency of international concern (PHEIC). The endorsed recommendations from the Emergency Committee convened under the IHR include vaccination recommendations for travel from infected countries and countries exporting WPV. The recommendations also call for an outbreak response assessment within one month of the detection of the index case in any state that becomes newly infected. This signals an increased urgency for providing robust support to polio-free countries experiencing WPV introduction.
      </p>
      </div>
      
      <%-- ********************** GRADING ************************* --%>
      <div id="grading" style="margin-bottom:30px;">
      <div  class="sopi-title01"> Grading</div>
      <p>
      	When a report of a polio outbreak is received, the GPEI will evaluate and assign a grade to the outbreak to:
      </p>
      
      <ul>
      	<li>inform GPEI partners of the extent, complexity and duration of support required;</li>
		<li> prompt all GPEI partners at all levels to be ready to repurpose resources in order to provide support;</li>
		<li> ensure that the Organizations act with appropriate urgency and mobilize the appropriate resources in support of the response;</li>
		<li> trigger outbreak response activities and policies.</li>
      </ul>
      
      <p>
      	Grading of the outbreak is the responsibility of the Eradication and Outbreak Management Group (EOMG) within 72 hours of notification of the outbreak based on:
      </p>
      
      <ul>
      	<li>a completed risk assessment and case investigation;</li>
		<li> population immunity in the affected area (from the AFP database and routine immunization coverage);</li>
		<li> the existence of vulnerable populations (refugees, internally displaced persons, significant nomadic groups, access-compromised population groups);</li>
      	<li> the security situation, including the presence of armed conflict or significant areas of insecurity or inaccessibility;</li>
		<li> the multi-country risk, including travel links;</li>
		<li> the country’s capacity to respond rapidly and effectively.</li>
      </ul>
  
	  <p>
	  	The grade will be updated at least once every three months or whenever a significant change
	  </p>
	  
	  <div class="sopi-title01">Grade definition</div>
	  
	  <p>
	  	The polio outbreak grades and definitions are:<br/>
		<b>1. Grade 1:</b> Minimal risk of continuation and international spread of transmission due to good population immunity, no major vulnerable population cluster, no security threat or access challenge, and robust health infrastructure for response (example: WPV case in Zambia).<br/>
		<b>2. Grade 2:</b> Moderate risk of continuation and international spread of transmission due to gaps in population immunity, weaknesses in the immunization system and in-country response infrastructure, major vulnerable<br/>
		 population clusters, and/or a low security threat or access challenge (example: WPV case in Tajikistan).
		<b>3. Grade 3:</b> Significant risk of continuation and international spread of transmission due to significant gaps in population immunity, major vulnerable population clusters, a history of multi-country involvement, serious deficiencies in local in-country response capacities, high security threats and access challenges, and/or a complex humanitarian emergency (example: WPV case in Somalia or Syria).
	  </p>
      </div>
 		<%-- ********************** STRATEGIES ************************* --%>
      <div id="strategies" style="margin-bottom:30px;">
      	<div class="sopi-title01">Strategies</div>
      	<p>
      		The GPEI has supported dozens of polio-free countries to successfully respond to poliovirus reintroduction and outbreaks. An analysis of these responses has identified key immunization, communication and surveillance strategies for interrupting transmission in an outbreak setting:
      	</p>
      
      	<p>
      		<b>1. Engaging governments fully in outbreak response:</b> Key to successful outbreak response is a high level of government engagement. The senior leadership of GPEI institutions (for example WHO and UNICEF regional directors, ambassadors, senior national Rotary members, etc.) should engage the top level of government in outbreak response to advocate for the:
      	</p>
      	
      	<p>a. declaration of a public health emergency by the highest members of government;</p>
		<p>b. appointment of a senior government Focal Person for the outbreak response;</p>
		<p>c. mobilization of an “all-of-government” response with both financial and human (multisectoral) resources;</p>
		<p>d. full implementation of requirements under the IHR and PHEIC.</p>
		
		<p>
			<b>2. Organizing risk assessments and identifying outbreak zones:</b> The GPEI should work with the affected countries and others to conduct a risk assessment. The risk assessment should identify the outbreak and high-risk zones with defined areas of ongoing circulation and areas of high risk. Specific strategies should be developed for each risk zone, and each zone should be managed as a single entity, including zones that include multiple countries.
		</p>
		
		<p><b>3. Conducting robust immunization response:</b> Upon confirmation of a poliovirus outbreak, countries should plan an immunization response that:</p>
		
		<ul>
			<li>is rapid (initiated no more than 14 days from confirmation of the poliovirus outbreak);</li>
			<li> is large scale (including a minimum of 2 million individuals);</li>
			<li> includes multiple supplementary immunization activities (SIAs), with a minimum of five planned at the start of the outbreak;</li>
			<li> plans the first three SIAs preferably at two- to three-week intervals maximum;</li>
			<li> targets an expanded age group beyond children aged under 5 years (at least one of the response SIAs should cover individuals aged up to at least 10 years; in many settings this has successfully included adults or even the entire population);</li>
			<li> pays special attention to populations at highest risk (high-risk populations particularly vulnerable to poliovirus circulation should be identified and targeted with focused vaccination and social mobilization approaches; these include mobile groups, refugees, internally displaced persons, minorities, etc.);</li>
			<li> is monitored and improved to reach increasing numbers of children (the immunization activity should be independently monitored and should aim to reach at least 95% of the target population).</li>
		</ul>
		
		<p><b>4. Ensuring effective communication and social mobilization:</b> To maximize the effectiveness of the outbreak response, the strategies for mobilizing communities, building demand for oral polio vaccine (OPV) and mitigating the risk of population fatigue of repeated campaigns include:</p>
		
		<ul>
			<li>mass communications informing the population of the outbreak, the risks of permanent disability and death from polio, and the need to take multiple doses of polio vaccine for individual protection and to stop the outbreak;</li>
			<li> rapid analysis of the knowledge, attitudes and practices regarding vaccination, including social profiling of polio confirmed and zero-dose non-polio AFP or contact cases, to design strategic messages through communications for development (C4D) and mass media;</li>
			<li>engagement of community and religious leaders as suitable to the local context;</li>
			<li> engagement and support of the medical and health-worker community during the outbreak and response plan, in accordance with the key messages identified;</li>
			<li> targeted community-level mobilization during the immunization campaigns;</li>
			<li> engagement with the existing humanitarian, development, UN country team and/or government communication networks to ensure the coordinated and coherent dissemination of messages;</li>
			<li> systematic reporting of specific social indicators, especially for missed children, refusals and absences, as part of the overall national outbreak reporting mechanism.</li>
		</ul>
		
		<p><b>5. Enhancing AFP and laboratory surveillance:</b> AFP surveillance should be enhanced to an annualized rate of greater than three non-polio AFP cases per 100 000 children aged under 15 years in every first subnational divisions (province or state), for the duration of the outbreak and for at least 12 months after the last case. This entails:</p>
		<ul>
			<li>immediately notifying all subnational surveillance units and informing staff that an outbreak has been detected;</li>
			<li> activating case-finding exercises at the subnational levels and conducting a retrospective record review;</li>
			<li> providing sensitization training on AFP surveillance to all health-care workers and developing an outbreak monitoring system for weekly surveillance reporting from all subnational-level reporting units;</li>
			<li> expanding the contact sampling of all AFP cases from "infected" and "immediate" risk zones until the end of the outbreak;</li>
			<li> ensuring that AFP case-finding is integrated into SIA activities;</li>
			<li> ensuring that laboratory services are strengthened to handle the additional workload, and maintaining the rapid reporting of results throughout the duration of the outbreak.</li>
		</ul>
      </div>
      
      <%-- ********************** CRITICAL FUNCTIONS ************************* --%>
      <div id="criticalFun" style="margin-bottom:30px;">
      	<div class="sopi-title01">Critical Function</div>
      	<p>To deliver on its commitment to stop transmission within 120 days of detecting a new outbreak, the GPEI must fulfil six critical functions in support of the outbreak response: outbreak confirmation, grading, response assessment and closure; coordination and advocacy; technical and human resources; information management; external communication, social mobilization and behaviour change communication; finances and logistics.</p>
      	<p><b>1| Outbreak confirmation, grading, response assessment and closure</b></p>
      	<p>The GPEI will support a full investigation that should be initiated within 72 hours of the identification of the outbreak, including clinical and epidemiological investigation of the cases or cluster.</p>
      	<p>All stool specimens from the area should receive priority treatment for processing in a WHO accredited laboratory and any isolated polioviruses should be prioritized and tracked for Intra-typic differentiation (ITD) and genetic sequencing.</p>
      	<p>After one month of confirmation of the index case, the GPEI will assess the response activities against established criteria and adapt the outbreak response plan’s subsequent phases. The assessments will subsequently be conducted at three-month intervals until six months have passed without identification of the poliovirus.</p>
      	<p>After six months without identification of the poliovirus, a final external assessment will be conducted, focusing on surveillance and activities to sustain the polio-free status in order to declare the end of the outbreak.</p>
      	
      	<p><b>2| Coordination and advocacy</b></p>
      	<p>The GPEI will provide coordination and advocacy for an effective outbreak response. Senior representatives of GPEI partners will alert the top levels of government to the outbreak and the required response. It will coordinate multiple agency resources, assist in the development of a response plan to coordinate the resources, support the development of information flows to key governments and partners on the progress of the outbreak response, and convene government and partners as needed to discuss and determine strategy.</p>
      	
      	<p><b>3| Technical and human resources</b></p>
      	<p>The GPEI will provide technical and human resource support appropriate to the needs of the outbreak response, including “surge” human resources (see “Surge policy” section below) and the provision of policy and strategy advice, the promotion of expert technical guidelines, standards and protocols, and best practices, and the implementation/strengthening of surveillance and communication.</p>
      	
      	<p><b>4| Information management</b></p>
      	<p>The GPEI will coordinate the collection, analysis and dissemination of essential information on the risk assessment, situation analysis, needs, response, gaps and performance.</p>

		<p><b>5| External communication, social mobilization and behaviour change communication</b></p>
		<p>The GPEI will develop and implement a communication and social mobilization outbreak response plan based on available social data that will identify community perceptions, attitudes, practices and social identities related to immunization practices, particularly OPV. Communications plans should identify the most critical messages and influencers for social mobilization and behaviour change communication, the development of information, education and communication (IEC) materials, the training of front-line workers to deliver these messages through effective interpersonal communication, and the engagement of community leaders and use of mass media. The plan should prioritize targeting high-risk areas/populations and systematic reporting on social indicators. It will also be important to identify media Focal Persons and develop a media strategy to disseminate key messages, talking points and media briefings.</p>

		<p><b>6| Finances and logistics</b></p>
		<p>The GPEI will identify the needs and mobilize the financial and material resources, including vaccines and logistics for outbreak response activities. It will advocate for expediting the visa process for surge staff through the country offices of UNICEF and WHO. Essential policies for optimizing GPEI’s response to a poliovirus outbreak</p>	      	
      </div>
      
      
      <%-- ********************** CRITICAL FUNCTIONS ************************* --%>
      <div id="essenPolicies" style="margin-bottom:30px;">
      	<div class="sopi-title01">Essential Policies</div>
      	<p>The GPEI is responsible for fulfilling the six critical functions across the partnership and different levels of each organization. To do this, two policies are essential.</p>
      	
      	<p><b>Surge policy</b></p>
      	<p>The GPEI mobilizes and rapidly deploys (surges) experienced professionals to join the country/outbreak areas as part of the Response Team to perform the six critical functions in outbreak response, as required. This is accomplished using a partner-wide, interregional surge mechanism consisting of qualified staff from partner organizations or qualified consultant databases.</p>
      	
      	<p>The objective of the surge policy is to improve GPEI’s capacity for effective polio outbreak response by strengthening the agencies’ ability to staff the immediate response to a polio outbreak and to ensure a smooth transition to the response’s longer-term staffing.</p>
      	<p>The surge policy is based on the following principles: </p>
      	
      	<ul>
			<li>identification of key roles to be staffed for immediate and longer-term outbreak response consistent with the outbreak grade;</li>
			<li>establishment of a rotating interagency list of “on-call” staff who can be deployed to the outbreak zone within 72 hours for a duration of up to one month (the Rapid Response Team);</li>
			<li>active management of the interagency “on-call” roster for longer-term deployment using a centralized management platform for ease of visibility/reporting (the Surge Team);</li>
			<li>rapid training of those on the roster to ensure they understand the SOPs and the critical standards to be rolled out in all phases of the outbreak;</li>
			<li>assurance that the speed of deployment processes enables the “longer-term” resources to be in place within three weeks of an outbreak, allowing at least one week of overlap between the Rapid Response Team and the Surge Team.</li>      	
      	</ul>	
      	
      	<p>Recognizing the challenges of meeting surge requirements, the GPEI will follow a two-phase surge process:</p>
      	
      	<p>Rapid Response Phase (Rapid Response Team – "Team A"): Within 72 hours of the outbreak notification, on a no-regrets basis, the GPEI surges pre-identified, trained and experienced professionals with multiple expertise. The team is drawn primarily from existing GPEI staff on a rapid response deployment roster with pre-negotiated approval for deployment of up to one month.</p>
      	<p><b>Surge Response Phase</b> (Surge Team – "Team B"): Within three weeks of the outbreak notification, the GPEI makes available, consistent with the outbreak grade, a multidisciplinary and trained surge team and additional surge staff as needed and outlined in the outbreak response plan.</p>
      	
      	<p>To meet this policy, the GPEI will maintain two types of rosters: </p>
      	<ul>
      		<li>the GPEI “on-call” roster of pre-identified, trained and experienced professionals with multiple expertise, deployable within 72 hours for a duration of up to one month;</li>
			<li>a surge roster of trained experts across multiple disciplines, deployable within three weeks of the outbreak confirmation. The roster focuses on ensuring the availability of national-level leadership personnel and subnational-level staff.</li>
      	</ul>
      	
      	<p>Key roles for both the Rapid Response Team and the Surge Team include: </p>
      	<ul>
      		<li>a polio outbreak coordinator (multi-country level)</li>
			<li>a polio outbreak technical lead (national level)</li>
			<li>a C4D lead (national level)</li>
			<li>an operations expert (administrative, finance and operational support) (national level)</li>
			<li>polio SIAs and surveillance experts (subnational level)</li>
			<li>C4D experts (subnational level).</li>
      	</ul>
      	
      	<p><b>No-regrets policy</b></p>
      	<p>At the onset of all emergencies, the GPEI ensures that predictable levels of staff and funds are made available to the country, even if it is later realized that less is required, with full support from the Eradication and Outbreak Management Group (EOMG) and without blame or regret. This policy affirms that it is better to err on the side of over-resourcing the critical functions than to risk failure by under-resourcing.</p>
      </div>
      
       <%-- ********************** PERFORMANCE STANDARDS ************************* --%>
      <div id="performanceStand" style="margin-bottom:30px;">
      	<div class="sopi-title01">Performance Standards</div>
      	<p>To ensure the effective implementation of the outbreak strategies and a timely outbreak response to interrupt transmission within 120 days, GPEI partners will perform the actions stated below. These actions will be ensured, coordinated and monitored by the GPEI’s EOMG through the 'Outbreak Preparedness and Response Task Team'.</p>
      
      </div>
      
      <%-- ********************** WITHIN 24 HOURS ************************* --%>
      
      <div id="within24" style="margin-bottom:30px;">
      	<div class="sopi-title01">Within 24 Hours</div>
      
      	<ul>
      		<li>ensure government officials are notified of the outbreak;</li>
			<li>initiate full epidemiological and social investigation of the outbreak, including a field investigation and community survey to understand the community perceptions regarding immunization, with support from external experts if needed. The investigation should also include a social assessment of the case(s) knowledge, attitude and practice (KAP) indicators and a rapid community assessment of the main social issues that can influence acceptance and efforts to create more demand for immunization services;</li>
			<li>ensure notification of the GPEI’s EOMG and relevant staff who will be involved in supporting the outbreak response;</li>
			<li>activate the GPEI’s Rapid Response Team, share the contact details with relevant staff throughout the partnership and have the Rapid Response Team leader communicate with GPEI partners, regional offices and country offices to identify focal points;</li>
			<li>conduct a rapid analysis of AFP surveillance and laboratory databases, update maps with WPV cases and SIA activities, and share the information with all relevant stakeholders;</li>
			<li>initiate an assessment of the security and access situation in the outbreak and high-risk zones;</li>
			<li>assess the on-the-ground human resource capacity of WHO, UNICEF and other partner in-country staff;</li>
			<li>establish conference calls with GPEI partners and the regional and country offices (the call should take place daily in the first week, and weekly thereafter);</li>
			<li>alert the UNICEF supply division or other vaccine suppliers to the outbreak and imminent need for the rapid delivery of vaccines and associated logistics (finger-markers, etc.);</li>
			<li>advocate for expedited procedures for visas at the port of entry for all GPEI initial outbreak responders, through WHO and UNICEF country offices.</li>
      	</ul>
      </div>
      
     <%-- ********************** WITHIN 72 HOURS ************************* --%>
      <div id="within72" style="margin-bottom:30px;">
      	<div class="sopi-title01">Within 72 Hours</div>
		
		<ul>
			<li>finalize and share the report on the initial epidemiological and social investigation of the outbreak and the assessment of the case or case cluster’s social profile with the government, GPEI partners and the EOMG;</li>
			<li>develop an initial immunization response plan with identified outbreak zones and send it to GPEI’s EOMG to guide grading and approval of funding and vaccine.</li>
			<li>write to the health minister on the part of WHO and UNICEF regional directors to highlight the "emergency" and the full</li>
			<li>support of the country representatives and organizations;</li>
			<li>complete a full, detailed situational data analysis and make it available to EOMG for outbreak grading;</li>
			<li>establish an outbreak response cell in the country with designated outbreak focal point(s) from government and partners, including strategic communication members/staff;</li>
			<li>deploy the Rapid Response Team (first human resource surge) for coordination and development of the outbreak response plan, along with other identified staff as needed (technical, operations, communications and data);</li>
			<li>initiate enhanced surveillance activities, including actively looking for AFP cases, retraining health workers and taking samples from contacts of all AFP cases;</li>
			<li>start preparations for the first outbreak response immunization activity by establishing outbreak task forces at the national and subnational levels to develop microplans with vaccines, logistics as well as a social mobilization component, and communicate with authorities, conduct training of front-line workers (vaccinators, supervisors and social mobilizers) and monitor activities;</li>
			<li>implement actions required under PHEIC by the national government with support from WHO and UNICEF;</li>
			<li>convene a meeting of all the key stakeholders at the national level on the initial outbreak response plan with feedback from subnational teams, and communicate it to the provinces and districts involved in the outbreak response;</li>
			<li>initiate the development of a six-month outbreak response plan document that includes details for subnational implementation in high-risk areas on vaccine and other required supplies, social mobilization field activities and the budget needed to cover the activities;</li>
			<li>evaluate country office administrative capacity and gaps, and find solutions;</li>
			<li>conduct a media landscape analysis;</li>
			<li>identify a media Focal Person and spokesperson from the government, WHO and UNICEF;</li>
			<li>finalize the media protocol and kit with key messages, and produce media briefs and other communications relevant to the outbreak for local use and regional/global outlets;</li>
			<li>finalize key C4D messages to communicate through various channels, including mass media;</li>
			<li>work with partners and government counterparts to conduct a press brief/media release, if appropriate;</li>
			<li>provide the country office with updated materials and guidelines on outbreak response (the Short Interval Additional Dose strategy, expanded age group, etc.);</li>
			<li>share the C4D polio toolkit and list of long-term agreements that the country office can immediately use to accelerate the response;</li>
			<li>allocate lump-sum funding to regional and country offices to cover the initial outbreak response activities;</li>
			<li>check the availability, and order and initiate the transport of vaccines per the initial estimate and outbreak response plan;</li>
			<li>identify the human resource surge capacity (technical, operations and communications staff) from the pre-identified pool for deployment to the country;</li>
			<li>compile and produce a situation report (SITREP) using a standard format, as well as a media brief and other communication and advocacy products;</li>
			<li>communicate the assessment on the risk of international spread through the IHR and other disease notification systems;</li>
			<li>develop and disseminate external communication guidance with WHO and UNICEF country offices for sharing with their respective governments and in-country networks, including details on the outbreak, the initial response plan and the actions required under PHEIC;</li>
			<li>receive and review all media releases/news feeds related to the outbreak and share them with focal points;</li>
			<li>target other non-media communication channels that could be more effective in certain settings;</li>
			<li>initiate communication on the outbreak with the broader donor community as well as a media response;</li>
			<li>align with health clusters among other partners to conduct additional interventions alongside OPV, such as providing Vitamin A and deworming tablets, whenever possible;</li>
		</ul>      
      </div>
      
      <%-- ********************** WITHIN 14 DAYS ************************* --%>
      <div id="within14" style="margin-bottom:30px;">
      	<div class="sopi-title01">Within 14 Days</div>
      	<ul>
      		<li>deploy national and international technical, operational and communications surge staff to support the national, subnational and field sites (Surge Team);</li>
			<li>finalize microplanning, and monitoring tools and training manuals, and ensure all tools have an integrated strategic communication component;</li>
			<li>review and release a budget consistent with the six-month outbreak response and communications plan;</li>
			<li>finalize C4D community engagement and information dissemination strategies;</li>
			<li>implement the first of three large-scale, short-interval (2-3 weeks apart) immunization response campaigns, considering an expanded age range;</li>
			<li>establish campaign monitoring for the SIAs, ensuring that the results are available within 72 hours of the campaign’s completion;</li>
			<li>facilitate and lead the reinvigoration of a social mobilization and/or communications plan in areas where polio has not been present for a long time so communities and health workers are sensitized to the dangers of the disease and the benefits of the vaccine;</li>
			<li>finalize the six-month outbreak response plan document and make it available to all partners;</li>
			<li>develop a media response plan and conduct briefings with political, religious and community leaders and other stakeholders;</li>
			<li>work with the media to ensure objective, fact-based reporting of the situation and positive messaging, and continue monitoring the coverage;</li>
			<li>establish a weekly meeting with key stakeholders in the country (the outbreak response cell) to coordinate and implement the outbreak response plan;</li>
			<li>establish a system to produce weekly SITREPs, a media brief and other communication and advocacy products;</li>
			<li>assess cold-chain capacity and take steps to fill any gaps in its capacity (order new equipment);</li>
			<li>liaise with in-country data managers to identify and resolve data format and completeness issues, if any;</li>
			<li>order vaccine and finger-markers for additional campaigns according to the outbreak response plan;</li>
			<li>support national and local partners to conduct mass and/or community strategic communication campaign(s);</li>
			<li>inform governments in outbreak zone countries, if any, about the outbreak, the initial response plan and the actions required;</li>
			<li>brief and deploy national and international surge staff (WHO, UNICEF, US Centers for Disease Control and Prevention (CDC) and government) in the appropriate field areas (in infected areas);</li>
			<li>ensure the availability of IEC materials for use at the community level, based on the key messages identified;</li>
			<li>begin communication/interpersonal communication (IPC) training for different categories of health and social mobilizers;</li>
			<li>develop a funding appeal and plan advocacy activities;</li>
      	</ul>
      </div>
      
       <%-- ********************** UNTIL CLOSURE ************************* --%>
      <div id="untilClose" style="margin-bottom:30px;">
      	<div class="sopi-title01">Until Closure</div>
      	<ul>
      		<li>fully implement the comprehensive six-month outbreak response plan;</li>
      		<li>maintain enhanced surveillance activities, including actively looking for AFP cases, retraining health workers and taking samples from contacts of all AFP cases;</li>
			<li>ensure surveillance, SIA and monitoring data are completed and sent to WHO regional offices/headquarters and UNICEF regional offices/headquarters according to agreed timelines (within 14 days for all SIAs, and at least weekly for AFP data);</li>
			<li>conduct weekly meetings with all key stakeholders on the outbreak response plan and coordination;</li>
			<li>continue producing a weekly SITREP using a standard format, with epidemiological and social data, as well as a media brief and other communication and advocacy products;</li>
			<li>hold weekly conference calls with GPEI partners and regional and country offices;</li>
			<li>conduct regular donor meetings and advocacy activities;</li>
      	</ul>
      
      </div>
    </div></div>
      </div>
    </div>
  </div>
</div>