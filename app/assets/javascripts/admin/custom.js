$(document).ready(function(){
  $('.froalaEditor').froalaEditor({
    imageUploadURL: '/upload_image',
    height: 300,
    requestHeaders: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });

  setActiveNavigation();
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
