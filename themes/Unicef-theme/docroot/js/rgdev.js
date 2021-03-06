(function($) {

	// DOM ready
	$(function() {
		// Append the mobile icon rgdev
		$('.rgdev').append($('<div class="rgdev-mobile"><span class="nicon_bar"></span> <span class="nicon_bar"></span><span class="nicon_bar"></span></div>'));
		$('.rgdev').append($('<div class="rgdev-text">Navigation</div>'));
		
		// Add a <span> to every .rgdev-item that has a <ul> inside
		$('.rgdev-item').has('ul').prepend('<span class="rgdev-click"><i class="rgdev-arrow"></i></span>');
		
		$('.rgdev-submenu-item').has('ul').prepend('<span class="rgdev-click"><i class="rgdev-arrow"></i></span>');
		
		$('.rgdev-submenu-item-sub').has('ul').prepend('<span class="rgdev-click"><i class="rgdev-arrow"></i></span>');
		
		// Click to reveal the rgdev
		$('.rgdev-mobile').click(function(){
			$('.rgdev-list').slideToggle('slow');
		});
		$('.rgdev-click').click(function(){
		$(this).siblings('.rgdev-submenu').slideToggle('slow');
		$(this).children('.rgdev-arrow').toggleClass('rgdev-rotate');
		$(this).siblings('.rgdev-submenu-sub').slideToggle('slow');
		$(this).siblings('.rgdev-submenu-sub-sub').slideToggle('slow');		
		});
		
		window.onresize = function(event) {
			
			if($(window).width() > 767){
				$('.rgdev-submenu').removeAttr('style');	
			}
    	};

		
	// DOM rgdevrgk~30987
	});
	
})(jQuery);