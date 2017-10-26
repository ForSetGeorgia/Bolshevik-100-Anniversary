//= require jquery

function isTouchDevice() {
  return (
    !!(typeof window !== 'undefined' &&
      ('ontouchstart' in window ||
        (window.DocumentTouch &&
          typeof document !== 'undefined' &&
          document instanceof window.DocumentTouch))) ||
    !!(typeof navigator !== 'undefined' &&
      (navigator.maxTouchPoints || navigator.msMaxTouchPoints))
  );
}

$(document).ready(function () {
  $(".nav-toggle").click(function () {
    $(this).closest('.nav-menu').toggleClass('active')
  })
  $(".nav-social-toggle").click(function () {
    $(this).parent().toggleClass('active')
  })
  $(".social-toggle").click(function () {
    $(this).parent().toggleClass('active')
  })
  if (isTouchDevice()) {
    var touchevent = ('ontouchstart' in window) ? 'touchstart' : ((window.DocumentTouch && document instanceof DocumentTouch) ? 'tap' : 'click');
    $(document).on(touchevent, '.story-container', function(e) {
      $(this).toggleClass('hover');
    })
    $(document).on(touchevent, '.story-explore', function(e) {
      e.stopPropagation();
    })
  } else {
    $('.story-container').hover(function(e) {
      $(this).toggleClass('hover');
    })
  }
})
