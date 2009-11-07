$(document).ready(function(){
   $('#grid').hide();
   $('body').dblclick(function(){
      if($('#grid').is(':visible')) {
         $('#grid').hide();
      } else {
         $('#grid').show();
      }
   });
});