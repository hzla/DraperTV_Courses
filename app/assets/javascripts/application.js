// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

// = require jquery
// = require jquery-ui
// = require nprogress-turbolinks
// = require jquery_ujs
// = require jquery.infinitescroll
// = require jquery.autosize
// = require underscore
// = require gmaps/google
// = require chosen
// = require home
// = require_tree .
// = require private_pub
// = require slidebars.min
// = require turbolinks


NProgress.configure
  showSpinner: false
  ease: 'ease'
  speed: 500


function contains(arr, value) {
    var i = arr.length;
    while (i--) {
        if (arr[i] === value) return true;
    }
    return false;
}

