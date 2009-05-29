jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
   // Handle add removal of categories.
   $('#product_detail_categories').click(function(event){
      var target = $(event.target);
      if(target.hasClass('remove') || target.hasClass('add')) {
         target.hide();
         $.getJSON(target.get(0).href, function(data) {
            var action;
            $.each(data, function(item,value){
               action = value;
            });
            if(action == 'add') {
               $('.remove_list').append(target.parent());
               target.get(0).href = target.get(0).href.replace('add','remove');
            } else if(action == 'remove') {
               $('.add_list').append(target.parent());
               target.get(0).href = target.get(0).href.replace('remove','add');
            }
            target.show('normal');
         });
         return false;
      }
   });
   
   // Handle inline editing of categories.
   $('.edit_link').hide();
   $('#categories li').hover(function(event){
      $(this).find('.edit_link').show();
   }, function(event){
      $(this).find('.edit_link').hide();
   });
   
   // Handle lightbox.
   $('body').append('<div id="lightbox"></div><div id="lightbox_background"></div>');
   hideLightbox();
   
   $('#lightbox_background, .lightbox_close').click(function() {
      hideLightbox('slow');
   });
   
   $('.lightbox_enabled').click(function(event) {
      $('#lightbox, #lightbox_background').show('slow');
      $.get(this.href, function(html){
       $('#lightbox').html(html);
       $('#lightbox .lightbox_close').click(function() {
         hideLightbox('slow');
       });
      });
      return false;
   });
});


function hideLightbox(speed) {
   $('#lightbox_background, #lightbox').hide(speed);
}