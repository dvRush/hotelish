//= require active_admin/base
//= require datepicker-pt-BR.js
//= require activeadmin/dynamic_fields

$(document).ready(function(){
  var elements = document.querySelectorAll('.without_remove_button');

  $.each(elements, function(i, el) {
    var btn = $(el).find('a.has_many_remove');
    if (btn) btn.remove();
  });

  $.each($('.datepicker'), function(i, el) {
    var $el = $(el);
    $el.datepicker({ dateFormat: "dd/mm/yy" });
  });
});
