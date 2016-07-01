
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.rhizome.util.SearchQueryUtil"%>
<%@page import="com.liferay.portal.kernel.util.DateUtil"%>
<%@page import="com.rhizome.util.CommonUtil"%>
<%@page import="com.rhizome.util.SolutionUtil"%>
<%@page import="com.rhizome.domain.Solution"%>
<%@page import="com.liferay.portal.service.LayoutLocalServiceUtil"%>
<%@page import="com.rhizome.constants.Constants"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoValue"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoColumn"%>
<%@page import="com.liferay.portlet.expando.model.ExpandoTable"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoTableLocalServiceUtil"%>
<%@page import="com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>
<%@ include file="../init.jsp"%>
<%@page import="com.rhizome.util.SearchUtil"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>
<%@page import="com.liferay.portal.kernel.util.LocaleUtil"%>
<%@page import="com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetVocabulary"%>
<%@page import="com.liferay.portlet.asset.NoSuchCategoryException"%>
<%@page import="com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetCategory"%>
<%@page import="com.liferay.portlet.PortletURLUtil"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.kernel.util.HtmlUtil"%>
<%@page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@page import="com.liferay.portal.security.permission.ResourceActionsUtil"%>
<%@page import="com.liferay.portal.kernel.search.Summary"%>
<%@page import="com.liferay.portal.kernel.search.IndexerRegistryUtil"%>
<%@page import="com.liferay.portal.kernel.search.Indexer"%>
<%@page import="com.liferay.portal.kernel.util.HttpUtil"%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.util.PortletKeys"%>
<%@page import="com.liferay.portlet.asset.service.AssetEntryLocalServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetEntry"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetRenderer"%>
<%@page import="com.liferay.portlet.asset.AssetRendererFactoryRegistryUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetRendererFactory"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="com.liferay.portal.kernel.search.Field"%>
<%@page import="com.liferay.portal.kernel.search.Document"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil" %>
<%@page import="com.liferay.portal.kernel.xml.Node" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Document document = (Document)row.getObject();

String className = document.get(Field.ENTRY_CLASS_NAME);

String entryTitle = null;
String entrySummary = null;
String downloadURL = null;
String entreCreateDate = null;
String returnToFullPageURL = (String)request.getAttribute("search.jsp-returnToFullPageURL");
PortletURL viewFullContentURL = null;
String viewURL = null;
AssetRendererFactory assetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(className);

AssetRenderer assetRenderer = null;

boolean inheritRedirect = false;

boolean viewInContext = true;
String currentURL = PortalUtil.getCurrentURL(renderRequest);

long entryId = GetterUtil.getLong(document.get(Field.ENTRY_CLASS_PK));
ExpandoTable expandoTable = ExpandoTableLocalServiceUtil.getTable(themeDisplay.getCompanyId(), PortalUtil.getClassNameId(DLFileEntry.class), "CUSTOM_FIELDS");
ExpandoColumn expandoColumn = ExpandoColumnLocalServiceUtil.getColumn(expandoTable.getTableId(), "urlTitle");
ExpandoValue urlTitleValue = null;

long assetEntryId=0; //added by Abhishek 

