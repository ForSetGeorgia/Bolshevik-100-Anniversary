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
  $(".nav-lang-toggle").click(function () {
    $(this).parent().toggleClass('active')
  })
  $(".nav-social-toggle").click(function () {
    $(this).parent().toggleClass('active')
  })

  if (isTouchDevice()) {
      var touchevent = ('ontouchstart' in window) ? 'touchstart' : ((window.DocumentTouch && document instanceof DocumentTouch) ? 'tap' : 'click');
      $(document).on(touchevent, '.story-container', function(e) {
        // console.log('test');
        $(this).toggleClass('hover');
        // e.stopPropagation();
        // e.preventDefault();
      })
    }
})
