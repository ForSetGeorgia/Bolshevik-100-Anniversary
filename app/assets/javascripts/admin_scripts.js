
//= require jquery
//= require jquery_ujs
//= require jquery-ui/datepicker

////////////////////////////////////////
///////  Load dependencies here  ///////

// Bootstrap Javascript
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/scrollspy
//= require twitter/bootstrap/tab
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/popover
//= require twitter/bootstrap/button
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/carousel
//= require twitter/bootstrap/affix

//= require ckeditor/init

//= require_tree .


(function() {

  $(document).ready(function() {
    setupStoryDatePicker();
    RMRichTextArea.load();
  });

})();


