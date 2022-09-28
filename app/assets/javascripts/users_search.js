$(document).ready(function(){
  $("#users-search #keyword").on("keyup", function(){
    var ajax_result = $.get(
      $("#users-search").attr("action"),              // url where to get data
      {keyword: $("#users-search #keyword").val()},   //  pas data to get request

      function(){                                     // on success
        var result = $("#users-result").html();

        if(!result){

          $("#users-search #keyword").popover({
            content: "No result found.",
            placement: "bottom",
            html: true
          });

        } else {
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




// popover will generate/add this html:

//  <div class="popover fade show bs-popover-bottom" role="tooltip" id="popover838875" x-placement="bottom"
//   style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(1694px, 47px, 0px);">

//   <div class="arrow" style="left: 56px;"></div>
//   <h3 class="popover-header"></h3>
//   <div class="popover-body">

//     <div id="users-result">
//       <div class="p-3">
//         No results found.
//       </div>

//     </div>
//   </div>
// </div>
