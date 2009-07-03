jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
   // Handle subnavigation.
   subNavigation(350);
   
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
      return false;
   });
   
   // Handle the calling of a lightbox.
   $('.lightbox_enabled').click(function(event){
      showLightbox(this,'slow');
      return false;
   });
   
   // Add unobtrusive delete.
   $('.delete').click(function() {
      sendDelete(this);
      return false;
   });
   
   // Add color picker.
   $('.color_tool').ColorPicker({
      onSubmit: function(hsb, hex, rgb, el) {
         $(el).val(hex);
         $(el).ColorPickerHide();
      },
      onBeforeShow: function () {
         $(this).ColorPickerSetColor(this.value);
      }
   })
   .bind('keyup', function(){
      $(this).ColorPickerSetColor(this.value);
   });
   
});

function showLightbox(source,speed) {
   $('#lightbox, #lightbox_background').show(speed);
   $.get(source.href, function(html){
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
                     variation.attr('id','variation_'+data.variant_info.variation.id);
                     variation.find('.edit_variation').attr('href',"/products/"+data.variant_info.variation.product_id+"/variations/"+data.variant_info.variation.id+'/edit');
                     variation.find('.edit_variation').click(function(event){
                        showLightbox(this,'slow');
                        return false;
                     });
                     variation.find('.delete_variation').attr('href',"/products/"+data.variant_info.variation.product_id+"/variations/"+data.variant_info.variation.id);
                     variation.find('.delete_variation').click(function(event){
                        sendDelete(this);
                        return false;
                     });
                  }
                  
                  // Replace data with the new stuff.
                  variation.find('.color').text(data.color_info.color.name);
                  variation.find('.color_preview').css('background', data.color_info.color.hex_value);
                  variation.find('.sku').text(data.variant_info.variation.sku);
                  variation.find('.size').text(data.size_info.garment_size.name);
                  variation.find('.gender').text(data.size_info.garment_size.gender);
                  variation.show('slow');
              }
           }
         }, "json");
         return false;
      });
   });
}

// Remember to invoke within jQuery(window).load(...)
// If you don't, Jcrop may not initialize properly
jQuery(window).load(function(){

   jQuery('#cropbox').Jcrop({
      onChange: showPreview,
      onSelect: showPreview,
      aspectRatio: 1
   });

});

// Our simple event handler, called from onChange and onSelect
// event handlers, as per the Jcrop invocation above
function showPreview(coords)
{
   if (parseInt(coords.w) > 0)
   {
      var rx = 100 / coords.w;
      var ry = 100 / coords.h;

      jQuery('#preview').css({
         width: Math.round(rx * 500) + 'px',
         height: Math.round(ry * 370) + 'px',
         marginLeft: '-' + Math.round(rx * coords.x) + 'px',
         marginTop: '-' + Math.round(ry * coords.y) + 'px'
      });
   }
}

function hideLightbox(speed) {
   $('#lightbox_background, #lightbox').hide(speed);
}

function subNavigation(time) {
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
                }, time);
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
                 }, time);
              } else {
                 if(timeout) {
                    clearTimeout(timeout);
                 }
                 timeout = false;
              }
          });
      });
}

function sendDelete(el) {
   if (typeof(AUTH_TOKEN) == "undefined") return;
   
   if(confirm("Are you sure?")) {
      var f = document.createElement('form'); 
      f.style.display = 'none'; 
      el.parentNode.appendChild(f); 
      f.method = 'POST'; f.action = el.href;
   
      var m = document.createElement('input'); 
      m.setAttribute('type', 'hidden'); 
      m.setAttribute('name', '_method'); 
      m.setAttribute('value', 'delete'); 
      f.appendChild(m);
   
      var s = document.createElement('input'); 
      s.setAttribute('type', 'hidden'); 
      s.setAttribute('name', 'authenticity_token'); 
      s.setAttribute('value', AUTH_TOKEN); 
      f.appendChild(s);
      f.submit();
   }
}