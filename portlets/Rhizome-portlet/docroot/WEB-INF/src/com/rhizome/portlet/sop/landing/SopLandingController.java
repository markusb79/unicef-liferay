package com.rhizome.portlet.sop.landing;

import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.OrderFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.dao.orm.ProjectionFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
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
import com.liferay.portal.kernel.util.CookieKeys;
import com.rhizome.domain.ReferenceLinks;
import com.rhizome.domain.SOPArticles;
import com.rhizome.domain.SOPCheckList;
import com.rhizome.domain.TemplateLinks;
import com.rhizome.service.SOPCheckListService;
import com.rhizome.util.MessageUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

@Controller
@RequestMapping("VIEW")
public class SopLandingController {
	
	private static final String SOP_RESPONSE = "sop_response";
	private static final String VIEW = "view";
	private static final String SOP_DETAIL_VIEW = "sopDetailView";
	private static final String MENU_VIEW = "menuView";
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private SOPCheckListService sopCheckListService;
	
	private static final Log log = LogFactoryUtil.getLog(SopLandingController.class);
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,RenderResponse renderResponse) throws PortalException, SystemException, DocumentException{
		// using the tiles page as the SOP landing page for now:
		return viewSOPLandingMenu(locale, renderRequest, renderResponse, model);
	}

	@ResourceMapping(value="viewSOPLandingControllerScroll")
	public String viewSOPLandingControllerScroll(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model) throws SystemException, PortalException, DocumentException, IOException{
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		int sopScrollCountVal = ParamUtil.getInteger(request,"sopScrollCountVal");
		
		String time24Hours = ParamUtil.getString(request, "time24Hours").replaceAll("_", " ");
		String time72Hours = ParamUtil.getString(request, "time72Hours").replaceAll("_", " ");
		String time14Days = ParamUtil.getString(request, "time14Days").replaceAll("_", " ");
		String time15Days = ParamUtil.getString(request, "time15Days").replaceAll("_", " ");
		
		String catOB = ParamUtil.getString(request, "catOB").replaceAll("_", " ");
		String catCoAd = ParamUtil.getString(request, "catCoAd").replaceAll("_", " ");
		String catTechHR = ParamUtil.getString(request, "catTechHR").replaceAll("_", " ");
		String catInfoMg = ParamUtil.getString(request, "catInfoMg").replaceAll("_", " ");
		String catExtCom = ParamUtil.getString(request, "catExtCom").replaceAll("_", " ");
		String catFnLg = ParamUtil.getString(request, "catFnLg").replaceAll("_", " ");
		String catContext = ParamUtil.getString(request, "catContext").replaceAll("_", " ");
		
		String resCountry = ParamUtil.getString(request, "resCountry").replaceAll("_", " ");
		String resUnicef = ParamUtil.getString(request, "resUnicef").replaceAll("_", " ");
		String resWho = ParamUtil.getString(request, "resWho").replaceAll("_", " ");
		String resRpdRes = ParamUtil.getString(request, "resRpdRes").replaceAll("_", " ");
		String resSrgTeam = ParamUtil.getString(request, "resSrgTeam").replaceAll("_", " ");
		
		List<SOPArticles> sopArticlesList = new ArrayList<SOPArticles>();
		sopArticlesList = getSopTileResponse(model, time24Hours, time72Hours, time14Days, time15Days, catOB, catCoAd, catTechHR, catInfoMg, catExtCom, catFnLg, catContext, resCountry, resUnicef, resWho, resRpdRes, resSrgTeam, themeDisplay);
		
		/** List of Categories **/
		List<String> categories = new ArrayList<String>();
		List<SOPArticles> viewopArticles = new ArrayList<SOPArticles>();
		
		int i=0;
		for(SOPArticles randomSOPArticles : sopArticlesList){
			if(i>=(sopScrollCountVal*15) && i<=((sopScrollCountVal+1)*15-1)){
				viewopArticles.add(sopArticlesList.get(i));
			}
			i++;
		}
		
		List<SOPArticles> sopFilterAllArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sopFilterChckListedArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sopFilterNotChckListedArticles = new ArrayList<SOPArticles>();
		
		if(Validator.isNotNull(themeDisplay.getUserId())){
			int k=0;
			for(SOPArticles randomSOPArticles : sopArticlesList){
				if(k>=0 && k<=((sopScrollCountVal+1)*15-1)){
					boolean flag = sopCheckListService.checkSOPMyCheckListExistList(randomSOPArticles.getId(), themeDisplay.getUserId());
					if(flag){
						sopFilterChckListedArticles.add(sopArticlesList.get(k));
					}else{
						sopFilterNotChckListedArticles.add(sopArticlesList.get(k));
					}
				}
				k++;
			}
		}
		
		sopFilterAllArticles.addAll(sopFilterNotChckListedArticles);
		sopFilterAllArticles.addAll(sopFilterChckListedArticles);
		model.addAttribute("sopFilterAllArticlesList", sopFilterAllArticles);
		
		model.addAttribute("sopArticlesList", viewopArticles);
		model.addAttribute("sopArticlesListSize", viewopArticles.size());

		 int sopCountValue = sopScrollCountVal+1;
		 model.addAttribute("sopScrollCount", sopCountValue);
		 
		 /** List of Categories **/
		 model.addAttribute("categories", categories);
		 model.addAttribute("sopCheckListService", sopCheckListService);
		 
		 
	 	model.addAttribute("time24Hours", time24Hours.replaceAll(" ", "_"));
		model.addAttribute("time72Hours", time72Hours.replaceAll(" ", "_"));
		model.addAttribute("time14Days", time14Days.replaceAll(" ", "_"));
		model.addAttribute("time15Days", time15Days.replaceAll(" ", "_"));
		
		model.addAttribute("catOB", catOB.replaceAll(" ", "_"));
		model.addAttribute("catCoAd", catCoAd.replaceAll(" ", "_"));
		model.addAttribute("catTechHR", catTechHR.replaceAll(" ", "_"));
		model.addAttribute("catInfoMg", catInfoMg.replaceAll(" ", "_"));
		model.addAttribute("catExtCom", catExtCom.replaceAll(" ", "_"));
		model.addAttribute("catFnLg", catFnLg.replaceAll(" ", "_"));
		model.addAttribute("catContext", catContext.replaceAll(" ", "_"));
		
		model.addAttribute("resCountry", resCountry.replaceAll(" ", "_"));
		model.addAttribute("resUnicef", resUnicef.replaceAll(" ", "_"));
		model.addAttribute("resWho", resWho.replaceAll(" ", "_"));
		model.addAttribute("resRpdRes", resRpdRes.replaceAll(" ", "_"));
		model.addAttribute("resSrgTeam", resSrgTeam.replaceAll(" ", "_"));
			
		return SOP_RESPONSE;
	}
	
	@RenderMapping(params = "viewsop")
	public String viewsop(RenderRequest renderRequest,RenderResponse renderResponse, Model model) throws PortalException, SystemException, DocumentException{
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(renderRequest, "articleId", 0);
		
		String viewArticleURL = ParamUtil.getString(renderRequest, "viewArticleURL",StringPool.BLANK);
		ExpandoTable expandoTable = ExpandoTableLocalServiceUtil.getDefaultTable(themeDisplay.getCompanyId(), JournalArticle.class.getName());
		ExpandoColumn column = ExpandoColumnLocalServiceUtil.getColumn(expandoTable.getTableId(), "Article_Title");
		List<ExpandoValue> expandoValueList = new ArrayList<ExpandoValue>();
		expandoValueList = ExpandoValueLocalServiceUtil.getColumnValues(column.getColumnId(), -1, -1);
		for (ExpandoValue expandoValue : expandoValueList) {
			if(expandoValue.getData().equalsIgnoreCase(viewArticleURL)){
				articleId = expandoValue.getClassPK();
			}
		}
		boolean fromSubFilter = false;
		String sopFilterMainCat = ParamUtil.getString(renderRequest, "sopFilterValue");
		String sopSubFilterValue = ParamUtil.getString(renderRequest, "sopSubFilterValue");
		if(Validator.isNotNull(sopSubFilterValue)){
			fromSubFilter = true;
		}
		
		SOPArticles articles = new SOPArticles();
		articles = getSopArticleDetail(model,themeDisplay,articleId, renderRequest);
		
		model.addAttribute("article", articles);
		
		model.addAttribute("sopFilterMainCat", sopFilterMainCat);
		model.addAttribute("fromSubFilter", fromSubFilter);
		model.addAttribute("detailSubCategory",sopSubFilterValue);
		
		return SOP_DETAIL_VIEW;
	}

	@ResourceMapping(value="addAllTilesToCheckList")
	public void addAllTilesToCheckList(ResourceRequest resourceRequest, ResourceResponse resourceResponse, Model model) throws SystemException, PortalException, DocumentException, IOException {
		_log.info("SOPLandingController : adding all tiles to Checklist");

		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		List<SOPArticles> sopArticlesList = new ArrayList<SOPArticles>();
		sopArticlesList = getSopTileResponse(model, "24_HOURS", "72_HOURS", "14_DAYS", "15_DAYS-CLOSE", "Outbreak_Confirmation", "Coordination_And_Advocacy", "Technical_and_Human_Resources", "Information_Management", "Communication", "Finances_and_Logistics", "Context", "country", "unicef", "who", "rapid_response", "surge_team", themeDisplay);
		JSONArray jsonArray = JSONFactoryUtil.createJSONArray();
		
		for(SOPArticles sopArticles : sopArticlesList) {
			
			SOPCheckList sopCheckList = sopCheckListService.checkSOPMyCheckListExist(sopArticles.getId(), themeDisplay.getUserId());
			
			// validate is null
			if(Validator.isNull(sopCheckList)){
				JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
				
				sopCheckList = new SOPCheckList();
				sopCheckList.setChecked(false);
				sopCheckList.setCompanyId(themeDisplay.getCompanyId());
				sopCheckList.setCreatedDate(new Date());
				sopCheckList.setGroupId(themeDisplay.getCompanyGroupId());
				sopCheckList.setModifiedDate(new Date());
				sopCheckList.setSopArticleId(sopArticles.getId());
				sopCheckList.setUserId(themeDisplay.getUserId());
				sopCheckListService.create(sopCheckList);
				
				jsonObject.put("articleId", sopArticles.getId());
				jsonArray.put(jsonObject);
			}
			
		}
		
		PrintWriter out=resourceResponse.getWriter();
		out.print(jsonArray.toString());
		
	}
	
	@ResourceMapping(value="addToCheckList")
	public void addToCheckList(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model) throws SystemException, PortalException, DocumentException, IOException{
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(request, "articleId");
		
		// get articleid and user id and check if exist or not
		SOPCheckList sopCheckList = sopCheckListService.checkSOPMyCheckListExist(articleId, themeDisplay.getUserId());
		if(Validator.isNull(sopCheckList)){
			// if data not exist then add the data
			sopCheckList = new SOPCheckList();
			sopCheckList.setChecked(false);
			sopCheckList.setCompanyId(themeDisplay.getCompanyId());
			sopCheckList.setCreatedDate(new Date());
			sopCheckList.setGroupId(themeDisplay.getCompanyGroupId());
			sopCheckList.setModifiedDate(new Date());
			sopCheckList.setSopArticleId(articleId);
			sopCheckList.setUserId(themeDisplay.getUserId());
			sopCheckListService.create(sopCheckList);
		}else{
			sopCheckListService.delete(sopCheckList.getSopCheckListId());
		}
	}
	
	@RenderMapping(params = "view=viewSOPLandingMenu")
	public String viewSOPLandingMenu(Locale locale,RenderRequest renderRequest,RenderResponse renderResponse, Model model) throws PortalException, SystemException, DocumentException{
		
		defaultMenu(locale, model);
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
		
		String time24Hours = ParamUtil.getString(request, "time24");
		String time72Hours = ParamUtil.getString(request, "time72");
		String time14Days = ParamUtil.getString(request, "time14");
		String time15Days = ParamUtil.getString(request, "time15");
		
		String catOB = ParamUtil.getString(request, "catOB");
		String catCoAd = ParamUtil.getString(request, "catCoAd");
		String catTechHR = ParamUtil.getString(request, "catTechHR");
		String catInfoMg = ParamUtil.getString(request, "catInfoMg");
		String catExtCom = ParamUtil.getString(request, "catExtCom");
		String catFnLg = ParamUtil.getString(request, "catFnLg");
		String catContext = ParamUtil.getString(request, "catContext");
		
		String resCountry = ParamUtil.getString(request, "resCountry");
		String resUnicef = ParamUtil.getString(request, "resUnicef");
		String resWho = ParamUtil.getString(request, "resWho");
		String resRpdRes = ParamUtil.getString(request, "resRpdRes");
		String resSrgTeam = ParamUtil.getString(request, "resSrgTeam");
		
		model.addAttribute("time24Hours", time24Hours);
		model.addAttribute("time72Hours", time72Hours);
		model.addAttribute("time14Days", time14Days);
		model.addAttribute("time15Days", time15Days);
		
		model.addAttribute("catOB", catOB);
		model.addAttribute("catCoAd", catCoAd);
		model.addAttribute("catTechHR", catTechHR);
		model.addAttribute("catInfoMg", catInfoMg);
		model.addAttribute("catExtCom", catExtCom);
		model.addAttribute("catFnLg", catFnLg);
		model.addAttribute("catContext", catContext);
		
		model.addAttribute("resCountry", resCountry);
		model.addAttribute("resUnicef", resUnicef);
		model.addAttribute("resWho", resWho);
		model.addAttribute("resRpdRes", resRpdRes);
		model.addAttribute("resSrgTeam", resSrgTeam);
		
		List<SOPArticles> sopArticlesList = new ArrayList<SOPArticles>();
		sopArticlesList = getSopTileResponse(model, time24Hours, time72Hours, time14Days, time15Days, catOB, catCoAd, catTechHR, catInfoMg, catExtCom, catFnLg, catContext, resCountry, resUnicef, resWho, resRpdRes, resSrgTeam, themeDisplay);
		//if(sopArticlesList.size()>0){
			return VIEW;
		/*}else{
			model.addAttribute("noResults", "noResults");
			return MENU_VIEW;
		}*/
	}
	
	public void defaultMenu(Locale locale,Model model){
		/** List of Categories Filters**/
		LinkedHashMap<String, String> categoriesSubCategories  = new LinkedHashMap<String, String>();
		categoriesSubCategories.put(MessageUtil.get("outbreak-confirmation","OUTBREAK CONFIRMATION",locale), "OUTBREAK_CONFIRMATION");
		categoriesSubCategories.put(MessageUtil.get("coordination-and-advocacy", "Coordination and Advocacy",locale),  "COORDINATION_AND_ADVOCACY");
		categoriesSubCategories.put(MessageUtil.get("technical-and-human-resources", "Technical and Human Resources",locale),  "TECHNICAL_AND_HUMAN_RESOURCES");
		categoriesSubCategories.put(MessageUtil.get("information-management", "INFORMATION MANAGEMENT",locale),  "INFORMATION_MANAGEMENT");
		categoriesSubCategories.put(MessageUtil.get("external-communication", "EXTERNAL COMMUNICATION", locale),  "EXTERNAL_COMMUNICATION");
		categoriesSubCategories.put(MessageUtil.get("finance-and-logistics", "Finances and Logistics", locale),  "FINANCES_AND_LOGISTICS");
		categoriesSubCategories.put(MessageUtil.get("context", "CONTEXT", locale), "CONTEXT");
		model.addAttribute("categoriesSubCategories", categoriesSubCategories);
		model.addAttribute("filterCategory", "category");
		
		/** List of Time Filters**/
		LinkedHashMap<String, String> timeSubCategories  = new LinkedHashMap<String, String>();
		timeSubCategories.put(MessageUtil.get("24-hours", "24 HOURS", locale), "24_HOURS");
		timeSubCategories.put(MessageUtil.get("72-hours", "72 HOURS", locale), "72_HOURS");
		timeSubCategories.put(MessageUtil.get("14-days", "14 DAYS", locale) , "14_DAYS");
		timeSubCategories.put(MessageUtil.get("15-close", "15 DAYS-CLOSE", locale) , "15_DAYS-CLOSE");
		model.addAttribute("timeSubCategories", timeSubCategories);
		model.addAttribute("filterTime", "time");
		
		/** List of Responsibility Filters**/
		LinkedHashMap<String, String> responsibilitySubCategories  = new LinkedHashMap<String, String>();
		responsibilitySubCategories.put(MessageUtil.get("country", "COUNTRY", locale), "COUNTRY");
		responsibilitySubCategories.put(MessageUtil.get("unicef", "UNICEF", locale), "UNICEF");
		responsibilitySubCategories.put(MessageUtil.get("who", "WHO", locale), "WHO");
		responsibilitySubCategories.put(MessageUtil.get("rapid-response", "RAPID RESPONSE", locale), "RAPID_RESPONSE");
		responsibilitySubCategories.put(MessageUtil.get("surge-team", "SURGE TEAM", locale), "SURGE_TEAM");
		responsibilitySubCategories.put(MessageUtil.get("entriy-06", "ENTIRY 06", locale), "ENTIRY_06");
		responsibilitySubCategories.put(MessageUtil.get("entriy-07", "ENTIRY 07", locale), "ENTIRY_07");
		model.addAttribute("responsibilitySubCategories", responsibilitySubCategories);
		model.addAttribute("filterResponsibility", "responsibility");
		
		/** List of Filters **/
		LinkedHashMap<String, String> filters = new LinkedHashMap<String, String>();
		filters.put(MessageUtil.get("time", "TIME", locale), "time");
		filters.put(MessageUtil.get("category", "CATEGORY", locale), "category");
		filters.put(MessageUtil.get("responsibility", "RESPONSIBILITY", locale), "responsibility");
		
		model.addAttribute("outbreakTitle", "Outbreak Confirmation and Grading");
		model.addAttribute("externalCommTitle", "External communication, social mobilization and behaviour change communication");
		model.addAttribute("filters", filters);
	}
	
	@RenderMapping(params = "view=viewSOPArticle")
	public String viewSOPArticle(RenderRequest renderRequest,RenderResponse renderResponse, Model model) throws PortalException, SystemException, DocumentException{
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(renderRequest, "articleId", 0);
		
		boolean fromSubFilter = false;
		String sopFilterMainCat = ParamUtil.getString(renderRequest, "sopFilterValue");
		String sopSubFilterValue = ParamUtil.getString(renderRequest, "sopSubFilterValue");
		if(Validator.isNotNull(sopSubFilterValue)){
			fromSubFilter = true;
		}
		SOPArticles articles = new SOPArticles();
		articles = getSopArticleDetail(model,themeDisplay,articleId,renderRequest);
		
		model.addAttribute("article", articles);
		
		model.addAttribute("sopFilterMainCat", sopFilterMainCat);
		model.addAttribute("fromSubFilter", fromSubFilter);
		model.addAttribute("detailSubCategory",sopSubFilterValue);
		return SOP_DETAIL_VIEW;
	}

	/**
	 * Returns a filtered list of SOP tiles / articles for the SOP landing page.
	 */
	public List<SOPArticles> getSopTileResponse(Model model, String time24Hours,String time72Hours,String time14Days,String time15Days, String catOB,String catCoAd,
	  String catTechHR, String catInfoMg, String catExtCom,	String catFnLg, String catContext, String resCountry, String resUnicef, 
	  String resWho, String resRpdRes, String resSrgTeam, ThemeDisplay themeDisplay) throws SystemException, PortalException, DocumentException{

		time24Hours = time24Hours.replaceAll("_", " ");
		time72Hours = time72Hours.replaceAll("_", " ");
		time14Days = time14Days.replaceAll("_", " ");
		time15Days = time15Days.replaceAll("_", " ");
		
		catOB = catOB.replaceAll("_", " ");
		catCoAd = catCoAd.replaceAll("_", " ");
		catTechHR = catTechHR.replaceAll("_", " ");
		catInfoMg = catInfoMg.replaceAll("_", " ");
		catExtCom = catExtCom.replaceAll("_", " ");
	    catFnLg = catFnLg.replaceAll("_", " ");
	    catContext = catContext.replaceAll("_", " ");
		
		resCountry = resCountry.replaceAll("_", " ");
	    resUnicef = resUnicef.replaceAll("_", " ");
		resWho = resWho.replaceAll("_", " ");
		resRpdRes = resWho.replaceAll("_", " ");
		resSrgTeam = resSrgTeam.replaceAll("_", " ");
		
		String time="";
		if(Validator.isNotNull(time24Hours) || Validator.isNotNull(time72Hours) || Validator.isNotNull(time14Days) || Validator.isNotNull(time15Days)){
			time = "time";
		}

		String category="";
		if(Validator.isNotNull(catOB) || Validator.isNotNull(catCoAd) || Validator.isNotNull(catTechHR) || Validator.isNotNull(catInfoMg) || Validator.isNotNull(catExtCom)
				|| Validator.isNotNull(catFnLg) || Validator.isNotNull(catContext)){
			category = "category";
		}

		String response="";
		if(Validator.isNotNull(resCountry) || Validator.isNotNull(resUnicef) || Validator.isNotNull(resWho) || Validator.isNotNull(resRpdRes)
				|| Validator.isNotNull(resSrgTeam)){
			response = "response";
		}

		List<JournalFolder> journalFolder = new ArrayList<JournalFolder>();
		List<JournalArticle> journalArticles = new ArrayList<JournalArticle>();
		List<SOPArticles> sopArticlesList = new ArrayList<SOPArticles>();
		SOPArticles articles = new SOPArticles();
		
		/** ---- LIST OF TIME ---- **/
		// Different lists are populated for each time frame and combined at the end, because alphabetical sorting by time
		// frame is not easily possible due to hours/days suffix
		List<SOPArticles> sop24HoursArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop72HoursArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop14DaysArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop15DaysCloseArticles = new ArrayList<SOPArticles>();
				
		DynamicQuery journalFolderQuery = DynamicQueryFactoryUtil.forClass(JournalFolder.class, PortletClassLoaderUtil.getClassLoader());
		journalFolderQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("companyId").eq(new Long(themeDisplay.getCompanyId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("name").eq("SOP"));
		journalFolder = JournalFolderLocalServiceUtil.dynamicQuery(journalFolderQuery);

		DynamicQuery maxVersionQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, "maxVersion", PortletClassLoaderUtil.getClassLoader());
		maxVersionQuery.setProjection(ProjectionFactoryUtil.max("maxVersion.version"));
		maxVersionQuery.add(PropertyFactoryUtil.forName("maxVersion.groupId").eqProperty("article.groupId"));
		maxVersionQuery.add(PropertyFactoryUtil.forName("maxVersion.articleId").eqProperty("article.articleId"));

		DynamicQuery journalArticleQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, "article", PortletClassLoaderUtil.getClassLoader());
		journalArticleQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("folderId").eq(new Long(journalFolder.get(0).getFolderId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("version").eq(maxVersionQuery));
		journalArticleQuery.addOrder(OrderFactoryUtil.asc("title"));
		journalArticles = JournalArticleLocalServiceUtil.dynamicQuery(journalArticleQuery);

		for (JournalArticle article : journalArticles) {
			try {
				articles = new SOPArticles();

				ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(article,themeDisplay);

				Document document = SAXReaderUtil.read(article.getContentByLocale("en_US"));
				Node timeNode = document.selectSingleNode("/root/dynamic-element[@name='" + "TIME" +"']/dynamic-content");
				String timeValue = timeNode == null ? "" : timeNode.getText();
				Node categoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
				String categoryValue = categoryNode.getText();
				Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
				String titleValue = titleNode.getText();
				Node responsibleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Responsible" +"']/dynamic-content");
				String responsibleValue = responsibleNode.getText();
				Node imageNode = document.selectSingleNode("/root/dynamic-element[@name='" + "ArticleImage" +"']/dynamic-content");
				String imageValue = imageNode.getText();
				
				if(timeValue.equalsIgnoreCase("Immediately") || timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("14 Days to Close")
						|| timeValue.equalsIgnoreCase("3 Months")){
					articles.setTime("15 DAYS-CLOSE");
					articles.setFontColor("#000000");
				}else{
					articles.setTime(timeValue);
				}
				articles.setCategory(categoryValue);
				articles.setTitle(titleValue);
				articles.setImageArticle(imageValue);
				articles.setId(article.getId());
				String setArticleColor = SopLandingUtil.setArticleColorByTimeValue(timeValue);
				articles.setArticleColor(setArticleColor);
				
				if(Validator.isNotNull(expandoValue)){
					articles.setAricleURLTitle(expandoValue.getData());
				}

				filterSopArticles(sop24HoursArticles, sop72HoursArticles, sop14DaysArticles, sop15DaysCloseArticles,
						articles, timeValue, categoryValue, responsibleValue, time, category, response,
						time24Hours, time72Hours, time14Days, time15Days, catOB, catCoAd,
						catTechHR, catInfoMg, catExtCom, catFnLg, catContext, resCountry, resUnicef,
						resWho, resRpdRes, resSrgTeam);
			} catch(Exception e) {
				_log.error("-- sop content not found ------------------------------||| " + e.getMessage() );
			}
		}
		
		sopArticlesList.addAll(sop24HoursArticles);
		sopArticlesList.addAll(sop72HoursArticles);
		sopArticlesList.addAll(sop14DaysArticles);
		sopArticlesList.addAll(sop15DaysCloseArticles);
		
		return sopArticlesList;
	}

	/**
	 * Filters the
	 */
	protected void filterSopArticles(List<SOPArticles> sop24HoursArticles, List<SOPArticles> sop72HoursArticles, List<SOPArticles> sop14DaysArticles, List<SOPArticles> sop15DaysCloseArticles,
	                                 SOPArticles articles, String timeValue, String categoryValue, String responsibleValue, String time, String category, String response,
	                                 String time24Hours,String time72Hours,String time14Days,String time15Days, String catOB,String catCoAd,
	                                 String catTechHR, String catInfoMg, String catExtCom,	String catFnLg, String catContext, String resCountry, String resUnicef,
	                                 String resWho, String resRpdRes, String resSrgTeam) {

		if(Validator.isNotNull(time) && Validator.isNotNull(category) && Validator.isNotNull(response)) {

			/**  ALL 3 COLUMNS SELECTED **/
			if((timeValue.equalsIgnoreCase(time24Hours) || timeValue.equalsIgnoreCase(time72Hours) || timeValue.equalsIgnoreCase(time14Days) || articles.getTime().equalsIgnoreCase(time15Days))
					&& (categoryValue.equalsIgnoreCase(catOB) || categoryValue.equalsIgnoreCase(catCoAd) || categoryValue.equalsIgnoreCase(catTechHR) || categoryValue.equalsIgnoreCase(catInfoMg) || categoryValue.equalsIgnoreCase(catExtCom) || categoryValue.equalsIgnoreCase(catFnLg) || categoryValue.equalsIgnoreCase(catContext))
					&& ((responsibleValue.toLowerCase().contains(resCountry) && !resCountry.isEmpty()) || (responsibleValue.toLowerCase().contains(resUnicef) && !resUnicef.isEmpty()) || (responsibleValue.toLowerCase().contains(resWho) && !resWho.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resRpdRes) && !resRpdRes.isEmpty()) || (responsibleValue.toLowerCase().contains(resSrgTeam) && !resSrgTeam.isEmpty()))) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNotNull(time) && Validator.isNull(category) && Validator.isNull(response)){

			/** ONLY TIME COLUMNS SELECTED **/

			if(timeValue.equalsIgnoreCase(time24Hours) || timeValue.equalsIgnoreCase(time72Hours) || timeValue.equalsIgnoreCase(time14Days) || articles.getTime().equalsIgnoreCase(time15Days)) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNull(time) && Validator.isNotNull(category) && Validator.isNull(response)) {

			/** ONLY CATEGORY SELECTED **/
			if(categoryValue.equalsIgnoreCase(catOB) || categoryValue.equalsIgnoreCase(catCoAd) || categoryValue.equalsIgnoreCase(catTechHR) || categoryValue.equalsIgnoreCase(catInfoMg) ||
					categoryValue.equalsIgnoreCase(catExtCom) || categoryValue.equalsIgnoreCase(catFnLg) || categoryValue.equalsIgnoreCase(catContext)) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNull(time) && Validator.isNull(category) && Validator.isNotNull(response)){

			/** ONLY RESPONSE SELECTED **/
			if((responsibleValue.toLowerCase().trim().contains(resCountry) && !resCountry.isEmpty()) || (responsibleValue.toLowerCase().trim().contains(resUnicef) && !resUnicef.isEmpty()) || (responsibleValue.toLowerCase().contains(resWho) && !resWho.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resRpdRes) && !resRpdRes.isEmpty())  || (responsibleValue.toLowerCase().contains(resSrgTeam) && !resSrgTeam.isEmpty())) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNotNull(time) && Validator.isNotNull(category) && Validator.isNull(response)){

			/** TIME AND CATEGORY COLUMNS ARE SELECTED **/
			if((timeValue.equalsIgnoreCase(time24Hours) || timeValue.equalsIgnoreCase(time72Hours) || timeValue.equalsIgnoreCase(time14Days) || articles.getTime().equalsIgnoreCase(time15Days))
					&& (categoryValue.equalsIgnoreCase(catOB) || categoryValue.equalsIgnoreCase(catCoAd) || categoryValue.equalsIgnoreCase(catTechHR) || categoryValue.equalsIgnoreCase(catInfoMg)
					|| categoryValue.equalsIgnoreCase(catExtCom) || categoryValue.equalsIgnoreCase(catFnLg) || categoryValue.equalsIgnoreCase(catContext))) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNotNull(time) && Validator.isNull(category) && Validator.isNotNull(response)){

			/** TIME AND RESPONSE COLUMNS ARE SELECTED **/
			if((timeValue.equalsIgnoreCase(time24Hours) || timeValue.equalsIgnoreCase(time72Hours) || timeValue.equalsIgnoreCase(time14Days) || articles.getTime().equalsIgnoreCase(time15Days))
					&& ((responsibleValue.toLowerCase().contains(resCountry) && !resCountry.isEmpty()) || (responsibleValue.toLowerCase().contains(resUnicef) && !resUnicef.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resWho) && !resWho.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resRpdRes) && !resRpdRes.isEmpty()) || (responsibleValue.toLowerCase().contains(resSrgTeam) && !resSrgTeam.isEmpty()))) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNull(time) && Validator.isNotNull(category) && Validator.isNotNull(response)){

			/** CATEGORY AND RESPONSE COLUMNS ARE SELECTED **/
			if((categoryValue.equalsIgnoreCase(catOB) || categoryValue.equalsIgnoreCase(catCoAd) || categoryValue.equalsIgnoreCase(catTechHR) || categoryValue.equalsIgnoreCase(catInfoMg)
					|| categoryValue.equalsIgnoreCase(catExtCom) || categoryValue.equalsIgnoreCase(catFnLg) || categoryValue.equalsIgnoreCase(catContext))
					&& ((responsibleValue.toLowerCase().contains(resCountry) && !resCountry.isEmpty()) || (responsibleValue.toLowerCase().contains(resUnicef) && !resUnicef.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resWho) && !resWho.isEmpty())
					|| (responsibleValue.toLowerCase().contains(resRpdRes) && !resRpdRes.isEmpty()) || (responsibleValue.toLowerCase().contains(resSrgTeam) && !resSrgTeam.isEmpty()))) {

				if(timeValue.equalsIgnoreCase("24 Hours")){
					sop24HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("72 Hours")){
					sop72HoursArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("14 Days")){
					sop14DaysArticles.add(articles);
				}
				if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
						|| timeValue.equalsIgnoreCase("14 Days to Close")){
					sop15DaysCloseArticles.add(articles);
				}

				//j++;
			}
		}

		if(Validator.isNull(time) && Validator.isNull(category) && Validator.isNull(response)) {
			/** NOTHING IS SELECTED **/

			if(timeValue.equalsIgnoreCase("24 Hours")){
				sop24HoursArticles.add(articles);
			}
			if(timeValue.equalsIgnoreCase("72 Hours")){
				sop72HoursArticles.add(articles);
			}
			if(timeValue.equalsIgnoreCase("14 Days")){
				sop14DaysArticles.add(articles);
			}
			if(timeValue.equalsIgnoreCase("3 Weeks") || timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")
					|| timeValue.equalsIgnoreCase("14 Days to Close")){
				sop15DaysCloseArticles.add(articles);
			}

			//j++;
		}

	}

	public SOPArticles getSopArticleDetail(Model model, ThemeDisplay themeDisplay ,long articleId, RenderRequest renderRequest) throws SystemException, PortalException, DocumentException{
		
		JournalArticle journalArticle = JournalArticleLocalServiceUtil.getArticle(articleId);
		SOPArticles articles = new SOPArticles();
		Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));

		Node timeNode = document.selectSingleNode("/root/dynamic-element[@name='" + "TIME" +"']/dynamic-content");
		String timeValue = timeNode.getText();
		Node categoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
		String categoryValue = categoryNode.getText();
		Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
		String titleValue = titleNode.getText();
		Node responsibleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Responsible" +"']/dynamic-content");
		String responsibleValue = responsibleNode.getText();
		Node supportNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Support" +"']/dynamic-content");
		String supportValue = supportNode.getText();
		Node imageNode = document.selectSingleNode("/root/dynamic-element[@name='" + "ArticleImage" +"']/dynamic-content");
		String imageValue = imageNode.getText();
		Node articleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Article" +"']/dynamic-content");
		String articleValue = articleNode.getText();
		Node videoNode = document.selectSingleNode("/root/dynamic-element[@name='" + "VideoURL" +"']/dynamic-content");
		String videoValue = "";
		String videoURL = StringPool.BLANK;
		if(Validator.isNotNull(videoNode)){
		   videoValue = videoNode.getText();
		   log.info("==========VV1 ====== Video ===== " + videoValue);
		   if(Validator.isNotNull(videoValue) && videoValue.contains("vimeo")){
			   log.info("==========Inside if ===== " + videoValue);
			   String[] videoURLValue = videoValue.split("/");
			   if(videoURLValue.length > 1){
				   videoURL = "https://player.vimeo.com/video/"+videoURLValue[5]+"?autoplay=false&amp;loop=false&amp;byline=false&amp;portrait=false&amp;title=false?autoplay=1";
				   articles.setArticleVideo(videoURL);
				   articles.setArticleThumbnail(videoURLValue[5]);				   
			   }
		   }else{
			   log.info("==========Inside else===== " + videoValue);
			   String[] thumbnail = videoValue.split("/");
			   if(thumbnail.length > 1){
				   articles.setArticleVideo(videoValue);
				   articles.setArticleThumbnail(thumbnail[4]);	
			   }
			   
		   }
		}
		
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
					//String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "//" + folderId +  "//" + HttpUtil.encodeURL(HtmlUtil.unescape(title));
					templateFileEntryURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/"
							+ themeDisplay.getScopeGroupId()+ "/" + fileEntry.getFolderId() + "/" + fileEntry.getTitle().replace(" ", "+").toLowerCase();
					log.info("DOWNLOAD URL ===================================== " + templateFileEntryURL);
					//http://69.28.84.217:8080/documents/10184/17321/Somalia+Social+Data+Form/1822e5f1-efa0-420a-ae76-727a9608cdd7
					templateLinks.setTemplateUrl(templateFileEntryURL);
					String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
					templateLinks.setTemplateName(fileName);
					templateLinkList.add(templateLinks);
				}
			}
			catch (Exception e) {
				_log.error("Exception caught while processing Template entries in SopLandingController.getSopArticleDetail(): " + e.getMessage(), e );
			}
		}
		
		List<ReferenceLinks> referenceLinkList = new ArrayList<ReferenceLinks>();
		ReferenceLinks referenceLinks = null;
		String referenceLinkValue="";
		String referenceFileEntryURL="";
		List<Node> referenceNodes = document.selectNodes("/root/dynamic-element[@name='" + "referenceLinks" +"']/dynamic-content");
		for(Node referenceObj : referenceNodes){
			try {
				referenceLinkValue = referenceObj.getText();
				String[] referenceLinkResult = referenceLinkValue.split("/");
				if(referenceLinkResult.length > 1){
					referenceLinks = new ReferenceLinks();

					String folderName = referenceLinkResult[4];
					folderName = folderName.replace("+", " ").replace("%28", "(").replace("%29", ")").replace("%C2%B0", "\u00b0");
					fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), Long.parseLong(referenceLinkResult[3]), folderName);

					referenceFileEntryURL = themeDisplay.getPortalURL()+"/c/document_library/get_file?uuid="+ fileEntry.getUuid()+"&groupId="+themeDisplay.getScopeGroupId();

					referenceLinks.setReferenceUrl(referenceFileEntryURL);
					String fileName = StringUtils.abbreviate(fileEntry.getTitle(), 30);
					referenceLinks.setReferenceName(fileName);
					referenceLinkList.add(referenceLinks);
				}
			}
			catch (Exception e) {
				_log.error("Exception caught while processing Reference entries in SopLandingController.getSopArticleDetail(): " + e.getMessage(), e );
			}
		}
		
		articles.setId(articleId);
		articles.setTime(timeValue);
		articles.setTitle(titleValue);
		articles.setCategory(categoryValue);
		articles.setResponsible(responsibleValue);
		articles.setSupport(supportValue);
		articles.setImageArticle(imageValue);
		articles.setArticleContent(articleValue);
		if(categoryValue.equalsIgnoreCase("Context")){
			articles.setFontColor("#000000");
		}
		model.addAttribute("referenceLinkList", referenceLinkList);
		model.addAttribute("templateLinkList", templateLinkList);		
		
		/** Add Related Topics in Detail Page **/
		List<JournalFolder> journalFolder = new ArrayList<JournalFolder>();
		List<JournalArticle> journalArticles = new ArrayList<JournalArticle>();
		List<SOPArticles> sopArticles = new ArrayList<SOPArticles>();
		SOPArticles relatedArticles = new SOPArticles();
		
		DynamicQuery journalFolderQuery = DynamicQueryFactoryUtil.forClass(JournalFolder.class, PortletClassLoaderUtil.getClassLoader());
		journalFolderQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("companyId").eq(new Long(themeDisplay.getCompanyId())));
		journalFolderQuery.add(PropertyFactoryUtil.forName("name").eq("SOP"));
		journalFolder = JournalFolderLocalServiceUtil.dynamicQuery(journalFolderQuery);
		
		DynamicQuery journalArticleQuery = DynamicQueryFactoryUtil.forClass(JournalArticle.class, PortletClassLoaderUtil.getClassLoader());
		journalArticleQuery.add(PropertyFactoryUtil.forName("groupId").eq(new Long(themeDisplay.getScopeGroupId())));
		journalArticleQuery.add(PropertyFactoryUtil.forName("folderId").eq(new Long(journalFolder.get(0).getFolderId())));
		journalArticleQuery.addOrder(OrderFactoryUtil.asc("title"));
		journalArticles = JournalArticleLocalServiceUtil.dynamicQuery(journalArticleQuery);

		List<SOPArticles> sopArticlesListAll = new ArrayList<SOPArticles>();
		int i=0;
		SOPArticles selectedArticle = new SOPArticles();

		HttpServletRequest request = /*renderRequest.getAttribute("javax.servlet.request"); //*/PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		String time24Hours = getCookieString(request, "time24Hours");
		String time72Hours = getCookieString(request, "time72Hours");
		String time14Days = getCookieString(request, "time14Days");
		String time15Days = getCookieString(request, "time15Days");

		String catOB = getCookieString(request, "catOB");
		String catCoAd = getCookieString(request, "catCoAd");
		String catTechHR = getCookieString(request, "catTechHR");
		String catInfoMg = getCookieString(request, "catInfoMg");
		String catExtCom = getCookieString(request, "catExtCom");
		String catFnLg = getCookieString(request, "catFnLg");
		String catContext = getCookieString(request, "catContext");

		String resCountry = getCookieString(request, "resCountry");
		String resUnicef = getCookieString(request, "resUnicef");
		String resWho = getCookieString(request, "resWho");
		String resRpdRes = getCookieString(request, "resRpdRes");
		String resSrgTeam = getCookieString(request, "resSrgTeam");

		String time="";
		if(Validator.isNotNull(time24Hours) || Validator.isNotNull(time72Hours) || Validator.isNotNull(time14Days) || Validator.isNotNull(time15Days)){
			time = "time";
		}

		String category="";
		if(Validator.isNotNull(catOB) || Validator.isNotNull(catCoAd) || Validator.isNotNull(catTechHR) || Validator.isNotNull(catInfoMg) || Validator.isNotNull(catExtCom)
				|| Validator.isNotNull(catFnLg) || Validator.isNotNull(catContext)){
			category = "category";
		}

		String response="";
		if(Validator.isNotNull(resCountry) || Validator.isNotNull(resUnicef) || Validator.isNotNull(resWho) || Validator.isNotNull(resRpdRes)
				|| Validator.isNotNull(resSrgTeam)){
			response = "response";
		}

		// Different lists are populated for each time frame and combined at the end, because alphabetical sorting by time
		// frame is not easily possible due to hours/days suffix
		List<SOPArticles> sop24HoursArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop72HoursArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop14DaysArticles = new ArrayList<SOPArticles>();
		List<SOPArticles> sop15DaysCloseArticles = new ArrayList<SOPArticles>();

		for (JournalArticle article : journalArticles) {
			try {
				ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(article, themeDisplay);
				double latestArticleVersion = JournalArticleLocalServiceUtil.getLatestVersion(themeDisplay.getScopeGroupId(), article.getArticleId());
				relatedArticles = new SOPArticles();
				if (latestArticleVersion == article.getVersion()) {

					Document relatedDocument = SAXReaderUtil.read(article.getContentByLocale("en_US"));
					Node relatedTimeNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "TIME" + "']/dynamic-content");
					String relatedTimeValue = relatedTimeNode.getText();
					Node relatedCategoryNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Category" + "']/dynamic-content");
					String relatedCategoryValue = relatedCategoryNode.getText();
					Node relatedTitleNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Title" + "']/dynamic-content");
					String relatedTitleValue = relatedTitleNode.getText();
					Node relatedResponsibleNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "Responsible" + "']/dynamic-content");
					String relatedResponsibleValue = relatedResponsibleNode.getText();
					Node relatedImageNode = relatedDocument.selectSingleNode("/root/dynamic-element[@name='" + "ArticleImage" + "']/dynamic-content");
					String relatedImageValue = relatedImageNode.getText();

					String colorCode = SopLandingUtil.setArticleColorByTimeValue(relatedTimeValue);
					relatedArticles.setArticleColor(colorCode);

					relatedArticles.setAricleURLTitle(expandoValue.getData());
					if (relatedTimeValue.equalsIgnoreCase("Immediately") || relatedTimeValue.equalsIgnoreCase("3 Weeks") || relatedTimeValue.equalsIgnoreCase("14 Days to Close")
							|| relatedTimeValue.equalsIgnoreCase("3 Months")) {
						relatedArticles.setTime("15 DAYS-CLOSE");
						relatedArticles.setFontColor("#000000");
					} else {
						relatedArticles.setTime(relatedTimeValue);
					}
					relatedArticles.setCategory(relatedCategoryValue);
					relatedArticles.setTitle(relatedTitleValue);
					relatedArticles.setImageArticle(relatedImageValue);
					relatedArticles.setId(article.getId());

					if (article.getId() == articleId) {
						selectedArticle = relatedArticles;
					} else if (relatedCategoryValue.equalsIgnoreCase(categoryValue) && i < 3) {
						sopArticles.add(relatedArticles);
						i++;
					}

					filterSopArticles(sop24HoursArticles, sop72HoursArticles, sop14DaysArticles, sop15DaysCloseArticles,
							relatedArticles, relatedTimeValue, relatedCategoryValue, relatedResponsibleValue, time, category, response,
							time24Hours, time72Hours, time14Days, time15Days, catOB, catCoAd,
							catTechHR, catInfoMg, catExtCom, catFnLg, catContext, resCountry, resUnicef,
							resWho, resRpdRes, resSrgTeam);

					//sopArticlesListAll.add(relatedArticles);
				}
			}
			catch (Exception e) {
				_log.error("Exception caught while processing JournalArticle entries in SopLandingController.getSopArticleDetail(): " + e.getMessage() );
			}
		}
		boolean flag = sopCheckListService.checkSOPMyCheckListExistList(articles.getId(), themeDisplay.getUserId());

		sopArticlesListAll.addAll(sop24HoursArticles);
		sopArticlesListAll.addAll(sop72HoursArticles);
		sopArticlesListAll.addAll(sop14DaysArticles);
		sopArticlesListAll.addAll(sop15DaysCloseArticles);

		model.addAttribute("flag", flag);
		model.addAttribute("sopArticlesList", sopArticles);
		model.addAttribute("sopPreviousArticle", getPrevious(selectedArticle, sopArticlesListAll));
		model.addAttribute("sopNextArticle", getNext(selectedArticle, sopArticlesListAll));

		return articles;
	}

	/**
	 * Retrieves a cookie value from a request and transforms null results to an empty string.
	 */
	protected String getCookieString(HttpServletRequest request, String cookieName) {
		String value = CookieKeys.getCookie(request, cookieName);
		value = (value == null || value.equals("undefined")) ? "" : value;

		return value.replaceAll("_", " ");
	}

	private SOPArticles getNext(SOPArticles uid, List<SOPArticles> sopArticleList) {
		int idx = sopArticleList.indexOf(uid);
		if (idx < 0 || idx+1 == sopArticleList.size()) return null;
		return sopArticleList.get(idx + 1);
	}
	private SOPArticles getPrevious(SOPArticles uid, List<SOPArticles> sopArticleList) {
		int idx = sopArticleList.indexOf(uid);
		if (idx <= 0) return null;
		return sopArticleList.get(idx - 1);
	}


	private static Log _log = LogFactoryUtil.getLog(SopLandingController.class);
}
