package com.rhizome.portlet.signup;

import com.liferay.portal.DuplicateUserEmailAddressException;
import com.liferay.portal.UserPasswordException;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.User;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.ServiceContextFactory;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;

import java.io.IOException;
import java.util.Locale;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletModeException;
import javax.portlet.ReadOnlyException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ValidatorException;
import javax.portlet.WindowStateException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.ActionMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;


@Controller
@RequestMapping("VIEW")
public class SignUpController {
	private static final String VIEW = "view";
	private static final String SUCCESS = "success";
	
	private static final Log log = LogFactoryUtil.getLog(SignUpController.class);
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,
			RenderResponse renderResponse) throws PortalException, SystemException{
		
		String showSignupPopup = ParamUtil.getString(renderRequest, "showSignupPopup");
		renderRequest.setAttribute("showSignupPopup" ,showSignupPopup);
		
		String Showjsp = ParamUtil.getString(renderRequest, "jspmsg");
		renderRequest.setAttribute("jspmsg", "error");
		
		 if(Showjsp.equalsIgnoreCase("sucess") && SessionMessages.get(renderRequest, SignupConstants.SUCCESS).equals(SignupConstants.SUCCESS))
		 {
			 return SUCCESS;
		 }
		return VIEW;
	}
	
	@ActionMapping(params = "action=signup")
	public void signup(ActionRequest request, ActionResponse response)
			throws ReadOnlyException, ValidatorException, IOException,
			PortletModeException, SystemException, PortalException, WindowStateException {
		
		ThemeDisplay themeDisplay = (ThemeDisplay) request
				.getAttribute(WebKeys.THEME_DISPLAY);
		
		long companyId = themeDisplay.getCompanyId();
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password1 = request.getParameter("newPass");
		//String password2 = request.getParameter("confirmPass");
		
		
		
		long creatorUserId = 0;
		boolean autoPassword = false;
		boolean autoScreenName = true;
		long facebookId = 0;
		String openId = null;
		Locale locale = PortalUtil.getLocale(request);
		String middleName = null;
		int suffixId = 0;
		int prefixId = 0;
		boolean male = false;
		int birthdayMonth = 11;
		int birthdayDay = 12;
		int birthdayYear = 61;
		String jobTitle = "User";
		long[] groupIds = null;
		long[] organizationIds = null;
		long[] roleIds = null;
		long[] userGroupIds = null;
		boolean sendEmail = false;
		String screenName = firstName;
		
		creatorUserId = UserLocalServiceUtil.getDefaultUserId(companyId);
		
		User user = null;
		try {
			user = UserLocalServiceUtil.addUser(creatorUserId, companyId,
					autoPassword, password1, password1, autoScreenName,
					screenName, email, facebookId, openId, locale, firstName,
					middleName, lastName, prefixId, suffixId, male,
					birthdayMonth, birthdayDay, birthdayYear, jobTitle,
					groupIds, organizationIds, roleIds, userGroupIds,
					sendEmail, new ServiceContext());
		} catch (DuplicateUserEmailAddressException e) {
			log.error("Duplicate Email Address::" + e.getMessage());
			response.setRenderParameter("jspmsg", "error");
			SessionErrors.add(request, SignupConstants.DUPLICATE_EMAIL);
		} catch (UserPasswordException e) {
			log.error("Check PAssword policy::" + e.getMessage());
			response.setRenderParameter("jspmsg","error");
			SessionErrors.add(request, SignupConstants.PASSWORD_INCORRECT);
		} catch (Exception e) {
			log.error("Error in creating Liferay user::" + e.getMessage());
			response.setRenderParameter("jspmsg", "error");
			SessionErrors.add(request, SignupConstants.ERROR_MESSAGE);
		}
		
		
		if (user != null)
		{
			if (email != null && email.length() > 0 && sendEmail) 
			{
				try {
					ServiceContext serviceContext = ServiceContextFactory
							.getInstance(request);

					UserLocalServiceUtil.sendEmailAddressVerification(user,
							email, serviceContext);

					SessionMessages.add(request, SignupConstants.SUCCESS);
					response.setRenderParameter("jspmsg", "sucess");
					
				
				} catch (Exception e) 
				{
					log.error(e.getMessage(), e);
					SessionErrors.add(request, SignupConstants.ERROR_MESSAGE);
				}
			}
		} else 
		{
			log.error("User is null");
		}
		response.setRenderParameter("showSignupPopup", "true");
	}

}
