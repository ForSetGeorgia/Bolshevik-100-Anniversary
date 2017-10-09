function setupStoryDatePicker() {
  if($('input#story_published_at').length > 0){
    // load the date pickers
    $('#story_published_at').datepicker({
        dateFormat: 'yy-mm-dd',
    });

    if (gon.published_at !== undefined &&
        gon.published_at.length > 0)
    {
      $("#story_published_at").datepicker("setDate", new Date(gon.published_at));
    }
  }

}

