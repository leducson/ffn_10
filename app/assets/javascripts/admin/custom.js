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

  $('#match_info_team_id').on('change', function(){
    var team_id = $(this).val();
    if(team_id){
      load_players_by_team(team_id);
    }else{
      $('#match_info_player_info_id').empty();
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

  $('.match_info_modal').on('click', function(){
    $('#match_info_matches').modal({
      backdrop: 'static'
    });
  });

  $('.modal_new_score_sugest').on('click', function(){
    $('#new_score_sugest').modal({
      backdrop: 'static'
    });
  });

  $('.add_new_player').on('click', function(){
    $('#new_player').modal({
      backdrop: 'static'
    })
  });

  $('.modal_new_match_result').on('click', function(){
    $('#new_match_result').modal({
      backdrop: 'static'
    });
  });

  $('body').on('click', '.submit_match_result', function(){
    var team_id = $('#team_id option:selected').val();
    var score = $(this).parents('div.form_new').find('#score').val();
    var match_id = $(this).parents('div.form_new').find('#match_id').val();
    if(team_id){
      $.ajax({
        url: '/admin/match_results',
        type: 'POST',
        data: {
          'match_result[team_id]': team_id,
          'match_result[score]': score,
          'match_result[match_id]': match_id
        },
        success: function(res){
          if(res.type == 'success'){
            toastr.success('', res.message);
            $('#team_id').val('');
          }else{
            toastr.error('', res.message);
          }
        }
      });
    }else{
      toastr.error('', I18n.t("js.select_team"));
    }
  });

  $('body').on('click', '.match_result_edit', function(){
    $(this).parents('tr').find('span.score_result').hide();
    $(this).parents('tr').find('input.input_match_result').show();
    $(this).parents('tr').find('.edit_result').hide();
    $(this).parents('tr').find('.update_result').show();
  });

  $('body').on('click', '.match_result_reset', function(){
    reset_match_result_layout('match_result_reset');
  });

  $('body').on('click', '.match_result_update', function(){
    var id = $(this).parents('tr').attr('data-id');
    var score = $(this).parents('tr').find('input.input_match_result').val();
    $.ajax({
      url: '/admin/match_results/' + id,
      type: 'PATCH',
      data: {
        'match_result[score]': score
      },
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
          reset_match_result_layout('match_result_update');
          $('.table_match_result').load(location.href + ' .table_match_result');
        }else{
          toastr.error('', res.message);
        }
      }
    });
  });

  $('#new_team, #new_round, #match_info_matches, #new_score_sugest, #new_player,  #new_match_result').on('hidden.bs.modal', function () {
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

  $('.set_player_info').click(function(){
    var player_id = $('.player_choice').val();
    var team_id = $(this).attr('data-id');
    if(team_id){
      $.ajax({
        url: '/admin/players/' + player_id + '/set_player_by_team',
        type: 'PATCH',
        dataType: 'JSON',
        data: {
          id: player_id,
          team_id: team_id
        },
        success: function(res){
          if(res.type == 'success'){
            toastr.success('', res.message);
            $('option:selected', '.player_choice').remove();
          }else{
            toastr.error('', res.message);
          }
        }
      });
    }else{
      toastr.error('', I18n.t("js.select_player"));
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

  $('#matches_match_info').submit(function(){
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

  $('#match_new_score_sugest').submit(function(){
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

  $('#team_new_player').submit(function(){
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

  $('body').on('click', '.score_sugest_edit', function(){
    $(this).parents('tr').find('.edit-sugest').hide();
    $(this).parents('tr').find('.update-sugest').show();
    $(this).parents('tr').find('span').hide();
    $(this).parents('tr').find('input').show();
  });

  $('body').on('click', '.undo-button', function(){
    reset_round_edit('undo-button');
  });

  $('body').on('click', '.sugest-undo', function(){
    $(this).parents('tr').find('.edit-sugest').show();
    $(this).parents('tr').find('.update-sugest').hide();
    $(this).parents('tr').find('span').show();
    $(this).parents('tr').find('input').hide();
  });

  $('body').on('click', '.edit_button_rank', function(){
    $(this).parents('tr').find('span.rank_number').hide();
    $(this).parents('tr').find('input.edit_rank').show();
    $(this).parents('tr').find('.edit_rank_button').hide();
    $(this).parents('tr').find('.update_rank_button').show();
  });

  $('body').on('click', '.edit_score_bet', function(){
    $(this).parents('tr').find('span.score_bet_price').hide();
    $(this).parents('tr').find('input.edit_price_bet').show();
    $(this).parents('tr').find('.edit_button_bet').hide();
    $(this).parents('tr').find('.update_button_bet').show();
  });

  $('body').on('click', '.reset_score_bet', function(){
    reset_score_bet('reset_score_bet');
  });

  $('body').on('click', '.reset_button_rank', function(){
    reset_rank_edit('reset_button_rank');
  });

  $('body').on('click', '.score_sugest_update', function(){
    var id = $(this).parents('tr').attr('data-id');
    $.ajax({
      url: '/admin/score_sugests/' + id,
      type: 'PATCH',
      dataType: 'json',
      data:{
        'score_sugest[score_win]': $(this).parents('tr').find('input.score_win').val(),
        'score_sugest[score_lost]': $(this).parents('tr').find('input.score_lost').val(),
        'score_sugest[ratio]': $(this).parents('tr').find('input.ratio').val(),
      },
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
          reset_sugest_edit('score_sugest_update');
          $('.table_sugest').load(location.href + ' .table_sugest');
        }else{
          toastr.error('', res.message);
        }
      }
    });
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

  $('body').on('click', '.update_button_rank', function(){
    var rank_id = $(this).parents('tr').attr('data-id');
    var rank_number = $(this).parents('tr').find('input.edit_rank').val();
    $.ajax({
      url: '/admin/rankings/' + rank_id,
      type: 'PATCH',
      dataType: 'json',
      data:{
        'ranking[id]': rank_id,
        'ranking[rank]': rank_number
      },
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
          reset_rank_edit('reset_button_rank');
          $('.rankings').load(location.href + ' .rankings');
        }else{
          toastr.error('', res.message);
        }
      }
    });
  });

  $('body').on('click', '.update_score_bet', function(){
    var bet_id = $(this).parents('tr').attr('data-id');
    var bet_price = $(this).parents('tr').find('input.edit_price_bet').val();
    $.ajax({
      url: '/admin/score_bets/' + bet_id,
      type: 'PATCH',
      dataType: 'json',
      data:{
        'score_bet[id]': bet_id,
        'score_bet[price]': bet_price
      },
      success: function(res){
        if(res.type == 'success'){
          toastr.success('', res.message);
          reset_score_bet('reset_score_bet');
          $('.score_bets').load(location.href + ' .score_bets');
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

function reset_sugest_edit(btn){
  $('.' + btn).parents('tr').find('.edit-sugest').show();
  $('.' + btn).parents('tr').find('.update-sugest').hide();
  $('.' + btn).parents('tr').find('span').show();
  $('.' + btn).parents('tr').find('input').hide();
}

function reset_rank_edit(btn){
  $('.' + btn).parents('tr').find('span.rank_number').show();
  $('.' + btn).parents('tr').find('input.edit_rank').hide();
  $('.' + btn).parents('tr').find('.edit_rank_button').show();
  $('.' + btn).parents('tr').find('.update_rank_button').hide();
}

function reset_score_bet(btn){
  $('.' + btn).parents('tr').find('span.score_bet_price').show();
  $('.' + btn).parents('tr').find('input.edit_price_bet').hide();
  $('.' + btn).parents('tr').find('.edit_button_bet').show();
  $('.' + btn).parents('tr').find('.update_button_bet').hide();
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

function load_players_by_team(team_id){
  $.ajax({
    url: '/admin/teams/' + team_id + '/load_players_by_team',
    type: 'GET',
    dataType: 'JSON',
    data: {
      id: team_id
    },
    success: function(res){
      var player = $('#match_info_player_info_id');
      player.empty();
      for(var i in res){
        var option = '<option value=' + res[i][0] + '>' + res[i][1] + ' (' + res[i][2] + ')</option>';
        player.append(option);
      }
    }
  });
}

function reset_match_result_layout(btn){
  $('.' + btn).parents('tr').find('span.score_result').show();
  $('.' + btn).parents('tr').find('input.input_match_result').hide();
  $('.' + btn).parents('tr').find('.edit_result').show();
  $('.' + btn).parents('tr').find('.update_result').hide();
}
