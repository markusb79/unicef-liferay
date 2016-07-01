package com.rhizome.portlet.c4d.landing;

import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.OrderFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.PortletClassLoaderUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.xml.Document;
import com.liferay.portal.kernel.xml.DocumentException;
import com.liferay.portal.kernel.xml.Node;
import com.liferay.portal.kernel.xml.SAXReaderUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.expando.model.ExpandoColumn;
import com.liferay.portlet.expando.model.ExpandoTable;
import com.liferay.portlet.expando.model.ExpandoValue;
import com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil;
import com.liferay.portlet.expando.service.ExpandoTableLocalServiceUtil;
import com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.model.JournalFolder;
import com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil;
import com.liferay.portlet.journal.service.JournalFolderLocalServiceUtil;
import com.liferay.support.tomcat.loader.PortalClassLoaderFactory;
import com.rhizome.domain.C4DArticles;
import com.rhizome.domain.C4DCheckList;
import com.rhizome.domain.ReferenceLinks;
import com.rhizome.domain.TemplateLinks;
import com.rhizome.portlet.sop.landing.SopLandingUtil;
import com.rhizome.service.C4DCheckListService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

@Controller
@RequestMapping("VIEW")
public class C4DLandingController {
	
	private static final String UNDERSTAND = "underStand";
	
