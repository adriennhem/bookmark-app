var ready;
ready = function () {
    var url = window.location;
    $('ul.navbar-left a[href="'+ url +'"]').parent().addClass('active');
    $('ul.navbar-left a').filter(function() {
         return this.href == url;
        }).parent().addClass('active');
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);