package com.rhizome.util;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.service.LayoutLocalServiceUtil;

public class SOPUtil {

	private static final Log log = LogFactoryUtil.getLog(SOPUtil.class);
	private static final String SOP_FRIENDLY_URL_LAYOUT = PropsUtil.get("SOP-friendly-layout");
	public static Layout getSOPLayout(long groupId){
		Layout sopLayout = null;
		try {
			sopLayout = LayoutLocalServiceUtil.getFriendlyURLLayout(groupId, Boolean.TRUE, getSOPFriendlyLayoutURL());
		} catch (PortalException e) {
			log.error("Error in getting solution layout:"+e.getMessage());
		} catch(SystemException e) {
			log.error("Error in getting solution layout:"+e.getMessage());
		}
		return sopLayout;
		
}

public static String getSOPFriendlyLayoutURL(){
	if(Validator.isNotNull(SOP_FRIENDLY_URL_LAYOUT)){
		return SOP_FRIENDLY_URL_LAYOUT;
	}
	return "/sop";
}
}
