<%@page import="java.util.ListIterator"%>
<%@page import="com.rhizome.domain.SOPArticles"%>
<%@ page import="com.liferay.portal.model.User" %>
<%@page import="com.rhizome.domain.SOPCheckList" %>
<%@page import="com.rhizome.service.SOPCheckListService"%>
<%@include file="../init.jsp"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>

<%
	ThemeDisplay td = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	boolean signedIn = td.isSignedIn();
	pageContext.setAttribute("signedIn", signedIn);
	String sessionRedirectURL = StringPool.BLANK;

	if(Validator.isNotNull(sessionRedirectURL)) {
		sessionRedirectURL = (String)session.getAttribute("redirectURL");
	} else {
		sessionRedirectURL = "/web/guest/sop";
	}
	
	List<SOPArticles> sopArticles = (List<SOPArticles>)session.getAttribute("sopArticlesFiltered");
	SOPArticles currentSOPArticles = (SOPArticles) request.getAttribute("article"); 

	/*int pointer=0, next=0, prev=0;

	if(sopArticles!=null && currentSOPArticles!=null ) {
		for(SOPArticles s : sopArticles ) {
			if(s.getTitle().equals(currentSOPArticles.getTitle())) {
				pointer = sopArticles.indexOf(s);
			}
		}
		
		next= sopArticles.size() > pointer+1 ? pointer+1 : 0;
		prev= pointer > 0 ? pointer-1 : sopArticles.size()-1 ;
		
		SOPArticles sArticleNext = sopArticles.get(next);
		SOPArticles sArticlePrev = sopArticles.get(prev);
	
		pageContext.setAttribute("sArticleNext", sArticleNext);
		pageContext.setAttribute("sArticlePrev", sArticlePrev);
	}*/
	
	pageContext.setAttribute("sopArticles", sopArticles);

%>
<portlet:renderURL var="viewSOPLandingMenu">
	<portlet:param name="view" value="viewSOPLandingMenu" />
</portlet:renderURL>
<c:choose>
	<c:when test="${signedIn}">
		<style>  
			/* .main-container {margin-top: 151px !important;} */
			@media only screen and (min-width:300px) and (max-width:767px) {
				.main-container {margin-top: 0px !important;}
			}
		 </style>
	</c:when>
	<c:otherwise>
		<style> 
			.main-container { margin-top: 99px !important;}
			@media only screen and (min-width:300px) and (max-width:767px) {
				.main-container {margin-top: 0px !important;}
			}
		</style>
		
	</c:otherwise>
</c:choose>

<portlet:renderURL var="backToMainCategoryURL">
	<portlet:param name="categoryValue" value="${detailSubCategory}"/>
	<portlet:param name="fromSubFilter" value="${fromSubFilter}"/>
	<portlet:param name="sopFilterMainCat" value="${sopFilterMainCat}"/>
</portlet:renderURL>
<portlet:defineObjects/>
<theme:defineObjects/>

<% User userU = themeDisplay.getUser();  %>
<% boolean isSignedIn = themeDisplay.isSignedIn(); %>
<div class="body-container clearfix ani-1" id="main-div">
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
      
      <!--div class="un-nsm-link"><a href="#">ABOUT</a></div>
      <div class="un-nsm-link"><a href="#">REPORT A BUG</a></div>
      <div class="un-nsm-link"><a href="#">SITEMAP</a></div-->
		<div class="un-nsm-link"><a href="/web/guest/contact">CONTACT US</a></div>
    </div>
