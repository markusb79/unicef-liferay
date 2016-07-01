<script type="text/javascript">



(function($){
     $(window).load(function(){
         $(".flexslider").flexslider({
            animation: "slide",    //String: Select your animation type, "fade" or "slide"
            slideDirection: "horizontal", //String: Select the sliding direction, "horizontal" or "vertical"
            slideshow: false,    //Boolean: Animate slider automatically
            slideshowSpeed: 5000,   //Integer: Set the speed of the slideshow cycling, in milliseconds
            animationDuration: 2500,   //Integer: Set the speed of animations, in milliseconds
            directionNav: true,    //Boolean: Create navigation for previous/next navigation? (true/false)
            controlNav: false,    //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
            keyboardNav: true,    //Boolean: Allow slider navigating via keyboard left/right keys
            mousewheel: false,    //{UPDATED} Boolean: Requires jquery.mousewheel.js (https://github.com/brandonaaron/jquery-mousewheel) - Allows slider navigating via mousewheel
   smoothHeight: true,
            randomize: false,    //Boolean: Randomize slide order
            slideToStart: 0,    //Integer: The slide that the slider should start on. Array notation (0 = first slide)
            animationLoop: false,   //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
            pauseOnAction: true,   //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
            pauseOnHover: false,   //Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
   start: slideComplete,
   after: slideComplete
         }).addClass("lifted"); // add shadow to the slider - choose between: lifted, curled, perspective, raised, curved, curved curved-vt-1, curved curved-vt-2, , curved curved-hz-1, curved curved-hz-2, lifted rotated; Demo here: http://nicolasgallagher.com/css-drop-shadows-without-images/demo/

   function slideComplete(args) {
    var caption = $(args.container).find('.flex-caption').attr('style', ''),
     thisCaption = $('.flexslider .slides > li.flex-active-slide').find('.flex-caption');
    thisCaption.animate({left:25, opacity:1}, 1200, 'easeOutQuint');
    }
     })
 })(jQuery);



</script>