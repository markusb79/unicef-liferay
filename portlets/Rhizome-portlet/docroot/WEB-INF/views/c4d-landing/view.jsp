<%@include file="../init.jsp"%>
<portlet:renderURL var="openUnderStandURL">
	<portlet:param name="view" value="underStand"/>
</portlet:renderURL>

<div class="body-container clearfix">


	<div class="body-container clearfix ani-1" id="main-div">

		<div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
		<div class="un-nsm-link cat-1">    	
			<a href="/web/guest/sop" data-collapse-group="myDivs">+ SOP</a>
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



		<div class="clearfix">
			<%-- <div class="un-h-c4d-box01 clearfix"
				style="background-color: #8da900; cursor:pointer;" onclick="<portlet:namespace/>openUnderStandJSP('<%=openUnderStandURL.toString()%>');"> --%>
			<!-- <div class="un-h-c4d-box01 clearfix"
				style="background-color: #8da900; cursor:pointer;" onclick="javascript:void(0);"> -->
				<div class="un-h-c4d-box01 clearfix"
				style="background-color: #8da900; cursor:pointer;" onclick="<portlet:namespace/>openUnderStandJSP('<%=openUnderStandURL.toString()%>', 'Understand');">
				<div class="un-h-c4d-box-fix01">
					<div class="un-h-small-contentbox clearfix">
						<div class="un-c4d-title01">1. understand</div>
						<div class="un-c4d-text01">At the end of this section, you will
							understand the problem and the highest risk groups and their
							perception of vaccination, you will understand how to use research to
							refine the objectives and the role communication can play.</div>
					</div>
					<div class="un-h-small-contentbox clearfix">
						<div class="un-h-c4d-link01">
							<a href="#">Behavioural Goals</a> <a href="#">Using evidence</a> <a
								href="#">id high risk groups</a>
						</div>
					</div>
				</div>

			</div>

			<div class="un-h-c4d-box02 clearfix"
				style="background-color: #093abc; cursor:pointer;" onclick="<portlet:namespace/>openUnderStandJSP('<%=openUnderStandURL.toString()%>', 'Plan');">
				<!-- <div class="un-h-c4d-box02 clearfix"
				style="background-color: #093abc; cursor:pointer;" onclick="javascript:void(0);"> -->
				<div class="un-h-c4d-box-fix01">
					<div class="un-h-small-contentbox clearfix">
						<div class="un-c4d-title01">2. plan</div>
						<div class="un-c4d-text01">At the end of this section, you will
							have defined the target audience, barriers to change, developed
							messaging and channels to reach the target. You will have used and
							understood the Comms Planning Tool.</div>
					</div>
					<div class="un-h-small-contentbox clearfix">
						<div class="un-h-c4d-link01">
							<a href="#">segmentation</a> <a href="#">barriers</a> <a href="#">messaging</a>
							<a href="#">channel analysis</a> <a href="#">ID YOUR SCENARIO</a>
						</div>
					</div>
				</div>

			</div>

			<div class="un-h-c4d-box01 clearfix"
				style=" background-color: #008a54; cursor:pointer;" onclick="<portlet:namespace/>openUnderStandJSP('<%=openUnderStandURL.toString()%>', 'Act');">
				<!-- <div class="un-h-c4d-box01 clearfix"
				style=" background-color: #008a54; cursor:pointer;" onclick="javascript:void(0);"> -->
				<div class="un-h-c4d-box-fix01">
					<div class="un-h-small-contentbox clearfix">
						<div class="un-c4d-title01">3. act</div>
						<div class="un-c4d-text01">At the end of this section, you will
							understand and will be able go to apply the global strategy, including
							integrated communication tactics, their strengths and weaknesses,
							plus how to evaluate and monitor your own strategy's success.</div>
					</div>
					<div class="un-h-small-contentbox clearfix">
						<div class="un-h-c4d-link01">
							<a href="#">the global strategy</a> <a href="#">integrated
								action</a> <a href="#">CAPACITY BUILDING</a> <a href="#">Monitor
								+ Evaluate</a>
						</div>
					</div>
				</div>

			</div>

			<div class="un-h-c4d-box02 clearfix"
				style=" background-color: #009da5; cursor:pointer;" onclick="<portlet:namespace/>openUnderStandJSP('<%=openUnderStandURL.toString()%>', 'Tools');">
				<!-- <div class="un-h-c4d-box02 clearfix"
					style=" background-color: #009da5; cursor:pointer;" onclick="javascript:void(0);"> -->	

				<div class="un-h-c4d-box-fix01">
					<div class="un-h-small-contentbox clearfix">
						<div class="un-c4d-title01">4. tools</div>
						<div class="un-c4d-text01">At the end of this section, you will
							have access to practical tools and how to use them, including in
							Innovations and innovations research. dashboard and other
							Management Tools.</div>
					</div>
					<div class="un-h-small-contentbox clearfix">
						<div class="un-h-c4d-link01">
							<a href="#">mass media + iec</a> <a href="#">training</a> <a
								href="#">management tools</a><a href="#">innovations</a>
						</div>
					</div>
				</div>

			</div>

		</div>
	</div>
<%@include file="view_js.jsp" %>

