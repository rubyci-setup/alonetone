(function($) {

    document.addEventListener("turbolinks:load", function() {
        
        console.log( $("ul.playlists") );

        for (var i = 0; i < 8; i++) {
			
			var $flexInvisibleDiv = $("<li></li>").appendTo( $("#user_playlists_area ul.playlists") );

			$flexInvisibleDiv.width( $flexInvisibleDiv.prev().width() );

        }

    
    });

})(jQuery);