Dropzone.autoDiscover = false;

$(document).ready(function(){
  $(".upload-images").dropzone({
    addRemoveLinks: true,
    maxFilesize: 5,
    autoProcessQueue: false,
    uploadMultiple: true,
    parallelUploads: 10,
    maxFiles: 10,
    paramName: "images",
    previewsContainer: ".dropzone-previews",
    clickable: ".upload-photos-icon",
    thumbnailWidth: 100,
    thumbnailHeight: 100,

    init: function(){
      var myDropzone = this;

      this.element.querySelector("input[type=submit]").addEventListener("click", function(e){
        e.preventDefault();
        e.stopPropagation();
        myDropzone.processQueue();
        console.log("process queued")
      });

      this.on("successmultiple", function(files, response){
        window.location.reload();
      });

      this.on("errormultiple", function(files, response){
        console.log(response)
        // toastr.error(response);
      });
    }
  })
});