<div class="body-container clearfix">
    <div class="sopd-detail-banner clearfix" style="background-color:${article.articleColor};">
    	
    	<c:choose>
    		<c:when test="${article.category eq 'Context'}">
    			<div class="sopd-detail-closebtn02"><a href="<%=sessionRedirectURL.toString()%>">Close<span></span></a></div>	
    		</c:when>
    		<c:otherwise>
    			<div class="sopd-detail-closebtn"><a href="<%=sessionRedirectURL.toString()%>">Close<span></span></a></div>
    		</c:otherwise>
    	</c:choose>
    		
      <div class="sopd-detail-banner-box clearfix">
        <div class="sopd-detail-npfix01">
        <div class="sopd-detail-banner-img"> <img src="${article.imageArticle}"></div>
        <div class="sopd-detail-banner-text01"> 
        <div class="clearfix sopd-detail-banner-fix002">
        	<span style="">${article.category}</span> <span style="">${article.title} </span>  
        </div>
        </div>
        </div>
        
      </div>
    </div>
    <div class="sopd-detail-container clearfix">
    
    <div class="sopd-detail-p1">
	  <div class="sopd-title01">Article Classification</div>
      <div class="sopd-title02"><span>time</span> <span>${article.time}</span></div>
      <div class="sopd-title02"><span>function</span> <span>${article.category}</span></div>
      <div class="sopd-title02"><span>responsible</span> <span>${article.responsible}</span></div>
      <div class="sopd-title02"><span>support</span> <span>${article.support}</span></div>
    </div>

    
    <div class="sopd-detail-p2">
      
      
      <div class="sopd-text01">
        ${article.articleContent}
        </div>
        
        <div class="sopd-checking-bar clearfix" style="padding-bottom: 4px;">
		<div class="sopd-checking-bar-box1 has-js np-has-js-fix clearfix">
		<c:choose>
			<c:when test="${flag eq 'true' }">
            	<div id="<portlet:namespace/>addMyCheckList_${article.id}" class="un-check-link n-check-on" onclick="<portlet:namespace/>addToCheckList(${article.id});">
                	<a id="<portlet:namespace/>checkListTextDetail_${article.id}" href="javascript:void(0);" style="color: red;">ADDED TO MY CHECKLIST</a>
                </div>
			</c:when>
			<c:otherwise>
				<c:choose>
    				<c:when test="<%=themeDisplay.isSignedIn() %>">
						<div id="<portlet:namespace/>addMyCheckList_${article.id}" class="un-check-link n-check-off" onclick="<portlet:namespace/>addToCheckList(${article.id});">
		                	<a id="<portlet:namespace/>checkListTextDetail_${article.id}" href="javascript:void(0);">ADD TO MY CHECKLIST</a>
		                </div>
    				</c:when>
    				<c:otherwise>
						<div class="un-check-link n-check-off" onclick="$.fancybox.open('#loginBox');">
		                	<a href="javascript:void(0);">ADD TO MY CHECKLIST</a>
		                </div>
    				</c:otherwise>
    			</c:choose>
                
			</c:otherwise>
		</c:choose>
        </div>
        <!-- <div class="sopd-checking-bar-box2 sopd-add">ADD TO MYTOOLKIT</div> -->
      </div>
        
        <div class="sopd-checking-bar-box3 clearfix">
        
        <div class="clearfix"> 
	       	<%-- <c:if test="${empty sopArticles}"> --%>
			<c:if test="${sopPreviousArticle != null}">
				<a href="#" onclick="<portlet:namespace />viewArticleDescription('','','','${sopPreviousArticle.aricleURLTitle}');" class="sopd-prev-link">Previous</a>
			</c:if>
			<c:if test="${sopNextArticle != null}">
				<a href="#" onclick="<portlet:namespace />viewArticleDescription('','','','${sopNextArticle.aricleURLTitle}');" class="sopd-next-link">Next</a>
			</c:if>
			<%-- </c:if> --%>
        </div>
        
        <div class="sopd-icon-box clearfix">
          <div class="sopd-mail-icon"> 
          	<a href="javascript:<portlet:namespace />emailCurrentPageSOP()">mail</a>
          </div>
          <!-- Not implemented, so temporary hidden 
          	<div class="sopd-print-icon">
          	<a href="#">mail</a>
          	</div> 
          -->
          <!-- 
          	<div class="sopd-idea-icon">
          		<a href="#">mail</a>
          	</div> 
          -->
          <!-- Not implemented, so temporary hidden 
          	<div class="sopd-like-icon" >
          		<a href="javascript:void(0);" data-toggle="n-collapse" data-target="#sopd-like-total-box" data-collapse-group="myDivs">mail</a>
          		<div class="sopd-like-box001 n-collapse" id="sopd-like-total-box">150</div>
          	</div> 
           -->
        </div>
      </div>
      
    </div><div class="sopd-detail-p3"> 

  <div class="sopd-checking-bar-box4 clearfix">
      
        <c:if test="${fn:length(templateLinkList) gt 0}">
	        <div class="sopd-checking-bar-box4-subbox clearfix">
	          	<div class="sopd-c-title01" data-toggle="n-collapse" data-target="#template-box">Templates <div class="sp-filter-link-aero02 ani-1"><img src="<%= request.getContextPath() %>/images/down-aero-7.png"></div></div>
		        <div class="n-collapse" id="template-box">
		        <c:forEach items="${templateLinkList}" var="templateLinks">
		        	<div class="sopd-title03"><a href="${templateLinks.templateUrl}" target="_blank">${templateLinks.templateName}</a></div>
		        </c:forEach>
		        </div>
	        </div>
        </c:if>
        <c:if test="${fn:length(referenceLinkList) gt 0}">
	        <div class="sopd-checking-bar-box4-subbox clearfix">
	          	<div class="sopd-c-title01" data-toggle="n-collapse" data-target="#references-box">References <div class="sp-filter-link-aero02 ani-1"><img src="<%= request.getContextPath() %>/images/down-aero-7.png"></div></div>
	          	<div class="n-collapse" id="references-box">
	          	<c:forEach items="${referenceLinkList}" var="referenceLinks">
	          	<div class="sopd-title03"><a href="${referenceLinks.referenceUrl}" target="_blank">${referenceLinks.referenceName}</a></div>
	          	</c:forEach> </div>
	        </div>
        </c:if> 
        <c:if test="${fn:length(sopArticlesList) gt 0}">
	        <div class="sopd-checking-bar-box4-subbox clearfix">
	          	<div class="sopd-c-title01" data-toggle="n-collapse" data-target="#related-topics">Related Topics<div class="sp-filter-link-aero02 ani-1"><img src="<%= request.getContextPath() %>/images/down-aero-7.png"></div></div>
	          	<div class="n-collapse" id="related-topics">
	          	<c:forEach items="${sopArticlesList}" var="article"  varStatus="articleCounter">
	          	<div class="sopd-title03"><a href="javascript:void(0);" onclick="<portlet:namespace />viewArticleDescription('${article.id}','${sopFilterValue}','${sopSubFilterValue}','${article.aricleURLTitle}');">${article.title}</a></div>
	          	</c:forEach> </div>
	        </div>
        </c:if> 
        <c:if test="${not empty article.articleVideo}">
	        <div class="sopd-checking-bar-box4-subbox clearfix">
	          	<div class="sopd-c-title01">Multimedia</div>
	          	<div id="multimedia-section">
	          		<div class="sopd-checking-bar-box4-subbox clearfix">
						<!-- <div class="sopd-title01">Video</div> -->
					    <div class="responsive-container" >
					      <a href="#videoDiv" id="videoThumbnaildDiv" class="various-1">
					      	<%-- <img src="<%= request.getContextPath() %>/images/playvideo.png" width="320" height="160"> --%>
					      	<%-- <img id="vimeoThumImgTest" src="<%= request.getContextPath() %>/images/How-To-Download-and-Play-MP4.jpg" width="320" height="160"> --%>
					      <!-- <img id="vimeoThumImgTest" src="" width="320" height="160"> -->
					      </a>
					    </div>
			    		<div id="videoDiv" style="display: none;">
			    			<div class="responsive-container">
			    				<iframe allowfullscreen="" frameborder="0" id="player1" mozallowfullscreen="" src="${article.articleVideo}" webkitallowfullscreen=""></iframe>
			    			</div>
			     		</div>
	     			</div>  
	          	</div>
	        	</div>
        	</c:if> 
      	</div>
		</div>
	</div>
  </div>

