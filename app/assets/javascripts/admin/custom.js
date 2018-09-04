$(document).ready(function(){
  $('.froalaEditor').froalaEditor({
    imageUploadURL: '/upload_image',
    height: 300,
    requestHeaders: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });

  setActiveNavigation();

  //var continent_id = $('#league_continent_id').val();
  //loadContryByContinent(continent_id);

  $('#league_continent_id').on('change', function(){
    var continent_id = $(this).val();
    if(continent_id){
      loadContryByContinent(continent_id);
    }else{
      $('#league_country_id').empty();
    }
  });
});

function setActiveNavigation(){
  var path = window.location.pathname;
  path = path.replace(/\/$/, '');
  path = decodeURIComponent(path);
  $('.nav a').each(function(){
    var href = $(this).attr('href');
    if(path === href){
      $(this).closest('li').addClass('active');
    }
  });
};

function loadContryByContinent(continent_id){
  $.ajax({
    url: "/admin/continents/" + continent_id + "/load_countries",
    type: "GET",
    data: {
      id: continent_id
    },
    success: function(res){
      var country = $('#league_country_id');
      country.empty();
      for(var i in res){
        var option = '<option value='+ res[i][1] +'>'+ res[i][0] +'</option>';
        country.append(option);
      }
    }
  });
}
