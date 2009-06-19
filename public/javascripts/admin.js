jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

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
   
   // Create and lightbox.
   $('body').append('<div id="lightbox"></div><div id="lightbox_background"></div>');
   hideLightbox();
   
   // Handle the closure of a lightbox.
   $('#lightbox_background, .lightbox_close').click(function() {
      hideLightbox('slow');
   });
   
   // Handle the calling of a lightbox.
   $('.lightbox_enabled').click(function(event) {
      $('#lightbox, #lightbox_background').show('slow');
      $.get(this.href, function(html){
         $('#lightbox').html(html);
         $('#lightbox .lightbox_close').click(function() {
            hideLightbox('slow');
            return false;
         });
         
         // Handle the submission of an embedded form.
         $('#lightbox form').submit(function() {
            var form = $(this);
            form.find('input[type="submit"]').hide();
            $.post(this.action, form.serializeArray(),
            function(data) {
              // If there are errors found lets show them.
              if(data.errors) {
                 
                  // Insert the error module if it doesn't exist. 
                  if(form.find('.error_module').length < 1) {
                     form.append('<div class="errorExplanation"><h1><span class="error_count"></span> Errors Occurred:</h1><ul></ul></div>');
                  }
                  
                  // Reset fields with errors.
                  form.find('.fieldWithErrors').removeClass('fieldWithErrors');
                  form.find('.errorExplanation ul').html('');
                  form.find('.errorExplanation').hide();
                  
                  // Show errors.
                  form.find('.error_count').text(data.errors.length);
                  for(var i in data.errors) {
                     $('#'+form.get(0).id+' input[id$="'+data.errors[i][0]+'"], #'+form.get(0).id+' select[id$="'+data.errors[i][0]+'"]').parent().addClass('fieldWithErrors');
                     form.find('.errorExplanation ul').append('<li><strong>'+data.errors[i][0]+'</strong> '+data.errors[i][1]+'.</li>');
                     form.find('.errorExplanation').show('slow');
                  }
                  
                  form.find('input[type="submit"]').show();
              // Lets handle the result object.
              } else {
                 hideLightbox('fast');
                 if(data.variant_info && data.color_info && data.size_info) {
                     var variation = $('#variation_'+data.variant_info.variation.id).hide();
                     if(variation.length < 1) {
                        variation = $('#variations').prepend($('#variations li:last').clone().hide()).find('li:first');
                        var newVariation = true;
                     }
                     
                     // Replace data with the new stuff.
                     variation.find('.color').text(data.color_info.color.name);
                     variation.find('.color_preview').css('background', data.color_info.color.hex_value);
                     variation.find('.sku').text(data.variant_info.variation.sku);
                     variation.find('.size').text(data.size_info.garment_size.name);
                     variation.find('.gender').text(data.size_info.garment_size.gender);
                     variation.show('slow');
                     
                     if(newVariation) {
                        variation.find('.edit_variation').attr('href',"/products/"+data.variant_info.variation.product_id+"/variations/"+data.variant_info.variation.id+'/edit');
                        newVariation = false;
                     }
                 }
              }
            }, "json");
            return false;
         });
      });
      return false;
   });
});

function hideLightbox(speed) {
   $('#lightbox_background, #lightbox').hide(speed);
}