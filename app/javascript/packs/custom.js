var countDownTime;
function setCookie(name, value){
  var today = new Date();
  var expiry = new Date(today.getTime() + 30 * 24 * 3600 * 1000);
  document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expiry.toGMTString();
}
function getCookie(cname){
  var name = cname + "=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for(var i = 0; i <ca.length; i++){
    var c = ca[i];
    while (c.charAt(0) == ' '){
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0){
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

$("#new_user_exam").load(function(){
  $(".form-check radio").each(function(){
    if($(this).val() == getCookie($(this).attr("name")))
      $(this).prop('checked', true);
  });
});

$(document).on('turbolinks:load', function(){
  $('.selectpicker').selectpicker("refresh");

  $(".start").click(function(){
    var d = new Date();
    d.setMinutes(d.getMinutes() + 30);
    countDownTime = d.getTime();
    setCookie("countDownTime", countDownTime);
  });

  $(".new_user_exam input").change(function(){
    setCookie($(this).attr("name"), $(this).val());
  });

  var x = setInterval(function(){
    var now = new Date().getTime();
    var distance = countDownTime - now;

    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);


    $("#hour").html(hours);
    $("#minute").html(minutes);
    $("#second").html(seconds);

    if (distance < 0) {
      clearInterval(x);
      $("#demo").html("TIME UP");
      $(".hours").html(0);
      $(".minutes").html(0);
      $(".seconds").html(0);
      $("#new_user_exam").submit();
    }
  }, 1000);

  $("#profile_image").bind("change", function(){
    const size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5){
      alert("Maximum file size is 5MB. Please choose a smaller file.");
      $("#profile_image").val("");
    }
  });

  $(".custom-file-input").on("change", function(){
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });




});
