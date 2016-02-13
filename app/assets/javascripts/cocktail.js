$(document).ready(function() {
  $('.cocktail').on("click", function(){
    modal_body = $(this).find('.modal-body-content').html();
    image = $(this).find('img').attr('alt');

    $('#myModalLabel').append(image);
    $('.modal-body').append(modal_body);
    $('#cocktailModal').modal('show');
  });
  $(document).on("hidden.bs.modal", function (e) {
    $(e.target).removeData("bs.modal").find(".modal-body").empty();
    $(e.target).removeData("bs.modal").find(".modal-title").empty();
  });
});
