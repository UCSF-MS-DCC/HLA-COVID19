// This is a manifest file that'll be compiled into application.assets.js, which will include all the files
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
//= require ../../../../../../.rbenv/versions/3.0.4/lib/ruby/gems/3.0.0/gems/jquery-rails-4.6.0/vendor/assets/javascripts/jquery3
//= require popper
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require datatables.js
//= require clipboard
//= require gritter
//= require jquery_nested_form
//= require_tree .

$(document).on('turbo:load', function(){
  var clipboard = new Clipboard('.clipboard-btn');
    
  $('#irb_checkbox').on('change', function(){
    if ($(this).prop("checked") === true) {
      $('#file_upload_submit').prop("disabled",false);
    } else {
      $('#file_upload_submit').prop("disabled",true);
    }
  });
  /* set default checkbox checked state to reflect whether user is already approved for a project */
  $('.user-list').each(function(){
    if ( $(this).data("appstatus") === "yes") {
      $(this).prop("checked", "true");
    }
  })

  $('#approve_all_checkbox').on('change', function(){
    var userApproved = $(this).prop("checked") == true ? true : false
    $('.user-list').prop("checked", userApproved)
    $('.user-list').each(function(idx, obj){
      var email = $(obj).data("email");
      var userIndex = $(obj).data("index");
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "POST",
        url: "/home/approve_users.json",
        data: {"email":email,"project_name":$('#project-name-span').text(), "approved":userApproved},
        dataType: "json",
        success: function(response){
          var resStatus = response["user_status"]
          var colorCode = resStatus === "access approved" ? "green" : "red"
           $('#status-'+userIndex).text(resStatus);
           $('#status-'+userIndex).css("color", colorCode);
          }
      });
    })
  });
  /* listens on checkboxes on the user access management page & updates user approved access lists with AJAX calls */
  $('.user-list').on('change', function(){
      var access_approved = $(this).prop("checked") == true ? true : false
      var user_id = $(this).data("userid")
      var project_id = $(this).data("projectid")
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "POST",
        url: "/home/approve_users.json",
        data: {"user":user_id,"project":project_id, "approved":access_approved},
        dataType: "json",
        success: function(response){
          var resStatus = response["user_status"]
          var colorCode = resStatus === "access approved" ? "green" : "red"
           $('#status-'+userIndex).text(resStatus);
           $('#status-'+userIndex).css("color", colorCode);
          }
      });

  });
  $('#upload-priv-checkbox').on('change', function(){
    if ($(this).prop("checked") === false) {
      $('#project-name-box').val('');
      $('#project-name-box').prop('disabled',true)
    } else {
      $('#project-name-box').prop('disabled',false)
    }
  });
  /* listens on keyup events in the text box where users enter their proposed project names and relays to the controller to check for */

});