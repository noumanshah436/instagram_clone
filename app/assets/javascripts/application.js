// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require dropzone
//= require bootstrap-sprockets
//= require activestorage
//= require_tree .



$(document).ready(function() {

  $("#alert").fadeTo(2000, 500).slideUp(500, function(){
    $("#alert").slideUp(500);
  });

  document.querySelectorAll('.show-form').forEach( (el) => {
    el.addEventListener('click', (ev) => {
        ev.preventDefault();
        let comment_id = el.getAttribute('comment-id');
        let form = document.getElementById(`comment-form-${comment_id}`);
        form.style ='display: block;'

    })
  })

  document.querySelectorAll('.show-edit-form ').forEach( (el) => {
    el.addEventListener('click', (ev) => {
        ev.preventDefault();
        let comment_id = el.getAttribute('comment-id');
        let form = document.getElementById(`comment-edit-form-${comment_id}`);
        form.style ='display: block;'

    })
  })

})
