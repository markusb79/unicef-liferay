package com.rhizome.portlet.sop.landing;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.expando.model.ExpandoColumn;
import com.liferay.portlet.expando.model.ExpandoTable;
import com.liferay.portlet.expando.model.ExpandoValue;
import com.liferay.portlet.expando.service.ExpandoColumnLocalServiceUtil;
import com.liferay.portlet.expando.service.ExpandoTableLocalServiceUtil;
import com.liferay.portlet.expando.service.ExpandoValueLocalServiceUtil;
import com.liferay.portlet.journal.model.JournalArticle;

public class SopLandingUtil {

	private static final Log log = LogFactoryUtil.getLog(SopLandingUtil.class);
	
	public static ExpandoValue getExpandoValue(JournalArticle article,
			ThemeDisplay themeDisplay) {
		ExpandoValue expandoValue = null;
		try {
			ExpandoTable  expandoTable = ExpandoTableLocalServiceUtil.getDefaultTable(themeDisplay.getCompanyId(), JournalArticle.class.getName());
			ExpandoColumn column = ExpandoColumnLocalServiceUtil.getColumn(expandoTable.getTableId(), "Article_Title");
			if (column != null) {
				expandoValue = ExpandoValueLocalServiceUtil.getValue(expandoTable.getTableId(), column.getColumnId(), article.getId());
			}
		} catch (PortalException e) {
			log.error("error in Getting Expando Value"+e.getMessage());
		} catch (SystemException e) {
			log.error("Error in Getting Expando Value"+e.getMessage());
		}
		return expandoValue;
	}

	public static String setArticleColorByTimeValue(String timeValue) {
		String articleColor = StringPool.BLANK;
		if(timeValue.equalsIgnoreCase("24 Hours")){
			articleColor = "#b12924";
		}if(timeValue.equalsIgnoreCase("72 HOURS")){
			articleColor = "#eb5f65";
		}if(timeValue.equalsIgnoreCase("14 DAYS")){
			articleColor = "#f49393";
		}if(timeValue.equalsIgnoreCase("14 Days to Close") || timeValue.equalsIgnoreCase("3 Weeks") || 
				timeValue.equalsIgnoreCase("3 Months") || timeValue.equalsIgnoreCase("Immediately")){
			articleColor = "#fbe3e6";
		}
		return articleColor;
	}

}
