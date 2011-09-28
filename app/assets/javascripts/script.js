$("#change_sort").val($.query.get("sort_by"))
$("#change_sort").change(function(){
  
  window.location.search = $.query.set("sort_by", $(this).val());
});

$("a[data-filter]").click(function(){
  window.location.search =  $.query.set($(this).attr("data-filter"), $(this).attr("data-filter-value"));
  return false;
});
