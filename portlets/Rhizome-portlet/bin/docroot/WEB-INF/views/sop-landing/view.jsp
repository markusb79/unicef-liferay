<%@include file="../init.jsp"%>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>

<liferay-theme:defineObjects />
 <div class="un-body-container">
<div class="body-container clearfix ani-1" id="main-div">
	
	<div id="un-navigation-small" class="n-collapse clearfix" aria-expanded="false">
      <div class="un-nsm-link cat-1"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#sop-sm-submenu" data-collapse-group="myDivs">+ SOP</a></div>
      <div class="n-collapse clearfix" id="sop-sm-submenu" aria-expanded="false">
        <div class="un-filter-linkbox">
          <div class="un-filter-text">Filter by</div>
          <div class="un-filter-linkbox02 clearfix">
	          <c:forEach items="${filters}" var="filter">
	          		<%-- <div class="un-filter-link"><a href="#" class="active">${filters}</a></div> --%>
	          		<portlet:renderURL var="filterURL">
					  <portlet:param name="view" value="CTRFilter" />
					  <portlet:param name="CTRName" value="${filter}" />
					</portlet:renderURL>
	          	
	          		<div class="un-filter-link">
	          			<%-- <a href="<%=filterURL.toString() %>" class="active">${filter}</a> --%>
	          			 <c:if test="${filter eq filterCategory}">
	          				<a href="<%=filterURL.toString() %>" class="active">${filter}</a>
	          			</c:if>
	          			<c:if test="${filter ne filterCategory}">
	          				<a href="<%=filterURL.toString() %>">${filter}</a>
	          			</c:if> 
	          		</div>
	          </c:forEach>
          </div>
        </div>
        <div class="un-navmenu-linkbox">
         	<c:forEach items="${categories}" var="category">
		    	<%-- <div class="un-navmenu-link"><a href="#">${category}</a></div> --%>
		    	<portlet:renderURL var="categoryURL">
				  <portlet:param name="view" value="categoryFilter" />
				  <portlet:param name="categoryName" value="${category}" />
				  <portlet:param name="filterCategory" value="${filterCategory}"/>
				</portlet:renderURL>
		    	<c:if test="${empty categoryName}">
		    		<div class="un-navmenu-link">
		    			<a href="<%=categoryURL.toString() %>">${category}</a>
		    		</div>
		    	</c:if>
		    	<c:if test="${not empty categoryName}">
		    		<c:if test="${categoryName eq category}">
		    			<div class="un-navmenu-link">
		    		</c:if>
				    <c:if test="${categoryName ne category}">
				    	<div class="un-navmenu-link" style="background-color: #DAE0DE !important;">
				    </c:if>
			    		<a href="<%=categoryURL.toString() %>">${category}</a>
			    	</div>
		    	</c:if>
		    </c:forEach>
        </div>
      </div>
      <div class="un-nsm-link cat-2"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#c4d-submenu" data-collapse-group="myDivs">+ C4D</a></div>
      <div class="n-collapse clearfix" id="c4d-submenu" aria-expanded="false"> C4d Content </div>
      <div class="un-nsm-link cat-3"><a href="javascript:void(0);" data-toggle="n-collapse" data-target="#data-submenu" data-collapse-group="myDivs">+ DATA</a></div>
      <div class="n-collapse clearfix" id="data-submenu" aria-expanded="false"> Data Content </div>
      <div class="un-nsm-link"><a href="#">+ MY TOOLKIT</a></div>
      <div class="un-nsm-link"><a href="#">ABOUT</a></div>
      <div class="un-nsm-link"><a href="#">CONTACT US</a></div>
      <div class="un-nsm-link"><a href="#">REPORT A BUG</a></div>
      <div class="un-nsm-link"><a href="#">SITEMAP</a></div>
    </div>
	<div class="clearfix" id="un-navigation-big">
		<div class="un-navmenu-mainbox clearfix" id="sop-big-submenu" >
		  <div class="un-navmenu-linkbox">
		    <c:forEach items="${categories}" var="category">
		    	<portlet:renderURL var="categoryURL">
				  <portlet:param name="view" value="categoryFilter" />
				  <portlet:param name="categoryName" value="${category}" />
				  <portlet:param name="filterCategory" value="${filterCategory}"/>
				</portlet:renderURL>
		    	<c:if test="${empty categoryName}">
		    		<div class="un-navmenu-link">
		    			<a href="<%=categoryURL.toString() %>">${category}</a>
		    		</div>
		    	</c:if>
		    	<c:if test="${not empty categoryName}">
		    		<c:if test="${categoryName eq category}">
		    			<div class="un-navmenu-link">
		    		</c:if>
				    <c:if test="${categoryName ne category}">
				    	<div class="un-navmenu-link" style="background-color: #DAE0DE !important;">
				    </c:if>
			    		<a href="<%=categoryURL.toString() %>">${category}</a>
			    	</div>
		    	</c:if>
		    </c:forEach>
		  </div>
		  <div class="un-filter-linkbox">
		    <div class="un-filter-text">Filter by</div>
		    <div class="un-filter-linkbox02 clearfix">
		    	<c:forEach items="${filters}" var="filter">
	          		<portlet:renderURL var="filterURL">
					  <portlet:param name="view" value="CTRFilter" />
					  <portlet:param name="CTRName" value="${filter}" />
					</portlet:renderURL>
	          	
	          		<div class="un-filter-link">
	          			<%-- <a href="<%=filterURL.toString() %>" class="active">${filter}</a> --%>
	          			 <c:if test="${filter eq filterCategory}">
	          				<a href="<%=filterURL.toString() %>" class="active"><span>${filter}</span></a>
	          			</c:if>
	          			<c:if test="${filter ne filterCategory}">
	          				<a href="<%=filterURL.toString() %>"><span>${filter}</span></a>
	          			</c:if> 
	          		</div>
	            </c:forEach>
		    </div>
		  </div>
		</div>
	</div>  
	<div id="un-inner-mobile-container">
		<div class="sopd-content-rowbox clearfix">
     	<c:forEach items="${sopArticlesList}" var="article"  varStatus="articleCounter">
	     	
	     	
		     	<div class="sopd-content-box">
			      <div class="sopd-content-subbox" style="background-color:${article.articleColor};">
					<div class="sopd-time-text" style="color:${article.fontColor};">${article.time}</div>
			        <div class="sopd-category-text" style="color:${article.fontColor};">${article.category}</div>
			        <div class="sopd-img-box"><img src="${article.imageArticle}"></div>
			        <div class="sopd-article-title" style="color:${article.fontColor};">${article.title}</div>
		      		<!-- <div class="sopd-article-button"><a href="/group/guest/notification">READ MORE</a></div> -->
		      		<portlet:renderURL var="viewSOPArticleURL">
						<portlet:param name="view" value="viewSOPArticle" />
						<portlet:param name="articleId" value="${article.id}" />
					</portlet:renderURL>
		      		<div class="sopd-article-button"><a href="<%=viewSOPArticleURL.toString() %>">READ MORE</a></div>
		      	
		      		<div class="sopd-share-but"> <a href="javascript:void(0);" class="" data-toggle="n-collapse" data-target="#<portlet:namespace/>${article.id}">share</a></div>
	            	  <div class="un-user-bookmark-box clearfix n-collapse" id="<portlet:namespace/>${article.id}" aria-expanded="false">
	                      <div class="un-user-checking-bar-box1">
	                        <label>
	                          <input type="checkbox" value="" name="">
	                          ADD TO MY CHECKLIST</label>
	                      </div>
	                      <div class="un-user-checking-bar-box2 sopd-add"><a href="#">ADD TO MYTOOLKIT</a></div>
	                    </div>
			      </div>
			      
	      		</div>
      		
      	</c:forEach>
     </div>
	</div>
	<div id="un-inner-slideshow">
        <div class="flexslider showOnMouseover">
          <ul class="slides">
          <c:forEach var="j" begin="1" end="${loopCounter+1}">
            <li>    
     <div class="sopd-content-rowbox clearfix">
     	<c:forEach items="${sopArticlesList}" var="article"  varStatus="articleCounter">
	     	<c:if test="${articleCounter.count ge (j*15-14) &&  articleCounter.count le (j*15)}">
		     	<div class="sopd-content-box">
			      <div class="sopd-content-subbox" style="background-color:${article.articleColor};">
					<div class="sopd-time-text" style="color:${article.fontColor};">${article.time}</div>
			        <div class="sopd-category-text" style="color:${article.fontColor};">${article.category}</div>
			        <div class="sopd-img-box"><img src="${article.imageArticle}"></div>
			        <div class="sopd-article-title" style="color:${article.fontColor};">${article.title}</div>
		      		<!-- <div class="sopd-article-button"><a href="/group/guest/notification">READ MORE</a></div> -->
		      		<portlet:renderURL var="viewSOPArticleURL">
						<portlet:param name="view" value="viewSOPArticle" />
						<portlet:param name="articleId" value="${article.id}" />
					</portlet:renderURL>
		      		<div class="sopd-article-button"><a href="<%=viewSOPArticleURL.toString() %>">READ MORE</a></div>
		      	
		      		<div class="sopd-share-but"> <a href="javascript:void(0);" class="" data-toggle="n-collapse" data-target="#${articleCounter.count}">share</a></div>
	            	  <div class="un-user-bookmark-box clearfix n-collapse" id="${articleCounter.count}" aria-expanded="false">
	                      <div class="un-user-checking-bar-box1">
	                        <label>
	                          <input type="checkbox" value="" name="">
	                          ADD TO MY CHECKLIST</label>
	                      </div>
	                      <div class="un-user-checking-bar-box2 sopd-add"><a href="#">ADD TO MYTOOLKIT</a></div>
	                    </div>
			      </div>
			      
	      		</div>
      		</c:if>
      	</c:forEach>
     </div>
     </li>
     </c:forEach>
     </ul>
     </div>
     </div> 
</div>     
</div>

<%@include file="view_js.jsp" %>