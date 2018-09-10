$(document).ready(function(){
  $('body').on('click', '#myBets', function(){
    var id = $(this).attr('data-id');
    if($('#myDropdown-' + id).hasClass('show')){
      $('#myDropdown-' + id).removeClass('show');
    }else{
      $('.dropdown-content').removeClass('show');
      $('#myDropdown-' + id).addClass('show');
    }
  });

  //Score bets
  $('body').on('click', '#btnBet', function(){
    var id = $(this).parents('.event_bet').attr('data-id');
    var price = $(this).parents('.event_bet').find('.bet_amount_' + id).val()
    if(price > 0){
      $.ajax({
        url: '/score_bets',
        type: 'POST',
        data: {
          sugest_id: id,
          price: price
        },
        success: function(res){
          if(res.type == 'success'){
            toastr.success('', res.message);
          }else {
            toastr.error('', res.message);
          }
        }
      });
    }else{
      toastr.error('', I18n.t('js.money_blank'));
    }
  });

  // Match info
  $('body').on('click', '#info', function(){
    var id = $(this).attr('data-id');
    if($('#match_info-' + id).hasClass('show')){
      $('#match_info-' + id).removeClass('show');
    }else{
      $('.dropdown-content').removeClass('show');
      $('.match_info').removeClass('show');
      $('#match_info-' + id).addClass('show');
    }
  });

  //show continent and country
  $('#continent_id').on('change', function(){
    var continent_id = $(this).val();
    if(continent_id){
      loadCountryByContinent(continent_id);
    }else{
      $('#country_id').empty();
    }
  });

  // show clups
  $('body').on('click', '#btnTeams', function(){
    var country_id = $('#country_id').val();
  });
});

function loadCountryByContinent(continent_id){
  $.ajax({
    url: '/teams/load_countries',
    type: 'GET',
    data: {
      id: continent_id,
    },
    success: function(res){
      var country = $('#country_id');
      country.empty();
      for(var i in res){
        var option = '<option value='+ res[i][1] +'>'+ res[i][0] +'</option>';
        country.append(option);
      }
    }
  });
}
