$(document).ready ->
  $('#change_sort').val $.query.get('sort_by')

  $('#change_sort').change ->
     window.location.search = $.query.set("sort_by", $(this).val());
     true

  $('a[data-filter]').click ->
    window.location.search =  $.query.set($(this).attr("data-filter"), $(this).attr("data-filter-value"));
    false

  actual_shacker = $.cookie('actual_shacker')

  unless actual_shacker?
    if $.query.get('user')
      actual_shacker = $.query.get('user')
      $.cookie("actual_shacker", actual_shacker, {expires: 7, path: '/'});

  if actual_shacker?
    your_lols = $("#your_lols").html().replace(/\#\#shackname\#\#/g, actual_shacker);
    $("#lol-too").html(your_lols);

