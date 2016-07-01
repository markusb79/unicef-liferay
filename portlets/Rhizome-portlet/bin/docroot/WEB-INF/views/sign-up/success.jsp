<%@page import="com.rhizome.portlet.signup.SignupConstants"%>
<%@include file="../init.jsp"%>

<%
boolean showLoginFlag = ("true".equals(request.getAttribute("showSignupPopup"))? true: false);
%>
<div style="width:360px !important;">
	<liferay-ui:success key="<%=SignupConstants.SUCCESS%>" message="Thank You for registering successfully on Unicef</br>Please Log-In With your credentials." />
</div>

<script type="text/javascript">
$(document).ready(function() {
	<c:if test='<%= showLoginFlag %>'>
		$.fancybox.open('#loginBox');
	</c:if>
});
</script>




	
