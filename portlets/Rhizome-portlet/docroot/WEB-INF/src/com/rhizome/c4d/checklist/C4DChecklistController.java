package com.rhizome.c4d.checklist;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.HttpHeaders;
import com.liferay.portal.kernel.util.ParamUtil;
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
import com.rhizome.domain.C4DArticles;
import com.rhizome.domain.C4DCheckList;
import com.rhizome.portlet.sop.landing.SopLandingUtil;
import com.rhizome.service.C4DCheckListService;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
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

@Controller(value = "C4DChecklistController")
@RequestMapping("VIEW")
public class C4DChecklistController {
	
	@Autowired
	private C4DCheckListService c4dCheckListService;
	
	@RenderMapping
	public String defaultRender(RenderRequest renderRequest, RenderResponse renderResponse, Model model){
		return "c4dChecklist";
	}

	@ResourceMapping(value="printC4DToolkit")
	public void printC4DToolkit(ResourceRequest resourceRequest, ResourceResponse resourceResponse) {
		
		_log.info("C4DChecklistController : Inside generating document");
		
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		List<C4DCheckList> c4dCheckLists = c4dCheckListService.getC4DListForLoggedInUser(themeDisplay.getUserId());
		
		long c4dArticleId = 0l;
		
		resourceResponse.setContentType("application/pdf");
		resourceResponse.setProperty(HttpHeaders.CONTENT_DISPOSITION, "attachement;filename="+themeDisplay.getUser().getFullName()+"_C4DToolkit_"+System.currentTimeMillis()+".pdf");
		
		try {
			StringBuffer buf = new StringBuffer();
			buf.append("<html>");
			buf.append("<body>");
			buf.append("<table width='100%' border='0'>"
					+ "<tr><td align='center'><b>www.rhizome.work</b></td></tr>"
					+ "</table><br/><br/>");
			buf.append("<table width='100%' border='0'>"
					+ "<tr><td align='center' ><b>MY C4D Toolkit</b></td></tr>"
					+ "</table>");
			buf.append("<table border='0' align='center'>");
			buf.append("<tr>"
					+ "<td width='420px'>ArticleTitle</td>"
					+ "</tr>");
		
			if(c4dCheckLists != null) {
				
				for(C4DCheckList c4dCheckList : c4dCheckLists) {
					
					c4dArticleId = c4dCheckList.getC4dArticleId();
					
					try {
						JournalArticle journalArticle = JournalArticleLocalServiceUtil.getJournalArticle(c4dArticleId);
						Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));
						Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");

						String titleValue = titleNode.getText();
						
						buf.append("<tr>"
								+ "<td width='420px'>"+titleValue.toString().replace("&", "&amp;")+"</td>"
								+ "</tr>");
						
						} catch (PortalException e) {
							_log.error("Error in getting Journal Article " + c4dArticleId + e);
						} catch (SystemException e) {
							_log.error("Error in getting Journal Article with id "  + c4dArticleId + e);
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
	
	@ResourceMapping(value="viewC4DChecklistView")
	public View viewC4DChecklistView(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException {

		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long userId = themeDisplay.getUserId();
		_log.info("current userId :" + userId);
		
		List<C4DCheckList> c4dCheckLists = c4dCheckListService.getC4DListForLoggedInUser(userId);
		
		long c4dArticleId = 0l;
		C4DArticles article = null;
		
		List<C4DArticles> c4dArticles = new ArrayList<C4DArticles>();
		
		if(c4dCheckLists != null) {
			
			for(C4DCheckList c4dCheckList : c4dCheckLists) {
				
				c4dArticleId = c4dCheckList.getC4dArticleId();
				article = new C4DArticles();
				
				try {
					JournalArticle journalArticle = JournalArticleLocalServiceUtil.getJournalArticle(c4dArticleId);
					Document document = SAXReaderUtil.read(journalArticle.getContentByLocale("en_US"));
					ExpandoValue expandoValue = SopLandingUtil.getExpandoValue(journalArticle, themeDisplay);
					Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Title" +"']/dynamic-content");
					String titleValue = titleNode.getText();
					
					Node relatedCategoryNode = document.selectSingleNode("/root/dynamic-element[@name='" + "Category" +"']/dynamic-content");
					String relatedCategoryValue = relatedCategoryNode.getText();
					
					article.setTitle(titleValue);
					article.setArticleId(c4dArticleId);
					article.setAricleURLTitle(expandoValue.getData());
					article.setCategory(relatedCategoryValue);
					c4dArticles.add(article);
			
				} catch (PortalException e) {
					_log.error("Error in getting Journal Article " + c4dArticleId + e);
				} catch (SystemException e) {
					_log.error("Error in getting Journal Article with id "  + c4dArticleId + e);
				} catch (DocumentException e) {
					_log.error("Error in fetching document " + e);
				}
				
			 }

		}
		
		resourceRequest.setAttribute("c4dArticles", c4dArticles);
		resourceRequest.setAttribute("c4dCheckListService", c4dCheckListService);
		
		return new InternalResourceView("/WEB-INF/views/c4d-checklist/c4dChecklist.jsp");
	}	
	
	@ResourceMapping(value="clearAllToolkit")
	public void clearC4DToolkit(ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws IOException {
		_log.info("------------> ");
		
		ThemeDisplay themeDisplay = (ThemeDisplay)resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long userId = themeDisplay.getUserId();
		_log.info("current user : " + userId);
		
		List<C4DCheckList> c4dCheckLists = c4dCheckListService.getC4DListForLoggedInUser(userId);
		
		JSONArray jsonArray = JSONFactoryUtil.createJSONArray();
		// List<SOPArticles> sopArticles = new ArrayList<SOPArticles>();
		
		if(c4dCheckLists != null ) {
			for(C4DCheckList c4dCheckList : c4dCheckLists) {
				removeItemsFromC4DToolkit(themeDisplay, c4dCheckList.getC4dArticleId());
				
				JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
				jsonObject.put("articleId", c4dCheckList.getC4dArticleId());
				jsonArray.put(jsonObject);
			}
		}
		
		PrintWriter out=resourceResponse.getWriter();
		out.print(jsonArray.toString());
		
	}
	
	@ResourceMapping(value="removeC4DResourceFromCheckList")
	public void removeC4DResourceFromChecklist(ResourceRequest resourceRequest, ResourceResponse resourceResponse){
		
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long articleId = ParamUtil.getLong(request, "articleId");
		_log.info("Remove article by Id : " + articleId);
		removeItemsFromC4DToolkit(themeDisplay, articleId);
	}
	
	private void removeItemsFromC4DToolkit(ThemeDisplay themeDisplay, long articleId) {
		// get articleid and user id and check if exist or not
		C4DCheckList c4dCheckList = c4dCheckListService.checkC4DMyCheckListExist(articleId, themeDisplay.getUserId());
		try{
			c4dCheckListService.delete(c4dCheckList.getC4dCheckListId());
		}catch(Exception e){
			_log.error("Error in deleting toolkit with given Id " + c4dCheckList.getC4dCheckListId() + e);
		}
			
		
	}
	
	private static Log _log = LogFactoryUtil.getLog(
			C4DChecklistController.class);
}
