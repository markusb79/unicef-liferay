<%@include file="../init.jsp"%>

<portlet:renderURL var="backToSolutionURL"/>

 <div class="body-container clearfix">
     
    <div class="sg-leftpart clearfix">
      <div class="topic-index-list clearfix ">
        <div class="sg-title01">Topic Index</div>
        <div class="topic-index-list-fix02">
          <select name="">
            <option>ARTICLES</option>
            <option>BOOKS</option>
            <option>CASE STUDIES</option>
            <option>DEMANDS</option>
          </select>
        </div>
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
        <div class="topic-index-list-fix02">
          <select name="">
            <option>DATE</option>
            <option>HOT TOPICS</option>
            <option>N. OF ANSWERS</option>
            <option>N. OF COMMENTS</option>
          </select>
        </div>
      </div>
    </div>
    
    <!-- right part ------------------------------------------------------------------------------------------->
    
    <div class="sg-rightpart clearfix">
      <div class="sga-header clearfix">
        <div class="sga-header-text1">Question  ${solution.solutionId}</div>
        <div class="sga-header-text2">${solution.solutionTitle}</div>
        <div class="sg-tq-submit-box02">
          <input type="button" value="ok" class="sg-tq-submit-button02" name="ok" onclick="javascript:<portlet:namespace />solutionComment();">
        </div>
      </div>
      <div class="clearfix">
        <div class="sg-title02 clearfix">
        <div class="p-1">
	        <a href="<%=backToSolutionURL.toString() %>"> 
	        	back
	        </a>
        </div>
          <div class="p-2" id="<portlet:namespace/>commentText"></div>
        </div>
        
       
        <div id="<portlet:namespace/>commentDiv" style="display: none;">
        <div id='<portlet:namespace/>comment'>
   		   <c:if test="<%=themeDisplay.isSignedIn() %>">
		        <div class="sga-answer-area">
		        <div id="<portlet:namespace/>solutionCommentDiv">
		          <textarea id='<portlet:namespace/>solutionCommentTxt' placeholder="Place your comment here..." rows="3" class="form-control" style="width: 100%;"></textarea>
		         </div> 
		         <div class="sg-tq-submit-box">
		              <input type="button" value="ok" class="sg-tq-submit-button" name="ok"
		              onclick="javascript:<portlet:namespace />postSolutionComment(${solution.solutionId});">
		            </div>
		        </div>
	        </c:if>
	       </div>
        </div>
        
        <div class="sga-text01 clearfix" id='<portlet:namespace/>solutionCommentView'></div>
         <div id="<portlet:namespace/>noMoreImage" style="display: none;" class="no-more-img"><img src="<%= request.getContextPath() %>/images/no-more.png"></div>
      </div>
    </div>
  </div>
<%@include file="solutionView_js.jsp" %>
  
<style>
 .no-more-img{
   width: 100%;
  text-align: center;
  padding-top: 100px;
 }
</style>
  