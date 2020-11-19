$(document).ready(function() {
    $.ajax({
        url: "/time/js"
    }).then(function(data) {
       $('.current-year').append(data.Year);
       $('.current-month').append(data.Month);
       $('.current-day').append(data.Day);
    });
});
