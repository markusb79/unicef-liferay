<%@include file="init.jsp" %>

<div class="un-footer clearfix">
	<div class="fr">
	    <!--
		    <a href="#">ABOUT</a>
		    <a href="#">SITEMAP</a>
		    <a href="#">REPORT A BUG</a>
	    	
	    	https://futurelabconsulting.mydonedone.com/issuetracker/projects/43924/issues/287
	    	extra contact us link, need to be removed
	    	<a href="/web/guest/contact">CONTACT US</a>
	    -->	
    </div>
</div>
<div id="footer-loading-indicator" style="position: absolute; top: 4px; left: 4px; width: 50px; height: 50px;">
	<img src="/Rhizome-portlet/images/ironman_black.gif" />
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#footer-loading-indicator').hide(); // hide it when it is done.
		/*$(document)
				.ajaxStart(function () {
					$('#footer-loading-indicator').show(); // show on any Ajax event.
				})
				.ajaxStop(function () {
					$('#footer-loading-indicator').hide(); // hide it when it is done.
				});*/
	});
</script>