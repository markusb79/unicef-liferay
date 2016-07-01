<%@page import="com.rhizome.domain.SOPArticles"%>
<%@page import="com.rhizome.domain.SOPCheckList" %>
<%@page import="com.rhizome.service.SOPCheckListService"%>
<%@include file="../init.jsp"%>

<input type="hidden" name="<portlet:namespace/>sopCountValue"  value="${sopScrollCount}" />
<input type="hidden" name="<portlet:namespace/>sopFilterValue"  value="${sopFilterValue}" />
<input type="hidden" name="<portlet:namespace/>sopSubFilterValue"  value="${sopSubFilterValue}" />
<input type="hidden" name="<portlet:namespace/>sopArticlesListSize"  value="${sopArticlesListSize}" />
<input type="hidden" name="<portlet:namespace/>filterColor"  value="${colorCode}" />
<p id="demo" style="display: none;"></p>
<%
	ThemeDisplay td = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	boolean signedIn = td.isSignedIn();
	pageContext.setAttribute("signedIn", signedIn);
%>
<portlet:renderURL var="viewSOPLandingMenu">
	<portlet:param name="view" value="viewSOPLandingMenu" />
</portlet:renderURL>
<c:choose>
	<c:when test="${fn:length(sopArticlesList) gt 0}">
		<c:forEach items="${sopArticlesList}" var="article"  varStatus="articleCounter">
  <c:set var="articleId" value="${article.id}"/>
  <%
   SOPCheckListService checkListService = (SOPCheckListService)request.getAttribute("sopCheckListService");
   boolean flag = checkListService.checkSOPMyCheckListExistList((Long)pageContext.getAttribute("articleId"), themeDisplay.getUserId());
   pageContext.setAttribute("flag",flag);
  %>

<c:set var="time24Hours" value="${time24Hours}"/>
<c:set var="time72Hours" value="${time72Hours}"/>
<c:set var="time14Days" value="${time14Days}"/>
<c:set var="time15Days" value="${time15Days}"/>
<c:set var="catOB" value="${catOB}"/>
<c:set var="catCoAd" value="${catCoAd}"/>
<c:set var="catTechHR" value="${catTechHR}"/>
<c:set var="catInfoMg" value="${catInfoMg}"/>
<c:set var="catExtCom" value="${catExtCom}"/>
<c:set var="catFnLg" value="${catFnLg}"/>
<c:set var="catContext" value="${catContext}"/>
<c:set var="resCountry" value="${resCountry}"/>
<c:set var="resUnicef" value="${resUnicef}"/>
<c:set var="resWho" value="${resWho}"/>
<c:set var="resRpdRes" value="${resRpdRes}"/>
<c:set var="resSrgTeam" value="${resSrgTeam}"/>

<c:set var="filteredSopArticlesList" value="${sopArticlesList}"/>
  
  <%
  	String nonParamURL = viewSOPLandingMenu.toString();
  	String page24Hours = (String)pageContext.getAttribute("time24Hours");
  	String page72Hours = (String)pageContext.getAttribute("time72Hours");
  	String page14Days = (String)pageContext.getAttribute("time14Days");
  	String page15Days = (String)pageContext.getAttribute("time15Days");
  	String pageCatOB = (String)pageContext.getAttribute("catOB");
  	String pageCatCoAd = (String)pageContext.getAttribute("catCoAd");
  	String pageCatTechHR = (String)pageContext.getAttribute("catTechHR");
  	String pageCatInfo = (String)pageContext.getAttribute("catInfoMg");
  	String pageCatExt = (String)pageContext.getAttribute("catExtCom");
  	String pageCatFn = (String)pageContext.getAttribute("catFnLg");
  	String pageCatContext = (String)pageContext.getAttribute("catContext");
  	String pageResCountry = (String)pageContext.getAttribute("resCountry");
  	String pageResUnicef = (String)pageContext.getAttribute("resUnicef");
  	String pageResWho = (String)pageContext.getAttribute("resWho");
  	String pageResRPD = (String)pageContext.getAttribute("resRpdRes");
  	String pageResSrg = (String)pageContext.getAttribute("resSrgTeam");
  	
  	String time24Hours = "&time24="+page24Hours; 
	String time72Hours = "&time72="+page72Hours;
	String time14Days = "&time14="+page14Days;
	String time15Days = "&time15="+page15Days;
		
	String catOutBreak = "&catOB="+pageCatOB;
	String catCoAndAdv = "&catCoAd="+pageCatCoAd;
	String catTechAndHR = "&catTechHR="+pageCatTechHR;
	String catInfoMgmt = "&catInfoMg="+pageCatInfo;
	String catExtComm = "&catExtCom="+pageCatExt;
	String catFinAndLog = "&catFnLg="+pageCatFn;
	String catContext = "&catContext="+pageCatContext;
	
	String resCountry = "&resCountry="+pageResCountry;
	String resUnicef = "&resUnicef="+pageResUnicef;
	String resWho = "&resWho="+pageResWho;
	String resRapidRes = "&resRpdRes="+pageResRPD;
	String resSurgeTeam = "&resSrgTeam="+pageResSrg;
	String filterURL = nonParamURL+time24Hours+time72Hours+time14Days+time15Days
	+catOutBreak+catCoAndAdv+catTechAndHR+catInfoMgmt+catExtComm+catFinAndLog+catContext+
	resCountry+resUnicef+resWho+resRapidRes+resSurgeTeam;
