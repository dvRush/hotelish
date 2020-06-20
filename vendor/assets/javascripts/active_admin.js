//= require active_admin/base
//= require datepicker-pt-BR.js
//= require activeadmin/dynamic_fields
//= require select2.min
//= require select2_pt-BR.min
//= require ./masks
//= require ./viacep_autofill

$(document).ready(function(){
  var elements = document.querySelectorAll('.without_remove_button');

  $.each(elements, function(i, el) {
    var btn = $(el).find('a.has_many_remove');
    if (btn) btn.remove();
  });

  $.each($('.datepicker'), function(i, el) {
    $(el).datepicker({ dateFormat: "dd/mm/yy" });
  });

  $.each($('[data-use-select2]'), function(i, el) {
    $(el).select2()
  });
});
