package com.rhizome.sop.checklist;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.HttpHeaders;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.xml.Document;
import com.liferay.portal.kernel.xml.DocumentException;
import com.liferay.portal.kernel.xml.Node;
import com.liferay.portal.kernel.xml.SAXReaderUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.expando.model.ExpandoValue;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil;
import com.rhizome.domain.SOPArticles;
import com.rhizome.domain.SOPCheckList;
import com.rhizome.portlet.sop.landing.SopLandingUtil;
import com.rhizome.service.SOPCheckListService;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;
import org.xhtmlrenderer.pdf.ITextRenderer;

@Controller(value = "SOPChecklistController")
@RequestMapping("VIEW")
public class SOPChecklistController {
	
	@Autowired
	private SOPCheckListService sopCheckListService; 
	
	@RenderMapping
	public String defaultRender(RenderRequest renderRequest, RenderResponse renderResponse, Model model){
		return "sopChecklist"; 
	}
	
	@ResourceMapping(value="getSOPChecklist")
	public View getSOPChecklist(ResourceRequest resourceRequest, ResourceResponse resourceResponse){
		_log.info("getting all.....");
		
		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long userId = themeDisplay.getUserId();

		List<SOPCheckList> sopCheckLists = sopCheckListService.getSOPListForLoggedInUser(userId);
		long sopArticleId = 0l;
		SOPArticles article = null;
		boolean isChecklistEmpty = Boolean.FALSE;
		
		List<SOPArticles> sopArticles = new ArrayList<SOPArticles>();

		if(sopCheckLists != null ){
			
			for(SOPCheckList sopCheckList : sopCheckLists){
				sopArticleId = sopCheckList.getSopArticleId();
				article = new SOPArticles();
			
				try {
					JournalArticle journalArticle = JournalArticleLocalServiceUtil.getJournalArticle(sopArticleId);
					ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(journalArticle, themeDisplay);
					Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));

					Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
					String titleValue = titleNode.getText();
					article.setTitle(titleValue);
					article.setId(sopArticleId);
					
					if(expandoValue!=null) {
						article.setAricleURLTitle(expandoValue.getData());
					}

					if(!isChecklistEmpty) {
						isChecklistEmpty=isItemChecked(sopArticleId, themeDisplay.getUserId());
					}
					
					sopArticles.add(article);

				} catch (PortalException e) {
					_log.error("Error in getting Journal Article " + sopArticleId + e);
				} catch (SystemException e) {
					_log.error("Error in getting Journal Article with id "  + sopArticleId + e);
				} catch (DocumentException e) {
					_log.error("Error in fetching document " + e);
				}
			}
		}
		
		resourceRequest.setAttribute("isChecklistEmpty", isChecklistEmpty);
		resourceRequest.setAttribute("sopArticles", sopArticles);
		resourceRequest.setAttribute("sopCheckListService", sopCheckListService);
		
		
		return new InternalResourceView("/WEB-INF/views/sop-checklist/sopChecklist.jsp");
	}
	

	@ResourceMapping(value="printSOPChecklist")
	public void printSOPChecklist(ResourceRequest resourceRequest, ResourceResponse resourceResponse) {
		
		_log.info("SOPChecklistController : Inside generating document");
		
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		List<SOPCheckList> sopCheckLists = sopCheckListService.getSOPListForLoggedInUser(themeDisplay.getUserId());

		long sopArticleId = 0l;
		
		resourceResponse.setContentType("application/pdf");
		resourceResponse.setProperty(HttpHeaders.CONTENT_DISPOSITION, "attachement;filename="+themeDisplay.getUser().getFullName()+"_SOPChecklist_"+System.currentTimeMillis()+".pdf");
		
		try {
			StringBuffer buf = new StringBuffer();
			buf.append("<html>");
			buf.append("<body>");
			buf.append("<table width='100%' border='0'>"
					+ "<tr><td align='center'><b>www.rhizome.work</b></td></tr>"
					+ "</table><br/><br/>");
			buf.append("<table width='100%' border='0'>"
					+ "<tr><td align='center' ><b>MY SOP Checklist</b></td></tr>"
					+ "</table>");
			buf.append("<table border='0' align='center'>");
			buf.append("<tr>"
					+ "<td width='50px'>Status</td>"
					+ "<td width='420px'>ArticleTitle</td>"
					+ "</tr>");
		
			if(sopCheckLists != null ){

				for(SOPCheckList sopCheckList : sopCheckLists){
					sopArticleId = sopCheckList.getSopArticleId();
				
					try {
						JournalArticle journalArticle = JournalArticleLocalServiceUtil.getJournalArticle(sopArticleId);
						Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));
	
						Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
						String titleValue = titleNode.getText();
						
						SOPCheckList checklistItem = sopCheckListService.checkSOPMyCheckListExist(sopArticleId, themeDisplay.getUserId());
						
						String status  = checklistItem.isChecked() ? 
								"<span style='display: inline-block;"
								+ "vertical-align: baseline;"
								+ "line-height: 0.6;"
								+ "border: solid 0.08em;"
								+ "width: 0.6em; "
								+ "height: 0.6em; "
								+ "text-align: center;"
								+ "background-color:red;"
								+ "font-weight: bold;'></span>" :
								"<span style='display: inline-block;"
								+ "vertical-align: baseline;"
								+ "line-height: 0.6;"
								+ "border: solid 0.08em;"
								+ "width: 0.6em; "
								+ "height: 0.6em; "
								+ "text-align: center;"
								+ "font-weight: bold;'></span>";
						
						buf.append("<tr>"
								+ "<td align='center' width='50px'>"+status+"</td>"
								+ "<td width='420px'>"+titleValue.toString().replace("&", "&amp;")+"</td>"
								+ "</tr>");
						
					} catch (PortalException e) {
						_log.error("Error in getting Journal Article " + sopArticleId + e);
					} catch (SystemException e) {
						_log.error("Error in getting Journal Article with id "  + sopArticleId + e);
					} catch (DocumentException e) {
						_log.error("Error in fetching document " + e);
					}
					
				}
			}
		

			buf.append("</table>");
			buf.append("</body>");
			buf.append("</html>");
			
			byte[] bytes = buf.toString().getBytes();
			InputStream inputStream = new ByteArrayInputStream(bytes);
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			org.w3c.dom.Document doc = builder.parse(inputStream);
			ITextRenderer renderer = new ITextRenderer();
			renderer.setDocument(doc, null);
			renderer.layout();

			OutputStream os = resourceResponse.getPortletOutputStream();
			renderer.createPDF(os);
			os.close();
			
			} catch (Exception ex) {
				_log.error("error generating document " + ex.getMessage() );
			}
		
	}
	
	private boolean isItemChecked(long articleId, long userId) {
		return sopCheckListService.checkSOPMyCheckListExist(articleId, userId).isChecked();
	}
	
	@ResourceMapping(value="checkUnCheckList")
	public void checkUnCheckList(ResourceRequest resourceRequest, ResourceResponse resourceResponse){
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		long articleId = ParamUtil.getLong(request, "articleId");
		_log.info("Article ID in resource " + articleId);
		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		SOPCheckList sopCheckList = sopCheckListService.checkSOPMyCheckListExist(articleId, themeDisplay.getUserId());
		boolean sopChecked = sopCheckList.isChecked();
		
		if(Validator.isNotNull(sopCheckList) && sopChecked == false){
			sopCheckList.setChecked(true);
		} else {
			sopCheckList.setChecked(false);
		}
		
		sopCheckList.setModifiedDate(new Date());
		sopCheckListService.update(sopCheckList);
		
		
	}
	
	@ResourceMapping(value="clearAllCheckLeast")
	public void clearSOPCheckList(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException {
		_log.info("------------> ");
		
		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long userId = themeDisplay.getUserId();
		_log.info("current user : " + userId);
		
		List<SOPCheckList> sopCheckLists = sopCheckListService.getSOPListForLoggedInUser(userId);
		
		JSONArray jsonArray = JSONFactoryUtil.createJSONArray();
		
		if(sopCheckLists != null ) {
			for(SOPCheckList sopCheckList : sopCheckLists) {
				clearItemFromSopCheckList(themeDisplay, sopCheckList.getSopArticleId());
				JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
				jsonObject.put("articleId", sopCheckList.getSopArticleId());
				jsonArray.put(jsonObject);
			}
		}
		
		PrintWriter out=resourceResponse.getWriter();
		out.print(jsonArray.toString());
		
	}

	@ResourceMapping(value="removeArticleFromChecklist")
	public void removeArticleFromChecklist(ResourceRequest resourceRequest,ResourceResponse resourceResponse){
		_log.info("SOPChecklistController : Inside clear checklist");
		
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(request, "articleId");
		_log.info("SOPCHecklistController : articleId :- " + articleId);
		
		clearItemFromSopCheckList(themeDisplay, articleId);
	}
	
	private void clearItemFromSopCheckList( ThemeDisplay themeDisplay, long articleId) {
		
		// get articleid and user id and check if exist or not
		SOPCheckList sopCheckList = sopCheckListService.checkSOPMyCheckListExist(articleId, themeDisplay.getUserId());
		
		if(Validator.isNotNull(sopCheckList)) {
			sopCheckListService.delete(sopCheckList.getSopCheckListId());
		}
		
	}
	
	private static Log _log = LogFactoryUtil.getLog(SOPChecklistController.class);
}
