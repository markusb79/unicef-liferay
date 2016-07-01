<%@include file="../init.jsp"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<liferay-theme:defineObjects/>
<portlet:actionURL var="saveAnswerPolioURL">
	<portlet:param name="action" value="saveSolution"/>
</portlet:actionURL>

<div class="body-container clearfix">
	 <div class="sg-header clearfix buffer-bottom"><span><img src="<%= request.getContextPath() %>/images/solution-gen-icon.png"></span><span>Polio Answers</span></div>
	 
	 <!--  Left Part -->
	 
	 <div class="sg-leftpart clearfix">
      
      <div class="topic-index-list clearfix ">
      <div class="sg-title01">Topic Index</div>
                <div class="topic-index-list-fix02"><select name="">
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
        <a href="#" class="topic-index-list-fix01">FULL INDEX LIST</a> </div>
        
        
      <div class="topic-filter-list clearfix">
        <div class="sg-title01 buffer-bottom">Filter by:</div>
        <div class="clearfix topic-index-list-fix01">
          <div class="topic-filter-box">DATE <span class="tfb-flybox">X</span> </div>
          <div class="topic-filter-box">HOT TOPICS <span class="tfb-flybox">X</span> </div>
          <div class="topic-filter-box">N. OF ANSWERS<span class="tfb-flybox">X</span> </div>
          <div class="topic-filter-box">N. OF COMMENTS<span class="tfb-flybox">X</span> </div>
        </div>
        
        <div class="topic-index-list-fix02"><select name="">
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
	              <aui:select  id="solutionSpace" name="solutionSpace" required="true" showRequiredLabel="<%=false %>" label="<span>Solution Space:</span><span>*</span>" cssClass="form-control">
					<aui:option value="" selected="selected">
					    <liferay-ui:message key="select"/>
					</aui:option>
					<c:forEach items="${solutionTypeList}" var="solutionType">
						<aui:option value="${solutionType.categoryId}">${solutionType.name}</aui:option>
					</c:forEach>
				</aui:select>
	            </div>
	            <div class="sg-tq-setting-box-subbox clearfix">
	              <aui:select name="stage" label="<span>Stage:</span>" required="true" showRequiredLabel="false"  cssClass="form-control">
					<aui:option value="" selected="selected">
						<liferay-ui:message key="select"/>
					</aui:option>
					<c:forEach items="${stageList}" var="stageList">
						<aui:option value="${stageList.categoryId}" selected="${solution.solutionStage == stageList.categoryId}" >${stageList.name}</aui:option>
					</c:forEach>
				</aui:select>
	            </div>
	            <div class="sg-tq-setting-box-subbox clearfix">
	              <aui:select name="category" showRequiredLabel="false" required="true" label="<span>Category:</span>" cssClass="form-control">
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
          <div class="sg-recent-post-link"><a href="#">SEE MORE</a></div>
        </div>
        <div class="sg-title01 clearfix">Hot Topics</div>
        <div class="hot-idea-container clearfix">
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          <div class="hot-idea-mainbox clearfix">
            <div class="hot-idea-greybox clearfix">
              <div class="hot-icea-question-text01">Question 153</div>
              <div class="hot-icea-question-text02">Why is that we’re moving to IPV from OPV</div>
              <div class="sg-tq-share-box">
                <input name="ok" class="sg-tq-share-button" type="button" value="ok">
              </div>
              <div class="hot-idea-a-c-mainbox">
                <div class="hot-idea-a-c-box1">Answers: 3</div>
                <div class="hot-idea-a-c-box2">Comments: 10</div>
              </div>
            </div>
          </div>
          
          
        </div>
      </div>
    </div>
</div>
<%@ include file="solutionForm_js.jsp"%>