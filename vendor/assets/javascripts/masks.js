//= require jquery.mask.min

// Masks
;;(function(doc){
  $(doc).ready(function(){
    var moneyMaskInputs     = $('input[data-mask-money]');
    var phoneMaskInputs     = $('input[data-mask-phone]');
    var dateMaskInputs      = $('input[data-mask-date]');
    var datetimeMaskInputs  = $('input[data-mask-datetime]');
    var zipcodeMaskInputs   = $('input[data-mask-zipcode]');
    var documentMaskInputs  = $('input[data-mask-document]');

    var unmaskAll = function() {
      $('input').each(function(i, el) {
        $el = $(el);

        if(!$el.data()) return;
        if(!$el.data().mask) return;
        if($el.data().maskDate || $el.data().maskDatetime) return;

        $el.unmask();
      });
    }

    $.each(moneyMaskInputs, function(i, el) {
      $(el).mask("#.##0,00", {reverse: true});
    });

    $.each(phoneMaskInputs, function(i, el) {
      $(el).mask('(00) 00000-0000', {
        onKeyPress: function(phone, e, field, options) {
          var masks = ['(00) 0000-00009', '(00) 00000-0000'];
          var mask = (phone.length <= 14) ? masks[0] : masks[1];

          field.mask(mask, options)
        }
      });
    });

    $.each(dateMaskInputs, function(i, el) {
      $(el).mask("00/00/0000");
    });

    $.each(datetimeMaskInputs, function(i, el) {
      $(el).mask("00/00/0000 00:00:00");
    });

    $.each(zipcodeMaskInputs, function(i, el) {
      $(el).mask("00000-000");
    });

    $.each(documentMaskInputs, function(i, el) {
      $(el).mask('000.000.000-009', {
        onKeyPress: function(document_number, e, field, options) {
          var masks = ['000.000.000-009', '00.000.000/0000-00'];
          var mask = (document_number.length <= 14) ? masks[0] : masks[1];

          field.mask(mask, options)
        }
      });
    });

    $('form').submit(unmaskAll);
  });
})(document);