	@Autowired
	private C4DCheckListService c4dCheckListService; 
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,RenderResponse renderResponse) throws PortalException, SystemException, DocumentException{
		
		return "view";
	}
	
	@RenderMapping(params="view=underStand")
	public String openUnderStandURL(RenderRequest renderRequest,RenderResponse renderResponse,Model model) throws SystemException, PortalException, DocumentException{
		
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		HttpServletRequest httpServletRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		String action = ParamUtil.getString(httpServletRequest, "action");
		
		model.addAttribute("action", action);
		return "c4dLanding";
	}
	
	@ResourceMapping(value="viewC4DLandingController")
	public String viewC4DLandingController(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model) throws SystemException, PortalException, DocumentException, IOException{
		
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		HttpServletRequest httpServletRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		String c4dScrollCount = ParamUtil.getString(httpServletRequest, "c4dScrollCount");
		String mainCategory = ParamUtil.getString(httpServletRequest, "mainCategory");
		
		// method to load tiles
		List<JournalFolder> journalFolder = new ArrayList<JournalFolder>();
		List<JournalArticle> journalArticles = new ArrayList<JournalArticle>();
		
		C4DArticles articles = new C4DArticles();
		List<C4DArticles> c4dArticlesList = new ArrayList<C4DArticles>();
		
		List<C4DArticles> understandBehaviouralGoal = new ArrayList<C4DArticles>();
		List<C4DArticles> understandUsingEvidGoal = new ArrayList<C4DArticles>();
		List<C4DArticles> understandIDHighRiskGoal = new ArrayList<C4DArticles>();
		
		List<C4DArticles> planSegmentation = new ArrayList<C4DArticles>();
		List<C4DArticles> planBarriers = new ArrayList<C4DArticles>();
		List<C4DArticles> planMessaging = new ArrayList<C4DArticles>();
		List<C4DArticles> planChannelAnalysis = new ArrayList<C4DArticles>();
		List<C4DArticles> planIDScenario = new ArrayList<C4DArticles>();
		
		List<C4DArticles> actMonitorEval = new ArrayList<C4DArticles>();
		List<C4DArticles> actIntgrdAct = new ArrayList<C4DArticles>();
		List<C4DArticles> actGlobalStr = new ArrayList<C4DArticles>();
		List<C4DArticles> actCapacityBldg = new ArrayList<C4DArticles>();
		
		List<C4DArticles> toolsMassMedIEC = new ArrayList<C4DArticles>();
		List<C4DArticles> toolsTraining = new ArrayList<C4DArticles>();
		List<C4DArticles> toolsMgmtTools = new ArrayList<C4DArticles>();
		List<C4DArticles> toolsInnovations = new ArrayList<C4DArticles>();
		
		DynamicQuery journalFolderQuery = DynamicQueryFactoryUtil.forClass(JournalFolder.class, PortletClassLoaderUtil.getClassLoader());
		journalFolderQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("companyId").eq(new Long(themeDisplay.getCompanyId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("name").eq("C4D"));
		journalFolder = JournalFolderLocalServiceUtil.dynamicQuery(journalFolderQuery);

		DynamicQuery journalArticleQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, PortletClassLoaderUtil.getClassLoader());
		journalArticleQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("folderId").eq(new Long(journalFolder.get(0).getFolderId())));
		journalArticleQuery.addOrder(OrderFactoryUtil.asc("resourcePrimKey"));
		journalArticles = JournalArticleLocalServiceUtil.dynamicQuery(journalArticleQuery);
		
		for (JournalArticle article : journalArticles) {
			
			try {
				
				double latestArticleVersion = JournalArticleLocalServiceUtil.getLatestVersion(themeDisplay.getScopeGroupId(), article.getArticleId());
				if(latestArticleVersion == article.getVersion()){
					
					ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(article,themeDisplay);
					
//					System.out.println("Expando-Value ::: >>> "+expandoValue.getData());
					
					articles = new C4DArticles();
					
					Document document = SAXReaderUtil.read(article.getContentByLocale("en_US"));
					Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
					String titleValue = titleNode.getText();
					Node categoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
					String categoryValue = categoryNode.getText();
					Node subCategoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Sub-Category" +"']/dynamic-content");
					String subCategoryValue = subCategoryNode.getText();
					Node descriptionNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Description" +"']/dynamic-content");
					String descriptionValue = descriptionNode.getText();
					Node imageNode = document.selectSingleNode("/root/dynamic-element[@name='" + "imageArticle" +"']/dynamic-content");
					String imageValue = imageNode.getText();
					
					articles.setArticleId(article.getId());
					articles.setTitle(titleValue);
					articles.setCategory(categoryValue);
					articles.setSubcategory(subCategoryValue);
					articles.setImageArticle(imageValue);
					if(Validator.isNotNull(expandoValue)){
						articles.setAricleURLTitle(expandoValue.getData());
					}
					if(categoryValue.equalsIgnoreCase(mainCategory)){
						if(subCategoryValue.equalsIgnoreCase("Behavioural Goal")){
							articles.setArticleColor("#5F7B05");
							understandBehaviouralGoal.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Using Evidence")){
							articles.setArticleColor("#8DA900");
							understandUsingEvidGoal.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("ID High Risk Groups")){
							articles.setArticleColor("#B3D438");
							understandIDHighRiskGoal.add(articles);
						}
						
						if(subCategoryValue.equalsIgnoreCase("Segmentation")){
							articles.setArticleColor("#072F77");
							planSegmentation.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Barriers")){
							articles.setArticleColor("#0735AC");
							planBarriers.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Messaging")){
							articles.setArticleColor("#2076DB");
							planMessaging.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Channel Analysis")){
							articles.setArticleColor("#5AB0F1");
							planChannelAnalysis.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("ID Your Scenario")){
							articles.setArticleColor("#B3E1FF");
							articles.setArticleFontColor("#000000");
							planIDScenario.add(articles);
						}
						
						if(subCategoryValue.equalsIgnoreCase("Monitor Evaluate")){
							articles.setArticleColor("#C4F1C4");
							articles.setArticleFontColor("#000000");
							actMonitorEval.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Integrated Action")){
							articles.setArticleColor("#008953");
							actIntgrdAct.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("The Global Strategy")){
							articles.setArticleColor("#06583D");
							actGlobalStr.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Capacity Building")){
							articles.setArticleColor("#45BE70");
							actCapacityBldg.add(articles);
						}
						
						if(subCategoryValue.equalsIgnoreCase("Mass Media IEC")){
							articles.setArticleColor("#1C6682");
							toolsMassMedIEC.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Training")){
							articles.setArticleColor("#009DA4");
							toolsTraining.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Management Tools")){
							articles.setArticleColor("#1DBEBE");
							toolsMgmtTools.add(articles);
						}
						if(subCategoryValue.equalsIgnoreCase("Innovations")){
							articles.setArticleColor("#AEF1DF");
							articles.setArticleFontColor("#000000");
							toolsInnovations.add(articles);
						}
					}
				}
				
			} catch(Exception e) {
				_log.error("----------------- web content not found -------------" + e.getMessage() );
			}
			
		}
		c4dArticlesList.addAll(understandBehaviouralGoal);
		c4dArticlesList.addAll(understandUsingEvidGoal);
		c4dArticlesList.addAll(understandIDHighRiskGoal);
		
		c4dArticlesList.addAll(planSegmentation);
		c4dArticlesList.addAll(planBarriers);
		c4dArticlesList.addAll(planMessaging);
		c4dArticlesList.addAll(planChannelAnalysis);
		c4dArticlesList.addAll(planIDScenario);
		
		c4dArticlesList.addAll(actGlobalStr);
		c4dArticlesList.addAll(actIntgrdAct);
		c4dArticlesList.addAll(actCapacityBldg);
		c4dArticlesList.addAll(actMonitorEval);

		c4dArticlesList.addAll(toolsMassMedIEC);
		c4dArticlesList.addAll(toolsTraining);
		c4dArticlesList.addAll(toolsMgmtTools);
		c4dArticlesList.addAll(toolsInnovations);
		model.addAttribute("c4dArticlesList", c4dArticlesList);
		model.addAttribute("action", mainCategory);
		model.addAttribute("c4dCheckListService", c4dCheckListService);
		return "c4dLandingResponse";
	}
	
	@RenderMapping(params="viewc4d")
	public String viewc4d(RenderRequest renderRequest,RenderResponse renderResponse,Model model) throws SystemException, PortalException, DocumentException{
		
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = 0;
		String viewC4DArticleURL = ParamUtil.getString(renderRequest, "viewC4DArticleURL",StringPool.BLANK);
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		String action = ParamUtil.getString(request, "action");
		ExpandoTable expandoTable = ExpandoTableLocalServiceUtil.getDefaultTable(themeDisplay.getCompanyId(), JournalArticle.class.getName());
		ExpandoColumn column = ExpandoColumnLocalServiceUtil.getColumn(expandoTable.getTableId(), "Article_Title");
		List<ExpandoValue> expandoValueList = new ArrayList<ExpandoValue>();
		expandoValueList = ExpandoValueLocalServiceUtil.getColumnValues(column.getColumnId(), -1, -1);
		for (ExpandoValue expandoValue : expandoValueList) {
			if(expandoValue.getData().equalsIgnoreCase(viewC4DArticleURL)){
				articleId = expandoValue.getClassPK();
			}
		}
		
		JournalArticle journalArticle = JournalArticleLocalServiceUtil.getArticle(articleId);
		C4DArticles articles = new C4DArticles();
		C4DArticles originalArticles = null;

		Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));
		Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
		String titleValue = titleNode.getText();
		Node categoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
		String categoryValue = categoryNode.getText();
		Node subCategoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Sub-Category" +"']/dynamic-content");
		String subCategoryValue = subCategoryNode.getText();
		Node descriptionNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Description" +"']/dynamic-content");
		String descriptionValue = descriptionNode.getText();
		Node imageNode = document.selectSingleNode("/root/dynamic-element[@name='" + "imageArticle" +"']/dynamic-content");
		String imageValue = imageNode.getText();
		
		//=====================================================================================================
		
		List<TemplateLinks> templateLinkList = new ArrayList<TemplateLinks>();
		TemplateLinks templateLinks = null;
		DLFileEntry fileEntry = null;
		String templateLinkValue="";
		String templateFileEntryURL="";
		List<Node> templateNodes = document.selectNodes("/root/dynamic-element[@name='" + "templateLinks" +"']/dynamic-content");
		for(Node templateObj : templateNodes){
			try {
				templateLinkValue = templateObj.getText();
				String[] templateLinkResult = templateLinkValue.split("/");
				if(templateLinkResult.length > 1){
					templateLinks = new TemplateLinks();
					String folderName = templateLinkResult[4];
					folderName = folderName.replace("+", " ").replace("%28", "(").replace("%29", ")").replace("%C2%B0", "\u00b0");
					fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), Long.parseLong(templateLinkResult[3]), folderName);

					/**
					 * templateFileEntryURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/web/guest/"
							+ fileEntry.getFileEntryId()+"-toolkit-documents-"+fileEntry.getTitle().replace(" ", "-").toLowerCase();
					 *
					 */

					templateFileEntryURL = themeDisplay.getPortalURL()+"/c/document_library/get_file?uuid="+ fileEntry.getUuid()+"&groupId="+themeDisplay.getScopeGroupId();

					templateLinks.setTemplateUrl(templateFileEntryURL);
					String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
					templateLinks.setTemplateName(fileName);
					templateLinkList.add(templateLinks);
				}
			}
			catch (Exception e) {
				_log.error("Exception caught while processing Template entries in C4DLandingController.viewc4d(): " + e.getMessage(), e );
			}
		}
		
		List<ReferenceLinks> referenceLinkList = new ArrayList<ReferenceLinks>();
		ReferenceLinks referenceLinks = null;
		String referenceLinkValue="";
		String referenceFileEntryURL="";
		List<Node> referenceNodes = document.selectNodes("/root/dynamic-element[@name='" + "referenceLinks" +"']/dynamic-content");
		for(Node referenceObj : referenceNodes) {
			try {
				referenceLinkValue = referenceObj.getText();
				String[] referenceLinkResult = referenceLinkValue.split("/");
				if(referenceLinkResult.length > 1){
					referenceLinks = new ReferenceLinks();

					String folderName = referenceLinkResult[4];
					folderName = folderName.replace("+", " ").replace("%28", "(").replace("%29", ")").replace("%C2%B0", "\u00b0");
					fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), Long.parseLong(referenceLinkResult[3]), folderName);

					/**
					  * referenceFileEntryURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/web/guest/"
					  *	+ fileEntry.getFileEntryId()+"-toolkit-documents-"+fileEntry.getTitle().replace(" ", "-").toLowerCase();
					  *
					  */

					referenceFileEntryURL = themeDisplay.getPortalURL()+"/c/document_library/get_file?uuid="+ fileEntry.getUuid()+"&groupId="+themeDisplay.getScopeGroupId();

					referenceLinks.setReferenceUrl(referenceFileEntryURL);
					String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
					referenceLinks.setReferenceName(fileName);
					referenceLinkList.add(referenceLinks);
				}
			}
			catch (Exception e) {
				_log.error("Exception caught while processing Reference entries in C4DLandingController.viewc4d(): " + e.getMessage(), e );
			}
		}
		
		List<JournalFolder> journalFolder = new ArrayList<JournalFolder>();
		List<JournalArticle> journalArticles = new ArrayList<JournalArticle>();
	
		model.addAttribute("referenceLinkList", referenceLinkList);
		model.addAttribute("templateLinkList", templateLinkList);
		
		//=====================================================================================================
		
		articles.setArticleId(articleId);
		articles.setTitle(titleValue);
		articles.setCategory(categoryValue);
		articles.setSubcategory(subCategoryValue);
		articles.setArticleContent(descriptionValue);
		articles.setImageArticle(imageValue);
		String colorCode = getColorCodeBySubCategory(subCategoryValue);
		articles.setArticleColor(colorCode);
		String categoryColorCode = getColorCodeByCategory(categoryValue);
		articles.setCategoryColor(categoryColorCode);
		String categoryColorImage = getColorImageByCategory(categoryValue);
		articles.setCategoryColorImage(categoryColorImage);
		
		if(subCategoryValue.equalsIgnoreCase("ID Your Scenario") || subCategoryValue.equalsIgnoreCase("Monitor Evaluate") || subCategoryValue.equalsIgnoreCase("Innovations")){
			articles.setArticleFontColor("#000000");
		}
		
		originalArticles = articles;
		model.addAttribute("article", articles);
		
		
		//=====================================================================================================
		
		DynamicQuery journalFolderQuery = DynamicQueryFactoryUtil.forClass(JournalFolder.class, PortletClassLoaderUtil.getClassLoader());
		journalFolderQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("companyId").eq(new Long(themeDisplay.getCompanyId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("name").eq("C4D"));
		journalFolder = JournalFolderLocalServiceUtil.dynamicQuery(journalFolderQuery);

		DynamicQuery journalArticleQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, PortletClassLoaderUtil.getClassLoader());
		journalArticleQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("folderId").eq(new Long(journalFolder.get(0).getFolderId())));
		journalArticleQuery.addOrder(OrderFactoryUtil.asc("resourcePrimKey"));
		journalArticles = JournalArticleLocalServiceUtil.dynamicQuery(journalArticleQuery);
		
		List<C4DArticles> c4dArticlesList = new ArrayList<C4DArticles>();
		List<C4DArticles> c4dArticlesListAll = new ArrayList<C4DArticles>();
		C4DArticles previousArticle = null;
		C4DArticles nextArticle = null;
		boolean foundPreviousArticle = false;

		int i=0;
		for (JournalArticle article : journalArticles) {
			try {
				double latestArticleVersion = JournalArticleLocalServiceUtil.getLatestVersion(themeDisplay.getScopeGroupId(), article.getArticleId());
				if(latestArticleVersion == article.getVersion()){

					ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(article,themeDisplay);
					articles = new C4DArticles();

					Document relatedDocument = SAXReaderUtil.read(article.getContentByLocale("en_US"));
					Node relatedTitleNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
					String relatedTitleValue = relatedTitleNode.getText();
					Node relatedCategoryNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
					String relatedCategoryValue = relatedCategoryNode.getText();
					Node relatedSubCategoryNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Sub-Category" +"']/dynamic-content");
					String relatedSubCategoryValue = relatedSubCategoryNode.getText();
					Node relatedDescriptionNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Description" +"']/dynamic-content");
					String relatedDescriptionValue = relatedDescriptionNode.getText();
					Node relatedImageNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "imageArticle" +"']/dynamic-content");
					String relatedImageValue = relatedImageNode.getText();

					// the articleId and articleURLTitle are used in the c4dDetailsView for the previous and next links at the bottom
					if (relatedCategoryValue.equalsIgnoreCase(categoryValue)) {
						articles.setArticleId(article.getId());
						if (Validator.isNotNull(expandoValue)) {
							articles.setAricleURLTitle(expandoValue.getData());
						}
						if(article.getId() != articleId) c4dArticlesListAll.add(articles);
						else c4dArticlesListAll.add(originalArticles);
					}

					// sub category validator
					if(subCategoryValue.equalsIgnoreCase(relatedSubCategoryValue)) {
					// if(subCategoryValue.equalsIgnoreCase(relatedSubCategoryValue) && article.getId() != articleId){

						articles.setTitle(relatedTitleValue);
						articles.setCategory(relatedCategoryValue);
						articles.setSubcategory(relatedSubCategoryValue);
						articles.setImageArticle(relatedImageValue);

						if(relatedSubCategoryValue.equalsIgnoreCase("Behavioural Goal")){
							articles.setArticleColor("#5F7B05");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Using Evidence")){
							articles.setArticleColor("#8DA900");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("ID High Risk Groups")){
							articles.setArticleColor("#B3D438");
						}

						if(relatedSubCategoryValue.equalsIgnoreCase("Segmentation")){
							articles.setArticleColor("#072F77");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Barriers")){
							articles.setArticleColor("#0735AC");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Messaging")){
							articles.setArticleColor("#2076DB");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Channel Analysis")){
							articles.setArticleColor("#5AB0F1");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("ID Your Scenario")){
							articles.setArticleColor("#B3E1FF");
							articles.setArticleFontColor("#000000");
						}

						if(relatedSubCategoryValue.equalsIgnoreCase("Monitor Evaluate")){
							articles.setArticleColor("#C4F1C4");
							articles.setArticleFontColor("#000000");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Integrated Action")){
							articles.setArticleColor("#008953");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("The Global Strategy")){
							articles.setArticleColor("#06583D");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Capacity Building")){
							articles.setArticleColor("#45BE70");
						}

						if(relatedSubCategoryValue.equalsIgnoreCase("Mass Media IEC")){
							articles.setArticleColor("#1C6682");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Training")){
							articles.setArticleColor("#009DA4");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Management Tools")){
							articles.setArticleColor("#1DBEBE");
						}
						if(relatedSubCategoryValue.equalsIgnoreCase("Innovations")){
							articles.setArticleColor("#AEF1DF");
							articles.setArticleFontColor("#000000");
						}

						if(article.getId() != articleId && i<3) {
							c4dArticlesList.add(articles);
							i++;
						}
					}

				}
			} catch(Exception e) {
				_log.error("----------------- web content not found (C4D details page, C4DLandingController) -------------" + e.getMessage() );
			}
		}

		previousArticle = getPrevious(originalArticles, c4dArticlesListAll);
		nextArticle = getNext(originalArticles, c4dArticlesListAll);
		
		model.addAttribute("action", action);
		
		model.addAttribute("c4dArticlesList", c4dArticlesList);
		
		model.addAttribute("c4dPreviousArticle", previousArticle);
		model.addAttribute("c4dNextArticle", nextArticle);
		model.addAttribute("c4dCheckListService", c4dCheckListService);
		
		return "c4dDetailView";
	}
	
	private C4DArticles getNext(C4DArticles uid, List<C4DArticles> c4dArticleList) {
	    int idx = c4dArticleList.indexOf(uid);
	    if (idx < 0 || idx+1 == c4dArticleList.size()) return null;
	    return c4dArticleList.get(idx + 1);
	}
	private C4DArticles getPrevious(C4DArticles uid, List<C4DArticles> c4dArticleList) {
	    int idx = c4dArticleList.indexOf(uid);
	    if (idx <= 0) return null;
	    return c4dArticleList.get(idx - 1);
	}
	
	@RenderMapping(params = "view=viewC4DArticle")
	public String viewC4DArticle(RenderRequest renderRequest,RenderResponse renderResponse, Model model) throws PortalException, SystemException, DocumentException{
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(renderRequest, "articleId", 0);
		
		JournalArticle journalArticle = JournalArticleLocalServiceUtil.getArticle(articleId);
		C4DArticles articles = new C4DArticles();

		Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));
		Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
		String titleValue = titleNode.getText();
		Node categoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
		String categoryValue = categoryNode.getText();
		Node subCategoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Sub-Category" +"']/dynamic-content");
		String subCategoryValue = subCategoryNode.getText();
		Node descriptionNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Description" +"']/dynamic-content");
		String descriptionValue = descriptionNode.getText();
		Node imageNode = document.selectSingleNode("/root/dynamic-element[@name='" + "imageArticle" +"']/dynamic-content");
		String imageValue = imageNode.getText();
		
		//=====================================================================================================
		
		List<TemplateLinks> templateLinkList = new ArrayList<TemplateLinks>();
		TemplateLinks templateLinks = null;
		DLFileEntry fileEntry = null;
		String templateLinkValue="";
		String templateFileEntryURL="";
		List<Node> templateNodes = document.selectNodes("/root/dynamic-element[@name='" + "templateLinks" +"']/dynamic-content");
		for(Node templateObj : templateNodes){
			templateLinkValue = templateObj.getText();
			String[] templateLinkResult = templateLinkValue.split("/");
			if(templateLinkResult.length > 1){
				templateLinks = new TemplateLinks();
				String folderName = templateLinkResult[4];
				folderName = folderName.replace("+", " ").replace("%28", "(").replace("%29", ")").replace("%C2%B0", "\u00b0");
				fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), Long.parseLong(templateLinkResult[3]), folderName);
				
				templateFileEntryURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/web/guest/"
						+ fileEntry.getFileEntryId()+"-toolkit-documents-"+fileEntry.getTitle().replace(" ", "-").toLowerCase();
				
				templateLinks.setTemplateUrl(templateFileEntryURL);
				String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
				templateLinks.setTemplateName(fileName);
				templateLinkList.add(templateLinks);
			}
		}
		
		List<ReferenceLinks> referenceLinkList = new ArrayList<ReferenceLinks>();
		ReferenceLinks referenceLinks = null;
		String referenceLinkValue="";
		String referenceFileEntryURL="";
		List<Node> referenceNodes = document.selectNodes("/root/dynamic-element[@name='" + "referenceLinks" +"']/dynamic-content");
		for(Node referenceObj : referenceNodes){
			referenceLinkValue = referenceObj.getText();
			String[] referenceLinkResult = referenceLinkValue.split("/");
			if(referenceLinkResult.length > 1){
				referenceLinks = new ReferenceLinks();

				String folderName = referenceLinkResult[4];
				folderName = folderName.replace("+", " ").replace("%28", "(").replace("%29", ")").replace("%C2%B0", "\u00b0");
				fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), Long.parseLong(referenceLinkResult[3]), folderName);
				
				/** 
				 * referenceFileEntryURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/web/guest/"
				 		+ fileEntry.getFileEntryId()+"-toolkit-documents-"+fileEntry.getTitle().replace(" ", "-").toLowerCase();
				 */
				
				referenceFileEntryURL = themeDisplay.getPortalURL()+"/c/document_library/get_file?uuid="+ fileEntry.getUuid()+"&groupId="+themeDisplay.getScopeGroupId();
				
				referenceLinks.setReferenceUrl(referenceFileEntryURL);
				
				String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
				referenceLinks.setReferenceName(fileName);
				referenceLinkList.add(referenceLinks);
			}
		}
		
		List<JournalFolder> journalFolder = new ArrayList<JournalFolder>();
		List<JournalArticle> journalArticles = new ArrayList<JournalArticle>();
	
		model.addAttribute("referenceLinkList", referenceLinkList);
		model.addAttribute("templateLinkList", templateLinkList);
		
		//=====================================================================================================
		
		articles.setArticleId(articleId);
		articles.setTitle(titleValue);
		articles.setCategory(categoryValue);
		articles.setSubcategory(subCategoryValue);
		articles.setArticleContent(descriptionValue);
		articles.setImageArticle(imageValue);
		String colorCode = getColorCodeBySubCategory(subCategoryValue);
		articles.setArticleColor(colorCode);
		String categoryColorCode = getColorCodeByCategory(categoryValue);
		articles.setCategoryColor(categoryColorCode);
		String categoryColorImage = getColorImageByCategory(categoryValue);
		articles.setCategoryColorImage(categoryColorImage);
		
		if(subCategoryValue.equalsIgnoreCase("ID Your Scenario") || subCategoryValue.equalsIgnoreCase("Monitor Evaluate") || subCategoryValue.equalsIgnoreCase("Innovations")){
			articles.setArticleFontColor("#000000");
		}

		model.addAttribute("article", articles);
		
		
		//=====================================================================================================
		
		DynamicQuery journalFolderQuery = DynamicQueryFactoryUtil.forClass(JournalFolder.class, PortletClassLoaderUtil.getClassLoader());
		journalFolderQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("companyId").eq(new Long(themeDisplay.getCompanyId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("name").eq("C4D"));
		journalFolder = JournalFolderLocalServiceUtil.dynamicQuery(journalFolderQuery);

		DynamicQuery journalArticleQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, PortletClassLoaderUtil.getClassLoader());
		journalArticleQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("folderId").eq(new Long(journalFolder.get(0).getFolderId())));
		journalArticleQuery.addOrder(OrderFactoryUtil.asc("resourcePrimKey"));
		journalArticles = JournalArticleLocalServiceUtil.dynamicQuery(journalArticleQuery);
		
		List<C4DArticles> c4dArticlesList = new ArrayList<C4DArticles>();
		
		int i=0;
		for (JournalArticle article : journalArticles) {
			double latestArticleVersion = JournalArticleLocalServiceUtil.getLatestVersion(themeDisplay.getScopeGroupId(), article.getArticleId());
			if(latestArticleVersion == article.getVersion()){
				
				ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(article,themeDisplay);
				articles = new C4DArticles();

				Document relatedDocument = SAXReaderUtil.read(article.getContentByLocale("en_US"));
				Node relatedTitleNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
				String relatedTitleValue = relatedTitleNode.getText();
				Node relatedCategoryNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
				String relatedCategoryValue = relatedCategoryNode.getText();
				Node relatedSubCategoryNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Sub-Category" +"']/dynamic-content");
				String relatedSubCategoryValue = relatedSubCategoryNode.getText();
				Node relatedDescriptionNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Description" +"']/dynamic-content");
				String relatedDescriptionValue = relatedDescriptionNode.getText();
				Node relatedImageNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "imageArticle" +"']/dynamic-content");
				String relatedImageValue = relatedImageNode.getText();

				// the articleId and articleURLTitle are used in the c4dDetailsView for the previous and next links at the bottom
				articles.setArticleId(article.getId());
				if(Validator.isNotNull(expandoValue)){
					articles.setAricleURLTitle(expandoValue.getData());
				}

				if(subCategoryValue.equalsIgnoreCase(relatedSubCategoryValue) && article.getId() != articleId){
					
					articles.setTitle(relatedTitleValue);
					articles.setCategory(relatedCategoryValue);
					articles.setSubcategory(relatedSubCategoryValue);
					articles.setImageArticle(relatedImageValue);

					if(relatedSubCategoryValue.equalsIgnoreCase("Behavioural Goal")){
						articles.setArticleColor("#5F7B05");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Using Evidence")){
						articles.setArticleColor("#8DA900");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("ID High Risk Groups")){
						articles.setArticleColor("#B3D438");
					}
					
					if(relatedSubCategoryValue.equalsIgnoreCase("Segmentation")){
						articles.setArticleColor("#072F77");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Barriers")){
						articles.setArticleColor("#0735AC");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Messaging")){
						articles.setArticleColor("#2076DB");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Channel Analysis")){
						articles.setArticleColor("#5AB0F1");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("ID Your Scenario")){
						articles.setArticleColor("#B3E1FF");
						articles.setArticleFontColor("#000000");
					}
					
					if(relatedSubCategoryValue.equalsIgnoreCase("Monitor Evaluate")){
						articles.setArticleColor("#C4F1C4");
						articles.setArticleFontColor("#000000");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Integrated Action")){
						articles.setArticleColor("#008953");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("The Global Strategy")){
						articles.setArticleColor("#06583D");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Capacity Building")){
						articles.setArticleColor("#45BE70");
					}
					
					if(relatedSubCategoryValue.equalsIgnoreCase("Mass Media IEC")){
						articles.setArticleColor("#1C6682");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Training")){
						articles.setArticleColor("#009DA4");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Management Tools")){
						articles.setArticleColor("#1DBEBE");
					}
					if(relatedSubCategoryValue.equalsIgnoreCase("Innovations")){
						articles.setArticleColor("#AEF1DF");
						articles.setArticleFontColor("#000000");
					}
					if(i<3){
						c4dArticlesList.add(articles);
						i++;
					}
					
				}
			}
		}
		model.addAttribute("c4dArticlesList", c4dArticlesList);
		return "c4dDetailView";
	}
	
	// generic methods to get color--
	
	private String getColorCodeBySubCategory(String subCategoryValue) {
			String colorCode = "";
			if(subCategoryValue.equalsIgnoreCase("Behavioural Goal")){
				colorCode = "#5F7B05";
				
			}
			if(subCategoryValue.equalsIgnoreCase("Using Evidence")){
				colorCode = "#8DA900";
			}
			if(subCategoryValue.equalsIgnoreCase("ID High Risk Groups")){
				colorCode = "#B3D438";
			}
			
			if(subCategoryValue.equalsIgnoreCase("Segmentation")){
				colorCode = "#072F77";
			}
			if(subCategoryValue.equalsIgnoreCase("Barriers")){
				colorCode = "#0735AC";
			}
			if(subCategoryValue.equalsIgnoreCase("Messaging")){
				colorCode = "#2076DB";
			}
			if(subCategoryValue.equalsIgnoreCase("Channel Analysis")){
				colorCode = "#5AB0F1";
			}
			if(subCategoryValue.equalsIgnoreCase("ID Your Scenario")){
				colorCode = "#B3E1FF";
			}
			
			if(subCategoryValue.equalsIgnoreCase("Monitor Evaluate")){
				colorCode = "#C4F1C4";
			}
			if(subCategoryValue.equalsIgnoreCase("Integrated Action")){
				colorCode = "#008953";
			}
			if(subCategoryValue.equalsIgnoreCase("The Global Strategy")){
				colorCode = "#06583D";
			}
			if(subCategoryValue.equalsIgnoreCase("Capacity Building")){
				colorCode = "#45BE70";
			}
			
			if(subCategoryValue.equalsIgnoreCase("Mass Media IEC")){
				colorCode = "#1C6682";
			}
			if(subCategoryValue.equalsIgnoreCase("Training")){
				colorCode = "#009DA4";
			}
			if(subCategoryValue.equalsIgnoreCase("Management Tools")){
				colorCode = "#1DBEBE";
			}
			if(subCategoryValue.equalsIgnoreCase("Innovations")){
				colorCode = "#AEF1DF";
			}		
		
		return colorCode;
	}
	
	private String getColorCodeByCategory(String categoryValue) {
		String colorCode = "";
		if(categoryValue.equalsIgnoreCase("Understand")){
			colorCode = "#8DA900";			
		}
		if(categoryValue.equalsIgnoreCase("Plan")){
			colorCode = "#3A61C9";
		}
		if(categoryValue.equalsIgnoreCase("Act")){
			colorCode = "#008A54";
		}
		if(categoryValue.equalsIgnoreCase("Tools")){
			colorCode = "#33B0B7";
		}
		return colorCode;
	}
	
	private String getColorImageByCategory(String categoryValue) {
		String imageName = "";
		if(categoryValue.equalsIgnoreCase("Understand")){
			imageName = "down-aero-understand.png";			
		}
		if(categoryValue.equalsIgnoreCase("Plan")){
			imageName = "down-aero-plan.png";
		}
		if(categoryValue.equalsIgnoreCase("Act")){
			imageName = "down-aero-act.png";
		}
		if(categoryValue.equalsIgnoreCase("Tools")){
			imageName = "down-aero-tools.png";
		}
		return imageName;
	}
	
	@ResourceMapping(value="addToCheckListC4D")
	public void addToCheckListC4D(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model) throws SystemException, PortalException, DocumentException, IOException{
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(request, "articleId");
		
		C4DCheckList c4dCheckList = c4dCheckListService.checkC4DMyCheckListExist(articleId, themeDisplay.getUserId());
		
		if(Validator.isNull(c4dCheckList)){
			
			// if data not exist then add the data
			c4dCheckList = new C4DCheckList();
			c4dCheckList.setChecked(false);
			c4dCheckList.setCompanyId(themeDisplay.getCompanyId());
			c4dCheckList.setCreatedDate(new Date());
			c4dCheckList.setGroupId(themeDisplay.getCompanyGroupId());
			c4dCheckList.setModifiedDate(new Date());
			c4dCheckList.setC4dArticleId(articleId);
			c4dCheckList.setUserId(themeDisplay.getUserId());
			c4dCheckListService.create(c4dCheckList);
		}else{
			c4dCheckListService.delete(c4dCheckList.getC4dCheckListId());
		}
	}
	
	private static Log _log = LogFactoryUtil.getLog(
			C4DLandingController.class);
}
