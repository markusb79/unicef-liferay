<%@page import="com.rhizome.portlet.signup.SignupConstants"%>
<%@include file="../init.jsp"%>
<portlet:actionURL var="signup">
	<portlet:param name="action" value="signup" />
</portlet:actionURL>
<%
boolean showLoginFlag = ("true".equals(request.getAttribute("showSignupPopup"))? true: false);
%>
<div id="error-msg">
<liferay-ui:error key="<%= SignupConstants.PASSWORD_INCORRECT %>" message="Password incorrect." />
<liferay-ui:error key="<%= SignupConstants.DUPLICATE_EMAIL %>" message="Please try different email address as this email address already exists." />
</div>


<aui:form name="fm" method="POST" action="${signup}">
		<div class="un-input-s1">
			<aui:input name="firstName" value="" placeholder="First Name" showRequiredLabel="<%=false %>"
				label="">
				<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="Enter valid First Name">
						function validateName(name) 
						{ 
							if(name.trim() == ''){
								return true;
							}
   							var re = /^([a-zA-Z ']{1,75})$/;
   							return re.test(name);
						}
					</aui:validator>
			</aui:input>
		</div>
		<div class="un-input-s1">
			<aui:input name="lastName" value="" placeholder="Last Name" showRequiredLabel="<%=false %>"
				label="">
				<aui:validator name="required" />
				<aui:validator name="custom" errorMessage="Enter valid Last Name">
							function validateName(name) 
							{ 
								if(name.trim() == ''){
									return true;
								}
    							var re = /^([a-zA-Z ']{1,75})$/;
    							return re.test(name);
							}
					
					</aui:validator>
			</aui:input>

		</div>
		<div class="un-input-s1">
			<aui:input name="email" value='' showRequiredLabel="<%=false %>" id="email"
				label="" placeholder="Email Address">
				<aui:validator name="required" />
				<aui:validator name="custom"
					errorMessage="Enter valid Email Address">
							function validateName(email) 
							{
								if(email.trim() == ''){
									return true;
								}
    							var re = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    							return re.test(email);
							}
					
					</aui:validator>
			</aui:input>
		</div>
		<div class="un-input-s1">
				 <aui:input type="password" name="newPass"  showRequiredLabel="<%=false %>" id="password1" value='' label="" placeholder="Password">
					<aui:validator name="required"></aui:validator>
			 </aui:input>
		</div>
	<%-- 	<div class="un-input-s1">
			 <aui:input type="password" name="confirmPass" value='' showRequiredLabel="<%=false %>" placeholder="Confirm Password" label="">
						<aui:validator name="required"></aui:validator>
						<aui:validator name="equalTo">'#<portlet:namespace/>password1'</aui:validator>
			 </aui:input>
		</div> --%>
		
	<div class="clearfix">
		<aui:button type="submit" value="Sign Up" cssClass="un-submit-link"/> 
	 </div>
</aui:form>
<script type="text/javascript">
$(document).ready(function() {
	<c:if test='<%= showLoginFlag %>'>
		$.fancybox.open('#loginBox');
	</c:if>
});
</script>