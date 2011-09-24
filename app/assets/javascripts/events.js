$(document).ready(function(){
  $('.datepicker').live('mouseover', function(){
    $(this).datetimepicker({
      dateFormat: "yy-mm-dd"
    });
  });
});
