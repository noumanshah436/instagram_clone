
Dropzone.autoDiscover = false;

$(document).ready(function(){

  $(".upload-images").dropzone({
    addRemoveLinks: true,
    maxFilesize: 1,
    acceptedFiles: '.png,.jpg,.jpeg',
    autoProcessQueue: false,
    uploadMultiple: true,
    parallelUploads: 10,
    maxFiles: 10,
    paramName: "images",
    previewsContainer: ".dropzone-previews",
    clickable: ".upload-photos-icon",
    thumbnailWidth: 100,
    thumbnailHeight: 100,
    timeout: 180000,

    init: function(){
      var myDropzone = this;
      this.element.querySelector("input[type=submit]").addEventListener("click", function(e){
        if (myDropzone.getQueuedFiles().length != 0 ){
          e.preventDefault();
          e.stopPropagation();
          myDropzone.processQueue();
        }
        else {
          if (e.target.id == 'create_post') {
          e.preventDefault();
          alert("No Image Found")
          }
        }
      });


      this.on("successmultiple", function(files, response){
        window.location.reload();
      });

      this.on("errormultiple", function(files, response){ 
        console.log(response)
      });
    }
  })
});