if (assetRendererFactory != null) {
	long classPK = GetterUtil.getLong(document.get(Field.ENTRY_CLASS_PK));

	long resourcePrimKey = GetterUtil.getLong(document.get(Field.ROOT_ENTRY_CLASS_PK));
	
	AssetEntry assetEntry = AssetEntryLocalServiceUtil.getEntry(className, classPK);

	assetRenderer = assetRendererFactory.getAssetRenderer(classPK);

	downloadURL = assetRenderer.getURLDownload(themeDisplay);

	viewFullContentURL = SearchUtil._getViewFullContentURL(request, themeDisplay, PortletKeys.ASSET_PUBLISHER, document);
	
	viewFullContentURL.setParameter("struts_action", "/asset_publisher/view_content");

	if (Validator.isNotNull(returnToFullPageURL)) {
		viewFullContentURL.setParameter("returnToFullPageURL", returnToFullPageURL);
	}

	viewFullContentURL.setParameter("assetEntryId", String.valueOf(assetEntry.getEntryId()));
	viewFullContentURL.setParameter("type", assetRendererFactory.getType());
	
	if (Validator.isNotNull(assetRenderer.getUrlTitle())) {
		if ((assetRenderer.getGroupId() > 0) && (assetRenderer.getGroupId() != scopeGroupId)) {
			viewFullContentURL.setParameter("groupId", String.valueOf(assetRenderer.getGroupId()));
		}

		viewFullContentURL.setParameter("urlTitle", assetRenderer.getUrlTitle());
	}
	
	if (viewInContext) {
		inheritRedirect = true;

		String viewFullContentURLString = viewFullContentURL.toString();

		viewFullContentURLString = HttpUtil.setParameter(viewFullContentURLString, "redirect", currentURL);

		viewURL = assetRenderer.getURLViewInContext(liferayPortletRequest, liferayPortletResponse, viewFullContentURLString);
	}
	else {
		viewURL = viewFullContentURL.toString();
	}
	assetEntryId = assetEntry.getEntryId();
}
else {
	String portletId = document.get(Field.PORTLET_ID);

	viewFullContentURL = SearchUtil._getViewFullContentURL(request, themeDisplay, portletId, document);

	if (Validator.isNotNull(returnToFullPageURL)) {
		viewFullContentURL.setParameter("returnToFullPageURL", returnToFullPageURL);
	}

	viewURL = viewFullContentURL.toString();
}

Indexer indexer = IndexerRegistryUtil.getIndexer(className);

if (indexer != null) {
	String snippet = document.get(Field.SNIPPET);

	Summary summary = indexer.getSummary(document, locale, snippet, viewFullContentURL);

	entryTitle = summary.getTitle();
	entrySummary = summary.getContent();
}
else if (assetRenderer != null) {
	entryTitle = assetRenderer.getTitle(themeDisplay.getLocale());
	entrySummary = assetRenderer.getSearchSummary(themeDisplay.getLocale());
}

if ((assetRendererFactory == null) && viewInContext) {
	viewURL = viewFullContentURL.toString();
}

viewURL = SearchUtil._checkViewURL(themeDisplay, viewURL, currentURL, inheritRedirect);

String[] queryTerms = (String[])request.getAttribute("search.jsp-queryTerms");

PortletURL portletURL = (PortletURL)request.getAttribute("search.jsp-portletURL");
PortletURL customPortletURL = null;
String friendlyURL = StringPool.BLANK;
boolean isNew = Boolean.FALSE;
boolean isHot = Boolean.FALSE;
int newTHRESHOLD = 2;
int hotTHRESHOLD = 7;

