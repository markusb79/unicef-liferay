<%@page import="com.rhizome.util.MessageUtil"%>
<%@include file="../init.jsp"%>

<portlet:renderURL var="BackToMainPageURL">
</portlet:renderURL>

<portlet:resourceURL var="getSolutionDataURL" id="getSolutionDataURL"/>



   <div class="ans-body-container04 clearfix">
 
   					
 
   			<table style="width:100%;">
   			<thead>
   				<tr>
   					<th><div class="sg-title01 clearfix" style="margin:15px 0 0 0;">
   					
   					<span style="float:left"><%=MessageUtil.get("all-post", "All Post", locale) %></span>
   					
   					<span style="float:right"><a class="sopd-prev-link" href="<%=BackToMainPageURL.toString()%>">BACK</a></span>
   					</div></th>
   				</tr>
   			</thead>
			<tbody id="solutionTable">
   			</tbody>
   			
   			</table>
 <div id="pagination" style="margin-top:15px;">
</div>
   </div>

<div class="un-footer clearfix" id="footerTheme"> 
  		<div class="fr"> 
		    <a href="#">ABOUT</a>
		    <a href="#">SITEMAP</a>
		    <a href="#">REPORT A BUG</a>
		    <a href="#">CONTACT US</a>
     	</div>
</div>

<script type="text/javascript">
var globalPage = 1;
solutionPaging(globalPage);

if("${noOfSolutions}" > 10	){
	$("#pagination").pagination({
		items : "${noOfSolutions}",
		itemsOnPage : 10,
		onPageClick : function(pageNumber, event) {
			solutionPaging(pageNumber);
		},
	});	
}
function solutionPaging(pageNumber){
	$.ajax({
		   url :"<%=getSolutionDataURL.toString()%>",
				data : {
					pageNo : pageNumber,
					recordsPerPage : 10,
				},
				success : function(data) {
		
					document.getElementById("solutionTable").innerHTML = data;					
					
					if ($(document).height() > $(window).height()) {					
						$("#footerTheme").removeAttr("style");
						$("#footerTheme").css({
							"position":"absolute",
							"left":"0px",
							"right":"0px"
						});	
					}else{
						$("#footerTheme").css({
							"position":"fixed",
							"left":"0px",
							"right":"0px",							
							"bottom":"0px"
						});						
					}
				}
			});
	 globalPage = parseInt(pageNumber);
}
</script>

<style>
.sg-recent-title01:first-child {
    border-top: none;
}

</style>