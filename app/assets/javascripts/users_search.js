$(document).ready(function(){
  $("#users-search #keyword").on("keyup", function(){
    var jqxhr = $.get(
      $("#users-search").attr("action"),
      {keyword: $("#users-search #keyword").val()},
      function(){
        var result = $("#users-result").html();
        if(!result){
          $("#users-search #keyword").popover({
            content: "No result found.",
            placement: "bottom",
            html: true

          });
        } else {
          console.log("Hey");
          console.log($("#users-result"));
          $("#users-search #keyword").popover({
            content: $("#users-result"),
            placement: "bottom",
            html: true
          });
        }
        $("#users-search #keyword").popover("show"); 
      }
    )
  })
});