//	System.out.println("Filter URL from JSP " + filterURL);
	
	if(Validator.isNotNull(page24Hours) || Validator.isNotNull(page72Hours) || Validator.isNotNull(page14Days) || Validator.isNotNull(page15Days) || Validator.isNotNull(pageCatOB)
			|| Validator.isNotNull(pageCatCoAd) || Validator.isNotNull(pageCatTechHR) || Validator.isNotNull(pageCatInfo) || Validator.isNotNull(pageCatExt)
			|| Validator.isNotNull(pageCatFn) || Validator.isNotNull(pageCatContext) || Validator.isNotNull(pageResCountry) || Validator.isNotNull(pageResUnicef)
			|| Validator.isNotNull(pageResWho) || Validator.isNotNull(pageResRPD) || Validator.isNotNull(pageResSrg)){
		//System.out.println("Filter URL from JSP " + filterURL);
		session.setAttribute("redirectURL",  filterURL);
	}
	
	List<SOPArticles> sopArticles = (List<SOPArticles>) pageContext.getAttribute("filteredSopArticlesList");
	
	session.setAttribute("sopArticlesFiltered",  sopArticles);
	
  %>
    
<div class="sopd-content-box">

 <c:choose>
  <c:when test="${!flag}">
   <div class="sopd-content-subbox" id="<portlet:namespace/>sopTile_${article.id}" style="background-color:${article.articleColor};cursor: pointer;" onclick="<portlet:namespace />viewArticleDescription('${article.id}','${sopFilterValue}','${sopSubFilterValue}','${article.aricleURLTitle}');">
  </c:when>
  <c:otherwise>
   <c:choose>
    <c:when test="${signedIn}">
     <div class="sopd-content-subbox sop-fs" id="<portlet:namespace/>sopTile_${article.id}" style="background-color:${article.articleColor};cursor: pointer;" onclick="<portlet:namespace />viewArticleDescription('${article.id}','${sopFilterValue}','${sopSubFilterValue}','${article.aricleURLTitle}');">    
    </c:when>
    <c:otherwise>
     <div class="sopd-content-subbox" id="<portlet:namespace/>sopTile_${article.id}" style="background-color:${article.articleColor};cursor: pointer;" onclick="<portlet:namespace />viewArticleDescription('${article.id}','${sopFilterValue}','${sopSubFilterValue}','${article.aricleURLTitle}');">
    </c:otherwise>
   </c:choose>
  </c:otherwise>
 </c:choose>
  
  <div class="sopd-time-text" style="color:${article.fontColor};"><span>${article.time}</span></div>
        <%-- <div class="sopd-category-text" style="color:${article.fontColor};"><span>${article.category}</span></div> --%>
        <div class="sopd-img-box"><div class="sopd-img-box2"><img src="${article.imageArticle}"></div></div>
        <div class="sopd-article-title" style="color:${article.fontColor};"><span>${article.title}</span></div>
    <!-- <div class="sopd-article-button"><span><a href="javascript:void(0);" onclick="<portlet:namespace />viewArticleDescription('${article.id}','${sopFilterValue}','${sopSubFilterValue}','${article.aricleURLTitle}');">MORE</a></span></div> -->
     
   </div>
      
             <c:choose>
        <c:when test="<%=themeDisplay.isSignedIn() %>">
         <div class="sopd-share-but"> 
         	<a href="javascript:void(0);" id="rotate_curve_collapsible_${article.id}" class="" data-toggle="n-collapse" data-target="#${article.id}">share</a></div>
        </c:when>
        <c:otherwise>
         <div class="sopd-share-but"> <a href="#loginBox" class="various3">share</a></div>
        </c:otherwise>
       </c:choose>
           <div class="un-user-bookmark-box clearfix n-collapse" id="${article.id}" aria-expanded="false">
                    <div class="un-user-checking-bar-box1 has-js">
       <c:choose>
        <c:when test="${!flag}">
         <div id="<portlet:namespace/>addMyCheckList_${article.id}" class="un-check-link n-check-off" onclick="<portlet:namespace/>addToCheckList(${article.id},this,${sopScrollCount});">
                              <a id="<portlet:namespace/>checkListText_${article.id}" href="javascript:void(0);">ADD TO MY CHECKLIST</a>
                           </div> 
        </c:when>
        <c:otherwise>
         <div id="<portlet:namespace/>addMyCheckList_${article.id}" class="un-check-link n-check-on" onclick="<portlet:namespace/>addToCheckList(${article.id},this,${sopScrollCount});">
                              <a id="<portlet:namespace/>checkListText_${article.id}" href="javascript:void(0);" style="color: red;">ADDED TO MY CHECKLIST</a>
                           </div>
        </c:otherwise>
       </c:choose>
                    </div>
                    <!-- <div class="un-user-checking-bar-box2 sopd-add"><a href="#">ADD TO MYTOOLKIT</a></div> -->
            </div>

</div>

</c:forEach>
	</c:when>
	<c:when test="${fn:length(sopArticlesList) eq 0 && sopScrollCount eq 1}"> 
		<script>
			alert('No tasks found with selected filters.');
		</script>
		<%-- 
			<div style="text-align: center; margin: 20px 0;"><img style="max-width: 100%;" src="<%= request.getContextPath() %>/images/no-result-new.jpg"></div>
			<div style="font-size: 26px; font-weight: bold; color: #AAAAAA; margin-top: 15px; margin-bottom: 70px; text-align: center; ">No tasks found with selected filters.</div> 
		--%>
	</c:when>
</c:choose>

<style>
	.main-container #hrefFm{ display:none !important; visibility:hidden !important; }
</style>

<%@include file="sopResponse_js.jsp" %>