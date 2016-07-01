package com.unicef.portlet.login.action;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.struts.BaseStrutsPortletAction;
import com.liferay.portal.kernel.struts.StrutsPortletAction;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.Layout;
import com.liferay.portal.util.PortletKeys;
import com.liferay.portlet.PortletURLFactoryUtil;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletRequest;
import javax.portlet.PortletSession;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.WindowState;

public class CustomForgotPassAction extends BaseStrutsPortletAction{

	@Override
	public void processAction(StrutsPortletAction originalStrutsPortletAction,
			PortletConfig portletConfig, ActionRequest actionRequest,
			ActionResponse actionResponse) throws Exception {
		// TODO Auto-generated method stub
		_log.info("MY CUSTOM METHOD CALLED + 1 ");
		String redirectURL = ParamUtil.getString(actionRequest, "redirect");
		
		Layout layout = (Layout)actionRequest.getAttribute(WebKeys.LAYOUT);
		//actionResponse.setRenderParameter("showFPPopup", "true");
		_log.info("Rediret URL " + redirectURL);
		//actionResponse.sendRedirect(redirectURL);
		PortletSession portletSession = actionRequest.getPortletSession();
		originalStrutsPortletAction.processAction(originalStrutsPortletAction, portletConfig, actionRequest, actionResponse);
		if(Validator.isNotNull(portletSession.getAttribute("showFP"))){
			PortletURL portletURL = PortletURLFactoryUtil.getPortletURLFactory().create(
					actionRequest, PortletKeys.LOGIN, layout.getPlid(),
					PortletRequest.RENDER_PHASE);
			
			portletURL.setParameter("saveLastPath", Boolean.FALSE.toString());
			portletURL.setParameter("showLoginPopup","true");
			portletURL.setParameter("status", "success");
			portletURL.setWindowState(WindowState.NORMAL);
			actionResponse.sendRedirect(portletURL.toString());
			portletSession.removeAttribute("showFP");
		}else{
			portletSession.setAttribute("showFP","true");
		}
		
	}

	@Override
	public String render(StrutsPortletAction originalStrutsPortletAction,
			PortletConfig portletConfig, RenderRequest renderRequest,
			RenderResponse renderResponse) throws Exception {
		// TODO Auto-generated method stub
		_log.info("MY CUSTOM METHOD CALLED + 2 ");
		String redirectURL = ParamUtil.getString(renderRequest, "redirect");
		//actionResponse.setRenderParameter("showFPPopup", "true");
		_log.info("Rediret URL 222 " + redirectURL);
		return originalStrutsPortletAction.render(originalStrutsPortletAction, portletConfig, renderRequest,
				renderResponse);
	}

	@Override
	public void serveResource(StrutsPortletAction originalStrutsPortletAction,
			PortletConfig portletConfig, ResourceRequest resourceRequest,
			ResourceResponse resourceResponse) throws Exception {
		// TODO Auto-generated method stub
		_log.info("MY CUSTOM METHOD CALLED + 3 ");
		originalStrutsPortletAction.serveResource(originalStrutsPortletAction, portletConfig,
				resourceRequest, resourceResponse);
	}
		
	private static Log _log = LogFactoryUtil.getLog(CustomForgotPassAction.class);
    private boolean reminderQueryEnabled = GetterUtil.getBoolean(PropsUtil.get(PropsKeys.USERS_REMINDER_QUERIES_ENABLED));
}
