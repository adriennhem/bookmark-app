var ready;
ready = function () {
    var url = window.location;
    $('ul.sidebar a[href="'+ url +'"]').parent().addClass('active');
    $('ul.sidebar a').filter(function() {
         return this.href == url;
        }).parent().addClass('active');
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);