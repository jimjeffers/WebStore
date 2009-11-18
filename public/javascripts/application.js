$(document).ready(function(){
   // Handle any drop down navigation systems.
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
   
   // Handle the toggle form.
   $("div.toggle input[type='checkbox']").change(function() {
      var toggle = $(this);
      var fields = ['first','last','1','2','city','state','zip'];
      if(toggle.is(':checked')){
         for (var i = fields.length - 1; i >= 0; i--){
            $('#order_billing_'+fields[i]).val($('#order_shipping_'+fields[i]).val());
         };
      } else {
         for (var i = fields.length - 1; i >= 0; i--){
            $('#order_billing_'+fields[i]).val("");
         };
      }
   });
});

// Bind fancy box...
$("a.zoom").fancybox({
   'overlayShow' : false,
   'zoomSpeedIn' : 700,
   'zoomSpeedOut' : 600
});