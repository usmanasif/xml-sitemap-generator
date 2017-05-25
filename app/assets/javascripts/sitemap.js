$(document).on('click', '.add_var', function() {
  $('#add-new-sitemap').modal('show');
});
$(document).on("turbolinks:load",function() {
  return setTimeout((function() {
    return $('.alert').slideUp();
  }), 3000);
});
