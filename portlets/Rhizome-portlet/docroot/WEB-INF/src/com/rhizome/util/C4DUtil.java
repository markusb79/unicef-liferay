package com.rhizome.util;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.service.LayoutLocalServiceUtil;

public class C4DUtil {

	private static final Log log = LogFactoryUtil.getLog(C4DUtil.class);
	private static final String C4D_FRIENDLY_URL_LAYOUT = PropsUtil.get("C4D-friendly-layout");
	public static Layout getC4DLayout(long groupId){
		Layout c4dLayout = null;
		try {
			c4dLayout = LayoutLocalServiceUtil.getFriendlyURLLayout(groupId, Boolean.TRUE, getC4DFriendlyLayoutURL());
		} catch (PortalException e) {
			log.error("Error in getting solution layout:"+e.getMessage());
		} catch(SystemException e) {
			log.error("Error in getting solution layout:"+e.getMessage());
		}
		return c4dLayout;
		
}

public static String getC4DFriendlyLayoutURL(){
	if(Validator.isNotNull(C4D_FRIENDLY_URL_LAYOUT)){
		return C4D_FRIENDLY_URL_LAYOUT;
	}
	return "/c4d";
}
}
