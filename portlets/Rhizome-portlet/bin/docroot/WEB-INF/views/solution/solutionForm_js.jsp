<%@include file="../init.jsp"%>

<script type="text/javascript">
<portlet:namespace/>submitSolutionForm = function(){
	var editorHTML = $("#<portlet:namespace/>descriptionckEditor").val();
	if(editorHTML == ''){
	$('#<portlet:namespace/>descriptionError').show();
	return;
	}else{
	$('#<portlet:namespace/>descriptionError').hide();
	}
	
	$("#<portlet:namespace/>answerContent").val(editorHTML);
	submitForm(document.<portlet:namespace />polioAnswerForm);
}
</script>