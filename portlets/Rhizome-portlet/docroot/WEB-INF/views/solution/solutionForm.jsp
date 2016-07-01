<%@page import="com.rhizome.util.MessageUtil"%>
<%@include file="../init.jsp"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<portlet:renderURL var="viewMostRecentURL">
	<portlet:param name="view" value="viewMostRecentURL"/>
</portlet:renderURL>

<script type="text/javascript">

$(document).ready(function() {
	$('.basic').fancySelect();
});


$('#menu-bar').on('click',function(){
	     if ($('#solutionFormView').hasClass( "un-left-menufixer" ) ) {
			 $('#solutionFormView').removeClass('un-left-menufixer');
		 } else{
			 	$('#solutionFormView').addClass('un-left-menufixer');
		}
});

</script>

<liferay-theme:defineObjects/>
<portlet:actionURL var="saveAnswerPolioURL">
	<portlet:param name="action" value="saveSolution"/>
</portlet:actionURL>

<div id="solutionFormView" class="body-container clearfix">

	<div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
    		<div class="un-nsm-link cat-1">
    			<c:choose>
    				<c:when test="<%=themeDisplay.isSignedIn() %>">
    							<a href="/group/guest/sop" data-toggle="n-collapse" data-target="#sop-sm-submenu" data-collapse-group="myDivs">+ SOP</a>
    				</c:when>
    				<c:otherwise>
    					<a href="/web/guest/sop" data-toggle="n-collapse" data-target="#sop-sm-submenu" data-collapse-group="myDivs">+ SOP</a>
    				</c:otherwise>
    			</c:choose>
    			</div>
      
      <div class="n-collapse clearfix" id="sop-sm-submenu" aria-expanded="false">
        <div class="un-filter-linkbox">
          <div class="un-filter-linkbox02 clearfix">
          </div>
        </div>
        <div class="un-navmenu-linkbox">
        </div>
      </div>
      <div class="un-nsm-link cat-2"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#c4d-submenu" data-collapse-group="myDivs">+ C4D</a></div>
      <div class="n-collapse clearfix" id="c4d-submenu" aria-expanded="false"> C4d Content </div>
      <div class="un-nsm-link cat-3"><a href="http://db.rhizome.work" data-toggle="n-collapse" data-target="#data-submenu" data-collapse-group="myDivs">+ DATA</a></div>
      <div class="un-nsm-link"><a href="/group/guest/polio-answer-community">+ MY TOOLKIT</a></div>
      
      <!--div class="un-nsm-link"><a href="#">ABOUT</a></div-->
      <div class="un-nsm-link"><a href="/web/guest/contact">CONTACT US</a></div>
      <!--div class="un-nsm-link"><a href="#">REPORT A BUG</a></div>
      <div class="un-nsm-link"><a href="#">SITEMAP</a></div-->
    </div>
    
	 <div class="sg-header clearfix buffer-bottom"><span><img src="<%= request.getContextPath() %>/images/solution-gen-icon.png"></span><span>Polio Answers</span></div>
	 
	 <!--  Left Part -->
	 
	 <div class="sg-leftpart clearfix">
      
      <div class="topic-index-list clearfix ">
      <div class="sg-title01 buffer-bottom">Topic Index</div>
                <div class="topic-index-list-fix02"><select name="" class="basic">
          <option>ARTICLES</option>
          <option>BOOKS</option>
          <option>CASE STUDIES</option>
          <option>DEMANDS</option>
        </select></div>

        <ul class="clearfix topic-index-list-fix01 ">
          <li><a href="#"><span>A</span><span>ARTICLES</span></a></li>
          <li><a href="#"><span>B</span><span>BOOKS</span></a></li>
          <li><a href="#"><span>C</span><span>CASE STUDIES</span></a></li>
          <li><a href="#"><span>D</span><span>DEMANDS</span></a></li>
          <li><a href="#"><span>E</span><span>ENDEMIC</span></a></li>
          <li><a href="#"><span>F</span><span>FUNCTIONS</span></a></li>
          <li><a href="#"><span>G</span><span>GRADING</span></a></li>
          <li><a href="#"><span>H</span><span>HOSPITAL</span></a></li>
          <li><a href="#"><span>I</span><span>INFECTION</span></a></li>
          <li><a href="#"><span>L</span><span>LEARNING</span></a></li>
          <li><a href="#"><span>M</span><span>MOBILIZATION</span></a></li>
          <li><a href="#"><span>N</span><span>NATURE</span></a></li>
        </ul>
        <a href="#" class="topic-index-list-fix01 topic-index-list-aero-fix01">FULL INDEX LIST</a> </div>
        
        
      <div class="topic-filter-list clearfix">
        <div class="sg-title01 buffer-bottom">Filter by:</div>
        <div class="clearfix topic-index-list-fix01">
          <div class="topic-filter-box">DATE <span class="tfb-flybox"><i></i></span> </div>
          <div class="topic-filter-box">HOT TOPICS <span class="tfb-flybox"><i></i></span> </div>
          <div class="topic-filter-box">N. OF ANSWERS<span class="tfb-flybox"><i></i></span> </div>
          <div class="topic-filter-box">N. OF COMMENTS<span class="tfb-flybox"><i></i></span> </div>
        </div>
        
        <div class="topic-index-list-fix02"><select name="" class="basic">
          <option>DATE</option>
          <option>HOT TOPICS</option>
          <option>N. OF ANSWERS</option>
          <option>N. OF COMMENTS</option>
        </select></div>
        
      </div>
    </div>		
    <!--  Right Part -->	 
	  <div class="sg-rightpart clearfix">
      <div class="sg-title01 buffer-bottom">Add a Question</div>
      <div class="sg-type-questionbox clearfix">
        <div class="sg-tq-leftbox clearfix">
          <div class="sg-tq-user-img"><img src="${avatarURL}"></div>
          <div class="sg-tq-user-text01">${userName}</div>
        </div>
        <aui:form action="<%=saveAnswerPolioURL %>" method="post" name="polioAnswerForm">
	        <div class="sg-tq-rightbox clearfix">
	          <aui:input name="answerContent" type="hidden" value="third blog"/>
	          <div class="sg-tq-writebox02">
	          		<aui:input name="solutionTitle" placeholder="Add Title Here"  style="height:30px" required="true" label="" showRequiredLabel="<%=false %>" value="${solution.solutionTitle}" cssClass="form-control">
						<aui:validator name="required" />
						<aui:validator name="maxLength">120</aui:validator>
					</aui:input>
	          </div>
	          <div class="sg-tq-writebox">
	          <textarea placeholder="Type Here" class="clearfix" name="<portlet:namespace />descriptionckEditor" id="<portlet:namespace />descriptionckEditor"></textarea>
	            <div class="sg-tq-submit-box">
	              <input name="ok" class="sg-tq-submit-button" type="button" value="ok" onClick='<%=renderResponse.getNamespace() +  "submitSolutionForm();"%>'>
	            </div>
	          </div>
	          
	          <div class="sg-tq-setting-box clearfix">
	            <div class="sg-tq-setting-box-subbox clearfix">
	              <aui:select  id="solutionSpace" name="solutionSpace" required="true" showRequiredLabel="<%=false %>" label="<span>Kind of Question:</span><span>*</span>" cssClass="form-control basic">
					<aui:option value="" selected="selected">
					    <liferay-ui:message key="select"/>
					</aui:option>
					<c:forEach items="${solutionTypeList}" var="solutionType">
						<aui:option value="${solutionType.categoryId}">${solutionType.name}</aui:option>
					</c:forEach>
				</aui:select>
	            </div>
	            <div class="sg-tq-setting-box-subbox clearfix">
	              <aui:select name="stage" label="<span>Stage:</span>" required="true" showRequiredLabel="false"  cssClass="form-control basic">
					<aui:option value="" selected="selected">
						<liferay-ui:message key="select"/>
					</aui:option>
					<c:forEach items="${stageList}" var="stageList">
						<c:choose>
							<c:when test="${isCoachUser}">
								<aui:option value="${stageList.categoryId}" selected="${solution.solutionStage == stageList.categoryId}" >${stageList.name}</aui:option>
							</c:when>
							<c:otherwise>
								<aui:option value="${stageList.categoryId}" selected="${stageList.name == 'Backlog'}" >${stageList.name}</aui:option>
							</c:otherwise>
						</c:choose>	
						<%-- <aui:option value="${stageList.categoryId}" selected="${solution.solutionStage == stageList.categoryId}" >${stageList.name}</aui:option> --%>
					</c:forEach>
				</aui:select>
	            </div>
	            <div class="sg-tq-setting-box-subbox clearfix">
	              <aui:select name="category" showRequiredLabel="false" required="true" label="<span>Category:</span>" cssClass="form-control basic">
					<aui:option value="" selected="selected">
						<liferay-ui:message key="select"/>
					</aui:option>
					<c:forEach items="${solutionCategoryList}" var="categoryList">
						<aui:option value="${categoryList.categoryId}" selected="${solution.solutionCategory == categoryList.categoryId}">${categoryList.name}</aui:option>
					</c:forEach>
				</aui:select>
	            </div>
	          </div>
	        </div>
		</aui:form>
      </div>
      <div class="clearfix">
        <div class="sg-title01 clearfix">Recently posted</div>
        <div class="sg-recent-post clearfix">
			<c:forEach items="${solutionList}" var="solution">
			
				<portlet:renderURL var="viewAnswerURL">
					<portlet:param name="view" value="viewSolution" />
					<portlet:param name="solutionId" value="${solution.solutionId}" />
				</portlet:renderURL>
			
				<div class="sg-recent-title01"><a href="<%=viewAnswerURL.toString() %>">${solution.solutionTitle}</a></div>
			</c:forEach>
          <div class="sg-recent-post-link"><a href="<%=viewMostRecentURL.toString() %>"><%=MessageUtil.get("see-all", "SEE ALL", locale) %></a></div>
        </div>
      </div>
    </div>
</div>
<%@ include file="solutionForm_js.jsp"%>