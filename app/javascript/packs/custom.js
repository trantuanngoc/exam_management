var countDownTime;
$(document).on('turbolinks:load', function(){
  $('.selectpicker').selectpicker("refresh");
  countDownTime = new Date($(".temp_information").data("temp"));

  $(".edit_user_exam").find("input").change(function(){
    var answer_id = $(this).val() ;
    var question_id = $(this).siblings("input").val();
    var user_exam_id = $(".temp_information").data("id");

    $.ajax({
      url: '/user_exams/save',
      type: 'POST',
      data: {
        answer_id,
        question_id,
        user_exam_id
      }
    }).done(function(){
    });
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
      $(".edit_user_exam").submit();
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
