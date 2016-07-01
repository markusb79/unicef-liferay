<%@include file="../init.jsp"%>

<script type="text/javascript">

	jQuery(document).ready(function($) {
		   	$(window).resize(function() {
				if($(window).height() > '610' && $(window).width() > '1023'){

		   			$('.un-h-c4d-box01').css('height', ($(window).height()-165)/2+"px", 'important');
	  				$('.un-h-c4d-box02').css('height', ($(window).height()-164)/2+"px", 'important');
	   					
	   			
				}else {
				 
					if($(window).height() > '610' && $(window).width() > '767' && $(window).width() < '1024'){

	   				$('.un-h-c4d-box01').css('height', ($(window).height()-105)/2+"px", 'important');
	  				$('.un-h-c4d-box02').css('height', ($(window).height()-105)/2+"px", 'important');
				}		
				}
			});
	   	$(window).trigger('resize');    
	   	
	  
	});
	<portlet:namespace />openUnderStandJSP = function(url,action){
		window.location.href = url+'&action='+action;
	}
</script>