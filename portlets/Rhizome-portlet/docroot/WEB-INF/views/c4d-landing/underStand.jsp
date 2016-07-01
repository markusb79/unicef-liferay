<%@include file="../init.jsp"%>

<input type="hidden" value="${action}" id="<portlet:namespace/>action" />

<div class="un-body-container">
  <div class="body-container clearfix ani-1" id="main-div"> 
    
    <!--  Navigation   -->
    <div id="un-navigation-small" class="n-collapse clearfix">
    
        <div id="un-navigation-small" class="clearfix">
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>understandTab_m" onclick="<portlet:namespace/>understandFunction();" style="background-color:#7E9B00;cursor: pointer;"><a href="javascript:void(0);" >UNDERSTAND</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>planTab_m" onclick="<portlet:namespace/>planFunction();" style="background-color:#3A61C9;cursor: pointer;"><a href="javascript:void(0);" >PLAN</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>actTab_m" onclick="<portlet:namespace/>actFunction();" style="background-color:#008A54;cursor: pointer;"><a href="javascript:void(0);" >ACT</a></div>
      <div class="un-c4d-nsm-link" id="<portlet:namespace/>toolsTab_m" onclick="<portlet:namespace/>toolFunction();" style="background-color:#33B1B7;cursor: pointer;"><a href="javascript:void(0);" >TOOL</a></div>
    
    </div>
    
    
    </div>
    <div class="clearfix" id="un-navigation-big">
            <div class="un-c4d-navmenu-linkbox">
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>understandTab" onclick="<portlet:namespace/>understandFunction();" style="background-color:#7E9B00;cursor: pointer;"><a href="javascript:void(0);">UNDERSTAND</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>planTab" onclick="<portlet:namespace/>planFunction();" style="background-color:#3A61C9;cursor: pointer;"><a href="javascript:void(0);">PLAN</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>actTab" onclick="<portlet:namespace/>actFunction();" style="background-color:#008A54;cursor: pointer;"><a href="javascript:void(0);">ACT</a></div>
          <div class="un-c4d-navmenu-link" id="<portlet:namespace/>toolsTab" onclick="<portlet:namespace/>toolFunction();" style="background-color:#33B1B7;cursor: pointer;"><a href="javascript:void(0);">TOOL</a></div>
        </div>
    
    </div>
    
    <!--  Container   -->
    <div class="clearfix un-filter-off">
      <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>understandDiv"> 
      
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5F7B05 !important;">
              <div class="c4d-category-text"><span>BEHAVIOURAL GOAL</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/BehavioralGoal.png"></div></div>
              <div class="c4d-article-title"><span>Situation Analysis</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5F7B05 !important;">
              <div class="c4d-category-text"><span>BEHAVIOURAL GOAL</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/BehavioralGoal.png"></div></div>
              <div class="c4d-article-title"><span>Prioritize</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5F7B05 !important;">
              <div class="c4d-category-text"><span>BEHAVIOURAL GOAL</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/BehavioralGoal.png"></div></div>
              <div class="c4d-article-title"><span>Epidemiological Risk Factors</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5F7B05 !important;">
              <div class="c4d-category-text"><span>BEHAVIOURAL GOAL</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/BehavioralGoal.png"></div></div>
              <div class="c4d-article-title"><span>Social Analysis</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5F7B05 !important;">
              <div class="c4d-category-text"><span>BEHAVIOURAL GOAL</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/BehavioralGoal.png"></div></div>
              <div class="c4d-article-title"><span>Writing an Effective Objectives</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #8DA900 !important;">
              <div class="c4d-category-text"><span>USING EVIDENCE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/UsingEvidence.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #8DA900 !important;">
              <div class="c4d-category-text"><span>USING EVIDENCE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/UsingEvidence.png"></div></div>
              <div class="c4d-article-title"><span>EPI and Campaign Data</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #8DA900 !important;">
              <div class="c4d-category-text"><span>USING EVIDENCE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/UsingEvidence.png"></div></div>
              <div class="c4d-article-title"><span>Case Profiles</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #8DA900 !important;">
              <div class="c4d-category-text"><span>USING EVIDENCE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/UsingEvidence.png"></div></div>
              <div class="c4d-article-title"><span>Social Data</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3D438 !important;">
              <div class="c4d-category-text"><span>ID HIGH RISK GROUPS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDHighRiskGroup.png"></div></div>
              <div class="c4d-article-title"><span>Identify High Risk Groups</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3D438 !important;">
              <div class="c4d-category-text"><span>ID HIGH RISK GROUPS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDHighRiskGroup.png"></div></div>
              <div class="c4d-article-title"><span>The Role of Communication</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3D438 !important;">
              <div class="c4d-category-text"><span>ID HIGH RISK GROUPS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDHighRiskGroup.png"></div></div>
              <div class="c4d-article-title"><span>Reaching High Risk Groups</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
       
      </div>
      <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>planDiv"> 
      	<div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #072F77 !important;">
              <div class="c4d-category-text"><span>SEGMENTATION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Segmentation.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #072F77 !important;">
              <div class="c4d-category-text"><span>SEGMENTATION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Segmentation.png"></div></div>
              <div class="c4d-article-title"><span>Audience Analysis</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t2">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #072F77 !important;">
              <div class="c4d-category-text"><span>SEGMENTATION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Segmentation.png"></div></div>
              <div class="c4d-article-title"><span>Audience Segmentation Tool</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t3">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #072F77 !important;">
              <div class="c4d-category-text"><span>SEGMENTATION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Segmentation.png"></div></div>
              <div class="c4d-article-title"><span>Influencer Mapping Tool</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t3">share</a></div>
            </div>
       </div>
       
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #0735AC !important;">
              <div class="c4d-category-text"><span>BARRIERS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Barriers.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t4">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #0735AC !important;">
              <div class="c4d-category-text"><span>BARRIERS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Barriers.png"></div></div>
              <div class="c4d-article-title"><span>Barrier Analysis</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #0735AC !important;">
              <div class="c4d-category-text"><span>BARRIERS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Barriers.png"></div></div>
              <div class="c4d-article-title"><span>Situational vs Attitudinal Barriers</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #2076DB !important;">
              <div class="c4d-category-text"><span>MESSAGING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Messaging.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #2076DB !important;">
              <div class="c4d-category-text"><span>MESSAGING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Messaging.png"></div></div>
              <div class="c4d-article-title"><span>Message Themes</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #5AB0F1 !important;">
              <div class="c4d-category-text"><span>CHANNEL ANALYSIS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/ChannelAnalysis.png"></div></div>
              <div class="c4d-article-title"><span>Media Selection</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3E1FF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">ID YOUR SCENARIO</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDYourScenario.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3E1FF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">ID YOUR SCENARIO</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDYourScenario.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Outbreak</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3E1FF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">ID YOUR SCENARIO</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDYourScenario.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Enduring Outbreak</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #B3E1FF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">ID YOUR SCENARIO</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IDYourScenario.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Maintenance</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t5">share</a></div>
            </div>
       </div>
      </div>
      <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>actDiv"> 
      	<div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #06583D !important;">
              <div class="c4d-category-text"><span>THE GLOBAL STRATEGY</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/GlobalStrategy.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
     <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #06583D !important;">
              <div class="c4d-category-text"><span>THE GLOBAL STRATEGY</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/GlobalStrategy.png"></div></div>
              <div class="c4d-article-title"><span>The Global Brand</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #06583D !important;">
              <div class="c4d-category-text"><span>THE GLOBAL STRATEGY</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/GlobalStrategy.png"></div></div>
              <div class="c4d-article-title"><span>Guiding Principles</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #06583D !important;">
              <div class="c4d-category-text"><span>THE GLOBAL STRATEGY</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/GlobalStrategy.png"></div></div>
              <div class="c4d-article-title"><span>The Journey to Vaccination</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Communication Planning Worksheet</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Social Mobilization</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Mass(Paid) Media</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Owned Media</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Earned Media</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Print and IEC</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Advocacy</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #008953 !important;">
              <div class="c4d-category-text"><span>INTEGRATED ACTION</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/IntegratedAction.png"></div></div>
              <div class="c4d-article-title"><span>Multi-Media and SMS</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #45BE70 !important;">
              <div class="c4d-category-text"><span>CAPICITY BUILDING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/CapacityBuilding.png"></div></div>
              <div class="c4d-article-title"><span>Multi-Media and SMS</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Introduction</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Monitor</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Evaluate</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Test</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Sample Indicators</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #C4F1C4 !important;">
              <div class="c4d-category-text"><span style="color: #000000;">MONITOR + EVALUATE</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MonitorEvaluate.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Dashboard</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      </div>
      <div class="sopd-content-rowbox clearfix" id="<portlet:namespace/>toolDiv"> 
      	<div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1C6682 !important;">
              <div class="c4d-category-text"><span>MASS MEDIA + IEC</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MassMediaIEC.png"></div></div>
              <div class="c4d-article-title"><span>Global Strategy Templates</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1C6682 !important;">
              <div class="c4d-category-text"><span>MASS MEDIA + IEC</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MassMediaIEC.png"></div></div>
              <div class="c4d-article-title"><span>Global Strategy Scripts</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1C6682 !important;">
              <div class="c4d-category-text"><span>MASS MEDIA + IEC</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/MassMediaIEC.png"></div></div>
              <div class="c4d-article-title"><span>Country Samples</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #009DA4 !important;">
              <div class="c4d-category-text"><span>TRAINING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Training.png"></div></div>
              <div class="c4d-article-title"><span>Social Mobilization Curriculum</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
      
      <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #009DA4 !important;">
              <div class="c4d-category-text"><span>TRAINING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Training.png"></div></div>
              <div class="c4d-article-title"><span>Social Mobilization Curriculum</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #009DA4 !important;">
              <div class="c4d-category-text"><span>TRAINING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Training.png"></div></div>
              <div class="c4d-article-title"><span>Vaccinator Curriculum</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
              
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #009DA4 !important;">
              <div class="c4d-category-text"><span>TRAINING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Training.png"></div></div>
              <div class="c4d-article-title"><span>Emergency C4D Outbreak Curriculum</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #009DA4 !important;">
              <div class="c4d-category-text"><span>TRAINING</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Training.png"></div></div>
              <div class="c4d-article-title"><span>Training Tools</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1DBEBE !important;">
              <div class="c4d-category-text"><span>MANAGEMENT TOOLS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/ManagementTools.png"></div></div>
              <div class="c4d-article-title"><span>Sample ToRs</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
      
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1DBEBE !important;">
              <div class="c4d-category-text"><span>MANAGEMENT TOOLS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/ManagementTools.png"></div></div>
              <div class="c4d-article-title"><span>Communication Commitee ToRs</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1DBEBE !important;">
              <div class="c4d-category-text"><span>MANAGEMENT TOOLS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/ManagementTools.png"></div></div>
              <div class="c4d-article-title"><span>Sample Job Descriptions</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
        <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #1DBEBE !important;">
              <div class="c4d-category-text"><span>MANAGEMENT TOOLS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/ManagementTools.png"></div></div>
              <div class="c4d-article-title"><span>LTAs for C4D Support</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #AEF1DF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">INNOVATIONS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Innovations.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Multi-Media communication</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #AEF1DF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">INNOVATIONS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Innovations.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Rapid Pro</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #AEF1DF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">INNOVATIONS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Innovations.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">U-Report</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #AEF1DF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">INNOVATIONS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Innovations.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Social Media and Online</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
       <div class="sopd-content-box">
            <div class="sopd-content-subbox clearfix" style="background-color: #AEF1DF !important;">
              <div class="c4d-category-text"><span style="color: #000000;">INNOVATIONS</span></div>
              <div class="c4d-img-box"><div class="c4d-img-box2"><img src="<%=request.getContextPath() %>/images/C4D/Innovations.png"></div></div>
              <div class="c4d-article-title"><span style="color: #000000;">Other Channels</span></div>
              <div class="sopd-share-but"> <a href="javascript:void(0);"   data-toggle="n-collapse" data-target="#t1">share</a></div>
            </div>
       </div>
       
      </div>
    </div>
    
  </div>
