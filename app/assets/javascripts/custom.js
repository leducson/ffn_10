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
});
