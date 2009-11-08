// Handle any drop down navigation systems.
$(document).ready(function(){
   $('.sub_navigation').each(function() {
       var menu = $(this);
       menu.hide();
       var parent = $(menu.parent().get(0));
       var timeout = false; 
       parent.hover(function(){
          if(!timeout && !menu.is(':visible')) {
             timeout = setTimeout(function(){
                menu.show();
                parent.addClass('active');
                timeout = false;
             }, 350);
          } else {
             if(timeout) {
                clearTimeout(timeout);
             }
             timeout = false;
          }
       },
       function(){
          if(!timeout && menu.is(':visible')) {
              timeout = setTimeout(function(){
                 menu.hide();
                 parent.removeClass('active');
                 timeout = false;
              }, 350);
           } else {
              if(timeout) {
                 clearTimeout(timeout);
              }
              timeout = false;
           }
       });
   });
});

// Bind fancy box...
$("a.zoom").fancybox({
   'overlayShow' : false,
   'zoomSpeedIn' : 700,
   'zoomSpeedOut' : 600
});