if(className.equals(DLFileEntry.class.getName())){
	
    //portletURL.setParameter("fileEntryId", String.valueOf(classPK));
    try {
    	urlTitleValue = ExpandoValueLocalServiceUtil.
    					getValue(themeDisplay.getCompanyId(),PortalUtil.getClassNameId(DLFileEntry.class),expandoTable.getName(), 
    					expandoColumn.getName(),entryId);
    	if(Validator.isNotNull(urlTitleValue)){
    		friendlyURL = "/group/guest/" + entryId + StringPool.DASH +"toolkit-documents" + StringPool.DASH + urlTitleValue.getData();
    		
    	}
    	else{
    		friendlyURL = viewURL;
    	}
    }
    catch(Exception e){
        friendlyURL = viewURL;
    }
}else if(className.equals(Solution.class.getName())){
	try {
		entryTitle = document.get(Field.TITLE);
		entrySummary = document.get(Field.DESCRIPTION);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = formatter.parse(document.get(Field.CREATE_DATE));
		entreCreateDate = new SimpleDateFormat("MMM dd, YYYY").format(date).toUpperCase();

		if(className.equals(Solution.class.getName())){
			customPortletURL = CommonUtil.createSolutionPortletURL(request, themeDisplay.getPlid(), entryId, themeDisplay.getScopeGroupId());
			boolean isSolutionHot = GetterUtil.getBoolean(document.get(Constants.HOT));
			double hotWeight = Double.parseDouble(document.get(Constants.HOT_WEIGHT));
			Date createdDate = SearchQueryUtil.indexerDateFormat.parse(document.get(Field.CREATE_DATE));
			isNew = SolutionUtil.isSolutionNew(newTHRESHOLD, createdDate);
			isHot = SolutionUtil.isSolutionHOT(hotTHRESHOLD, createdDate, isSolutionHot, hotWeight);
		}
    }catch(Exception e){
        System.out.println("Error in getting entryTitle or entrySummary for Idea:"+e.getMessage());
    }
}else if(className.equals(JournalArticle.class.getName())){
	try {
		entryTitle = document.get(Field.TITLE);
		entrySummary = document.get(Field.DESCRIPTION);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = formatter.parse(document.get(Field.CREATE_DATE));
		entreCreateDate = new SimpleDateFormat("MMM dd, YYYY").format(date).toUpperCase();
		
		String time = (String)request.getAttribute("time");
		/* System.out.println("TIME :: >>> :: >>> "+time); */
		
		if(className.equals(JournalArticle.class.getName())){
			
			JournalArticle article =  JournalArticleLocalServiceUtil.getLatestArticle(entryId);
			com.liferay.portal.kernel.xml.Document doc = SAXReaderUtil.read(article.getContentByLocale("en_US"));
			Node categoryNode = doc.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
			String categoryValue = categoryNode.getText();
			
			if(Validator.isNotNull(time)){
				Calendar currentDate = Calendar.getInstance();
				Date endDate = currentDate.getTime();
				   
				currentDate.add(Calendar.DATE, -7);
				Date startDate = currentDate.getTime();
				
			
				
				boolean flag = false;
				if(article.getCreateDate().after(startDate) && article.getCreateDate().before(new Date())){
//					System.out.println("ARTICLE CREATED DATE :: -- "+article.getCreateDate());
					flag=true;
				}
				pageContext.setAttribute("flag", flag);
			}
		//	System.out.println("CATEGORY VALUE :: -- "+categoryValue);
		//	System.out.println("Start Date :: -- "+startDate);
			
			customPortletURL = CommonUtil.createSOPPortletURL(request, themeDisplay.getPlid(), entryId, assetEntryId, themeDisplay.getScopeGroupId());
			friendlyURL = customPortletURL.toString(); 
		}
		
		 
    }catch(Exception e){
        System.out.println("Error in getting entryTitle or entrySummary for SOP:"+e.getMessage());
    }
}else{
	friendlyURL = viewURL;
}
%>

<div class="clearfix">
		
	<c:choose>
		<c:when test="<%=className.equals(Solution.class.getName()) %>">
			<div class="sp-list-mainbox clearfix">
			<div class="sp-list-mainbox-head clearfix">
			 <div class="sp-list-titlebox clearfix">
			<div class="un-sp-title05 clearfix"><span>
				<a href="<%=customPortletURL.toString()%>">
						<img alt="Solution" src="<%=request.getContextPath()%>/images/solution.png" class="imgWidth">
						<%= HtmlUtil.escape(entryTitle) %>
				</a></span> <span>SOP / Category / Article page</span></div>
				<div class="un-sp-title06 clearfix"><span>DATE</span><span><%= entreCreateDate %></span></div>
				</div></div>
				<div class="sp-list-textbox">
					<%= HtmlUtil.escape(entrySummary) %>
				</div>
				</div>
		</c:when>
		<c:otherwise>
		 <div class="sp-list-mainbox clearfix">
		 <div class="sp-list-mainbox-head clearfix">
		 <div class="sp-list-titlebox clearfix">
			<div class="un-sp-title05 clearfix"><span>
				<a href="<%= friendlyURL %>">
					<c:if test="<%= assetRenderer != null %>">
						<img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" />
					</c:if>
		
					<%= HtmlUtil.escape(entryTitle)+" web title open fire" %>
				</a></span> <span>SOP / Category / Article page</span></div>
				<div class="un-sp-title06 clearfix"><span>DATE</span><span><%= entreCreateDate %></span></div>
				</div></div>
				<div class="sp-list-textbox">
					<%= HtmlUtil.escape(entrySummary) %>
				</div>
			</div>
				 <c:if test="<%= Validator.isNotNull(downloadURL) %>">
					<liferay-ui:icon image="../arrows/01_down" label="<%= false %>" message='<%= LanguageUtil.format(pageContext, "download-x", HtmlUtil.escape(entryTitle)) %>' url="<%= downloadURL %>" />
				</c:if>
		</c:otherwise>
	</c:choose>
</div>