<style>
	.responsive-container { position: relative; padding-bottom: 56.25%;  height: 0; overflow: hidden;    }
	.responsive-container iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%;   }
</style>

<script type="text/javascript">
	$(document).ready(function() {

	if ($(document).height() > $(window).height()) {
		$("div.un-footer").css("position","relative");
	}else{
		$("div.un-footer").css({
			"position":"fixed",
			"left":"0px",
			"right":"0px",
			"bottom":"0px"
		});
	}

	$(".various-1").fancybox({
	  maxWidth : 820,
	  maxHeight : 600,
	  fitToView : false,
	  width  : '70%',
	  height  : 'auto',
	  autoSize : false,
	  closeClick : false,
	  openEffect : 'none',
	  closeEffect : 'none'
	 });


	 // Get View Thumbnail
	 var video_id = "${article.articleThumbnail}";
	 var videoURL = "${article.articleVideo}";
	 if(video_id != '' && videoURL.indexOf('vimeo') != -1){

		$.ajax({
	     type:'GET',
	     url: 'http://vimeo.com/api/v2/video/' + video_id + '.json',
	     jsonp: 'callback',
	     dataType: 'jsonp',
	     success: function(data){
	         var thumbnail_src = data[0].thumbnail_large;
	         $('#videoThumbnaildDiv').append('<img src="' + thumbnail_src + '" width="320" height="160"/>');
	     }
		});
	 }else{
		 var thumbnail_src = "http://img.youtube.com/vi/" + video_id + "/" +"2.jpg";
		 $('#videoThumbnaildDiv').append('<img src="' + thumbnail_src + '" width="320" height="160"/>');
	 }

	});

	function goBack() {
	    window.history.back();
	}
</script>

<%@include file="view_js.jsp" %>
<%@include file="sopResponse_js.jsp" %>