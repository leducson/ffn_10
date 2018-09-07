$(document).ready(function(){
  $('.froalaEditor').froalaEditor({
    imageUploadURL: '/upload_image',
    height: 300,
    requestHeaders: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });

  setActiveNavigation();

  $('#league_continent_id').on('change', function(){
    var continent_id = $(this).val();
    if(continent_id){
      loadContryByContinent(continent_id, 'league_country_id');
    }else{
      $('#league_country_id').empty();
    }
  });

  $('#team_continent_id').on('change', function(){
    var continent_id = $(this).val();
    if(continent_id){
      loadContryByContinent(continent_id, 'team_country_id');
    }else{
      $('#team_country_id').empty();
    }
  });

  $('#league_id').on('change', function(){
    var league_id = $(this).val();
    if(league_id){
      loadRoundsByLeague(league_id);
    }else{
      $('#match_round_id').empty();
    }
  });

  $('.team_modal').on('click', function(){
    $('#new_team').modal({
      backdrop: 'static'
    });
  });

  $('.round_modal').on('click', function(){
    $('#new_round').modal({
      backdrop: 'static'
    })
  });

  $('#new_team, #new_round').on('hidden.bs.modal', function () {
    location.reload();
  });

  $('.set_team').on("click", function(){
    var team_id = $('.team_choice').val();
    var league_id = $(this).attr('data-id');
    if(team_id){
      $.ajax({
        url: '/admin/teams/' + team_id + '/set_league',
        type: 'PATCH',
        data: {
          id: team_id,
          league_id: league_id
        },
        success: function(res){
          if(res.type == 'success'){
            toastr.success('', res.message);
            $('option:selected', '.team_choice').remove();
          }else{
            toastr.error('', res.message);
          }
        }
      });
    }else{
      toastr.error('', I18n.t("js.select_team"));
    }
  });

  $('#league_new_team').submit(function(){
    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      dataType: 'json',
      data: $(this).serialize(),
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
        }else{
          toastr.error('', res.message);
        }
      }
    });
    return false;
  });

  $('#league_new_round').submit(function(){
    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      dataType: 'json',
      data: $(this).serialize(),
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
        }else{
          toastr.error('', res.message);
        }
      }
    });
    return false;
  });

  $('body').on('click', '.round_info', function(){
    $(this).parents('li').find('.team_name span').hide();
    $(this).parents('li').find('.team_name input').show();
    $(this).parents('li').find('.save-button').show();
    $(this).parents('li').find('.edit-button').hide();
  });

  $('body').on('click', '.undo-button', function(){
    reset_round_edit('undo-button');
  });

  $('body').on('click', '.save-round', function(){
    var round_id = $(this).parents('li').attr('data-id');
    var round_edit = $(this).parents('li').find('.team_name input').val();
    $.ajax({
      url: '/admin/rounds/' + round_id,
      type: 'PATCH',
      dataType: 'json',
      data:{
        'round[id]': round_id,
        'round[name]': round_edit
      },
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
          reset_round_edit('save-round');
          $('.round').load(location.href + ' .round');
        }else{
          toastr.error('', res.message);
        }
      }
    });
  });
});

function reset_round_edit(button){
  $('.' + button).parents('li').find('.team_name span').show();
  $('.' + button).parents('li').find('.team_name input').hide();
  $('.' + button).parents('li').find('.edit-button').show();
  $('.' + button).parents('li').find('.save-button').hide();
}

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

function loadContryByContinent(continent_id, country_select){
  $.ajax({
    url: '/admin/continents/' + continent_id + '/load_countries',
    type: 'GET',
    data: {
      id: continent_id
    },
    success: function(res){
      var country = $('#' + country_select);
      country.empty();
      for(var i in res){
        var option = '<option value='+ res[i][1] +'>'+ res[i][0] +'</option>';
        country.append(option);
      }
    }
  });
}

function loadRoundsByLeague(league_id){
  $.ajax({
    url: '/admin/matches/load_rounds',
    type: 'GET',
    dataType: 'JSON',
    data: {
      league_id: league_id
    },
    success: function(res){
      var round = $('#match_round_id');
      round.empty();
      for(var i in res){
        var option = '<option value='+ res[i][1] +'>'+ res[i][0] +'</option>';
        round.append(option);
      }
    }
  });
}
