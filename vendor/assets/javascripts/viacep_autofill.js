// Copied from: https://github.com/marcelobarreto/autocomplete_zipcode/blob/master/vendor/assets/javascripts/autocomplete_zipcode.js
var ready = function() {
  var $zipcode_input = $('[data-zipcode="input"]')
  $zipcode_input.on("change", function(e){
    var zipcode = $zipcode_input.val().replace(/[^0-9]/g, '');

    if(zipcode.length == 8) {
      $.get('https://viacep.com.br/ws/'+ zipcode +'/json/').then(function(response) {
        if (response.erro) {
          var event = new Event('zipcode.error');

          document.dispatchEvent(event);
        } else {
          var event = new Event('zipcode.success');

          document.dispatchEvent(event);
        }

        var inputs = {
          street: 'logradouro',
          neighborhood: 'bairro',
          city: 'localidade',
          state: 'uf'
        }

        for(var key in inputs) {
          $('[data-zipcode="' + key + '"]').val(response[inputs[key]]);
        }
      });
    };
  })
};

if (typeof Turbolinks == "undefined") {
  $(document).ready(ready);
} else {
  $(document).on("turbolinks:load", ready);
}
