package com.unicef.portlet.login.action;

import com.liferay.portal.kernel.captcha.CaptchaUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.struts.BaseStrutsPortletAction;
import com.liferay.portal.kernel.struts.StrutsPortletAction;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.Layout;
import com.liferay.portal.util.PortletKeys;
import com.liferay.portlet.PortletURLFactoryUtil;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletRequest;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.WindowState;

public class LoginAction  extends BaseStrutsPortletAction{
	
	@Override
	public void processAction(StrutsPortletAction originalStrutsPortletAction, PortletConfig portletConfig,
			           ActionRequest actionRequest, ActionResponse actionResponse) throws Exception{
			String captchaCheck = ParamUtil.getString(actionRequest, "captchaCheck"); 
			try{
				if("true".equals(captchaCheck)){
					CaptchaUtil.check(actionRequest);
				}
				originalStrutsPortletAction.processAction(portletConfig, actionRequest, actionResponse);
			}catch(Exception e){
				SessionErrors.add(actionRequest, e.getClass(), e);
				Layout layout = (Layout)actionRequest.getAttribute(WebKeys.LAYOUT);
				PortletURL portletURL = PortletURLFactoryUtil.getPortletURLFactory().create(
						actionRequest, PortletKeys.LOGIN, layout.getPlid(),
						PortletRequest.RENDER_PHASE);
				
				portletURL.setParameter("saveLastPath", Boolean.FALSE.toString());
				portletURL.setParameter("showLoginPopup","true");
				portletURL.setWindowState(WindowState.NORMAL);
				actionResponse.sendRedirect(portletURL.toString());
			}		
			
			if(SessionErrors.size(actionRequest) > 0){
				int loginErrorCount = ParamUtil.getInteger(actionRequest, "loginErrorCount") + 1; 
				Layout layout = (Layout)actionRequest.getAttribute(WebKeys.LAYOUT);
				PortletURL portletURL = PortletURLFactoryUtil.getPortletURLFactory().create(
						actionRequest, PortletKeys.LOGIN, layout.getPlid(),
						PortletRequest.RENDER_PHASE);
				
				portletURL.setParameter("saveLastPath", Boolean.FALSE.toString());
				portletURL.setParameter("showLoginPopup","true");
				portletURL.setParameter("loginErrorCount",loginErrorCount+"");
				portletURL.setWindowState(WindowState.NORMAL);
				actionResponse.sendRedirect(portletURL.toString());
			}
	}
	@Override
	public String render(StrutsPortletAction originalStrutsPortletAction, PortletConfig portletConfig,
            RenderRequest renderRequest, RenderResponse renderResponse) throws Exception {
        return originalStrutsPortletAction.render(originalStrutsPortletAction, portletConfig, renderRequest,
                renderResponse);
    }
	
    @Override
    public void serveResource(StrutsPortletAction originalStrutsPortletAction, PortletConfig portletConfig,
            ResourceRequest resourceRequest, ResourceResponse resourceResponse) throws Exception {
        originalStrutsPortletAction.serveResource(originalStrutsPortletAction, portletConfig, resourceRequest,
                resourceResponse);
    }
    
	private static final boolean _CHECK_METHOD_ON_PROCESS_ACTION = false;

	private static Log _log = LogFactoryUtil.getLog(LoginAction.class);

}
