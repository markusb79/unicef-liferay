package com.rhizome.portlet.sopgeneral;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.HtmlUtil;
import com.liferay.portal.kernel.util.HttpUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.kernel.xml.DocumentException;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFolder;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;

import java.util.Locale;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;

@Controller
@RequestMapping("VIEW")
public class SOPGeneralController {

	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,RenderResponse renderResponse) throws PortalException, SystemException, DocumentException{

		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		DLFolder dlFolder = DLFolderLocalServiceUtil.getFolder(themeDisplay.getScopeGroupId(), 0, "0_General SOP Docs");
		DLFileEntry fileEntry = null;
		fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(themeDisplay.getScopeGroupId(), dlFolder.getFolderId(), "OutbreakSOP_Feb2015_layout20150226");
		String fileURL = null;
		fileURL = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/image/" + themeDisplay.getScopeGroupId() + StringPool.SLASH + fileEntry.getUuid();
		
		String title = "OutbreakSOP_Feb2015_layout20150226";
		String fileUrl = themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "/" + dlFolder.getFolderId() +  "/" + HttpUtil.encodeURL(HtmlUtil.unescape(title));
		
		System.out.println("FileUrl ::: "+fileUrl);
		model.addAttribute("fileURL", fileUrl);
		
		return "sopIntroduction";
	}
}
