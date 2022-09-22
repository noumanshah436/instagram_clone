// Tell Dropzone not to automatically upload the file
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

      // add event on submit button
      this.element.querySelector("input[type=submit]").addEventListener("click", function(e){

        if (myDropzone.getQueuedFiles().length != 0 ){
          e.preventDefault();
          e.stopPropagation();
          myDropzone.processQueue();
          console.log("process queued")
        }
      });

      this.on("successmultiple", function(files, response){
        console.log("dropzone successmultiple")
        window.location.reload();
      });

      this.on("errormultiple", function(files, response){
        console.log("dropzone errormultiple")
        console.log(response)
      });
    }
  })
});



// https://docs.dropzone.dev/
// https://docs.dropzone.dev/getting-started/setup/fallback-for-no-javascript
// https://docs.dropzone.dev/configuration/events
// submit button not working with dropzone
// https://stackoverflow.com/questions/46728205/dropzone-submit-button-on-upload