</div>

<script type="text/javascript">

jQuery(document).ready(function($) {
 	var hiddenActionValue = $("#<portlet:namespace/>action").val();	
	if(hiddenActionValue == 'understand'){
		
		 $("#<portlet:namespace/>understandDiv").show();
		 $("#<portlet:namespace/>planDiv").hide();
		 $("#<portlet:namespace/>actDiv").hide();
		 $("#<portlet:namespace/>toolDiv").hide();
	
		 $("#<portlet:namespace/>understandTab").css('background-color', '#7E9B00');
		 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
		 
		 $('#<portlet:namespace/>understandTab a').attr('style','color:#FFFFFF !important');
		 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
		 
		 $("#<portlet:namespace/>understandTab_m").css('background-color', '#7E9B00');
		 $("#<portlet:namespace/>planTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#D1D8D5');
		 
		 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#FFFFFF !important');
		 $('#<portlet:namespace/>planTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#6b7a83 !important');
		 
	}else if(hiddenActionValue == 'plan'){
		
		 $("#<portlet:namespace/>understandDiv").hide();
		 $("#<portlet:namespace/>planDiv").show();
		 $("#<portlet:namespace/>actDiv").hide();
		 $("#<portlet:namespace/>toolDiv").hide();
		 
		 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>planTab").css('background-color', '#3A61C9');
		 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
		 
		 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>planTab a').attr('style','color:#FFFFFF !important');
		 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
		 
		 $("#<portlet:namespace/>understandTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>planTab_m").css('background-color', '#3A61C9');
		 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#D1D8D5');
		 
		 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>planTab_m a').attr('style','color:#FFFFFF !important');
		 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#6b7a83 !important');
		 
	}else if(hiddenActionValue == 'act'){
		
		 $("#<portlet:namespace/>understandDiv").hide();
		 $("#<portlet:namespace/>planDiv").hide();
		 $("#<portlet:namespace/>actDiv").show();
		 $("#<portlet:namespace/>toolDiv").hide();
		 
		 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>actTab").css('background-color', '#008A54');
		 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
		 
		 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>actTab a').attr('style','color:#FFFFFF !important');
		 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
		 
		 
	}else if(hiddenActionValue == 'tools'){
		
		 $("#<portlet:namespace/>understandDiv").hide();
		 $("#<portlet:namespace/>planDiv").hide();
		 $("#<portlet:namespace/>actDiv").hide();
		 $("#<portlet:namespace/>toolDiv").show();
		 
		 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab").css('background-color', '#33B1B7');
		 
		 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab a').attr('style','color:#FFFFFF !important');
		 
		 $("#<portlet:namespace/>understandTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>planTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
		 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#33B1B7');
		 
		 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>planTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
		 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#FFFFFF !important');
	}

});

<portlet:namespace/>understandFunction = function(){
	 $("#<portlet:namespace/>understandDiv").show();
	 $("#<portlet:namespace/>planDiv").hide();
	 $("#<portlet:namespace/>actDiv").hide();
	 $("#<portlet:namespace/>toolDiv").hide();
	 
	 $("#<portlet:namespace/>understandTab").css('background-color', '#7E9B00');
	 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
	 
	 $("#<portlet:namespace/>understandTab_m").css('background-color', '#7E9B00');
	 $("#<portlet:namespace/>planTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>planTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#6b7a83 !important');
}

<portlet:namespace/>planFunction = function(){
	 $("#<portlet:namespace/>understandDiv").hide();
	 $("#<portlet:namespace/>planDiv").show();
	 $("#<portlet:namespace/>actDiv").hide();
	 $("#<portlet:namespace/>toolDiv").hide();
	 
	 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab").css('background-color', '#3A61C9');
	 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
	 
	 $("#<portlet:namespace/>understandTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab_m").css('background-color', '#3A61C9');
	 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab_m a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#6b7a83 !important');
}

<portlet:namespace/>actFunction = function(){
	 $("#<portlet:namespace/>understandDiv").hide();
	 $("#<portlet:namespace/>planDiv").hide();
	 $("#<portlet:namespace/>actDiv").show();
	 $("#<portlet:namespace/>toolDiv").hide();
	 
	 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab").css('background-color', '#008A54');
	 $("#<portlet:namespace/>toolsTab").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>toolsTab a').attr('style','color:#6b7a83 !important');
	 
	 $("#<portlet:namespace/>understandTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab_m").css('background-color', '#008A54');
	 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#D1D8D5');
	 
	 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab_m a').attr('style','color:#FFFFFF !important');
	 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#6b7a83 !important');
}

<portlet:namespace/>toolFunction = function(){
	 $("#<portlet:namespace/>understandDiv").hide();
	 $("#<portlet:namespace/>planDiv").hide();
	 $("#<portlet:namespace/>actDiv").hide();
	 $("#<portlet:namespace/>toolDiv").show();
	 
	 $("#<portlet:namespace/>understandTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab").css('background-color', '#33B1B7');
	 
	 $('#<portlet:namespace/>understandTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab a').attr('style','color:#FFFFFF !important');
	 
	 $("#<portlet:namespace/>understandTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>planTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>actTab_m").css('background-color', '#D1D8D5');
	 $("#<portlet:namespace/>toolsTab_m").css('background-color', '#33B1B7');
	 
	 $('#<portlet:namespace/>understandTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>planTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>actTab_m a').attr('style','color:#6b7a83 !important');
	 $('#<portlet:namespace/>toolsTab_m a').attr('style','color:#FFFFFF !important');
}
</script>