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
//= require turbolinks
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

window.callout = (type, msg) => {
  if(msg.length == 0) return false;
  var $obj = $(`.callout.${type}`).text(msg).show();
  setTimeout(function() { $obj.fadeOut() }, 1000);
  return true
}

window.show_error = function(msg) {
  return window.callout('alert', msg) && false
}

window.show_success = msg => {
  window.callout('success', msg)
}
