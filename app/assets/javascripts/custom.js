$(document).ready(function() {
  $('#contact').click(function(event) {
    $sidebar = $('#sidebar .inner')
    var height = $sidebar.height();
    $sidebar.animate({ scrollTop: height*5 }, 1000);
  });
})
