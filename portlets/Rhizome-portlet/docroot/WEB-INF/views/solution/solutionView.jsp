<%@page import="com.rhizome.util.CommonUtil"%>
<%@include file="../init.jsp"%>

<%
	User currentUser = themeDisplay.getUser();
	String currentUserImg = currentUser.getPortraitId() > 0 ? CommonUtil.getUserImagePath(currentUser.getPortraitId()) : CommonUtil.getUserImagePathScreenName(currentUser.getScreenName(), currentUser.getCompanyId());
%>
<div class="body-container clearfix">
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
      <div class="ans-body-container clearfix">
        <div class="ans-detail-banner clearfix">
          <div class="ans-userimg-box">
            <div class="ans-userimg-box02"><img src="${userAvtar}"></div>
          </div>
          <div class="ans-user-titlebox"><span>Question No.${solution.solutionId}</span><span>${solution.solutionTitle}</span></div>
        </div>
        <div class="ans-body-container02">
          <div class="ans-block01 clearfix">
            <div class="ans-block-box01"><span>date</span><span>${createdDate}</span></div>
            <div class="ans-block-box02"><span>published by </span><span>${coInventorName}</span></div>
            <div class="ans-block-box03">
              <div class="sopd-checking-bar-box2 sopd-add"><a href="#" style="font-weight:bold;">ADD TO MYTOOLKIT</a></div>
            </div>
          </div>
          <div class="ans-block02 clearfix">
            <div class="ans-block-box01"><span>solution space:</span>
            		<span>
            			<c:forEach items="${solutionTypeList}" var="solutionType">
	            			<c:if test="${solution.spaceId == solutionType.categoryId}">
								${solutionType.name}
							</c:if>
						</c:forEach>
					</span>
			</div>
            <div class="ans-block-box02"><span>Stage:</span>
            	<span>
            		<c:forEach items="${stageList}" var="stageList">
            			<c:if test="${solution.solutionStage == stageList.categoryId}">
							${stageList.name}
						</c:if>
					</c:forEach>
            	</span>
            </div>
            <div class="ans-block-box03"><span>category:</span>
            	<span>
					<c:forEach items="${solutionCategoryList}" var="categoryList">
						<c:if test="${solution.solutionCategory == categoryList.categoryId}">
							${categoryList.name}
						</c:if>
					</c:forEach>  
            	</span>
            </div>
          </div>
          <div class="ans-block03 clearfix">${solution.description}</div>
          <%--  temporary hidden 
	          	<div class="ans-block04 clearfix">
	            	<div class="ans-b4-sb1">
	              		<div class="sopd-mail-icon"><a href="#">mail</a></div>
	            	</div>
		            <div class="ans-b4-sb2">
		              <div class="ans-button"><a href="javascript:void(0);" onclick="<portlet:namespace />openFirstlvlCommentDiv();">ANSWER</a></div>
		            </div>
		            <div class="ans-b4-sb3">
		              <div class="sopd-print-icon" style="float:right"> <a href="#">print</a></div>
		            </div>
	          	</div> 
          --%>
        </div>
      </div>
      <div class="ans-body-container03 clearfix">
        <div class="ans-block05 clearfix"  id="<portlet:namespace />firstLvlComment" style="display: none;">
          <div class="ans-userimg-box03 clearfix">
            <div class="ans-userimg-box02"><img src="<%= currentUserImg %>"></div>
          </div>
          <div class="ans-user-commentbox" id="<portlet:namespace />firstLvlCommentTextArea">
            	<textarea name='<portlet:namespace/>firstLvlCommentTxt' id='<portlet:namespace/>firstLvlCommentTxt' placeholder="Type here" class="auto-textheight"></textarea>
	            <div class="ans-user-submit-box">
	              <input type="button" name="ok" class="ans-user-submit-button" value="ok" onclick="<portlet:namespace />postFirstLvlComment('${solution.solutionId}');">
	            </div>
          </div>
        </div>
        
       	<div id="<portlet:namespace />solutionComments"></div>

      </div>
      
</div>
<div class="un-footer clearfix" id="footerSolutionView"> 
  		<div class="fr"> 
		    <!--a href="#">ABOUT</a>
		    <a href="#">SITEMAP</a>
		    <a href="#">REPORT A BUG</a-->
		    <a href="/web/guest/contact">CONTACT US</a>
     	</div>
</div>
<%@include file="solutionView_js.jsp" %>
<style>
	.has-error textarea{
 		border:1px solid #a94442 !important;
 	}
</style>
<script src='js/autosize.min.js'></script>
<script type="text/javascript">
$( document ).ready(function() {
 	autosize(document.querySelectorAll('.auto-textheight'));
});
</script>