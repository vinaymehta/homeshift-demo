$(document).ready(function(){
  $('#search-btn').click(function(){
    $('#results').hide();
    var search_text = $('#search-text').val();
    if(search_text == '' || search_text == undefined){
      alert('Please enter a zipcode');
    } else {
      $('#loading').show();
      $.ajax({
        url: "/search.js",
        data: {
          search_text: search_text
        }
      });
    }
  });
});
