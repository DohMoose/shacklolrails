$(document).ready(function(){
  $("#change_sort").val($.query.get("sort_by"))
  $("#change_sort").change(function(){
    
    window.location.search = $.query.set("sort_by", $(this).val());
  });

  $("a[data-filter]").click(function(){
    window.location.search =  $.query.set($(this).attr("data-filter"), $(this).attr("data-filter-value"));
    return false;
  });

  var actual_shacker = $.cookie("actual_shacker");
  if (actual_shacker == null){
    if ($.query.get("user")){
      actual_shacker = $.query.get("user");
      $.cookie("actual_shacker", actual_shacker);
    }
  }
  if (actual_shacker){
    var your_lols = $("#your_lols").html().replace(/\#\#shackname\#\#/g, actual_shacker);
    $("#lol-too").html(your_lols);
  }  
});



