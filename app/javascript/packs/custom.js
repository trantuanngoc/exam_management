$(document).ready(function() {
  $( "#add_answer" ).click(function() {
    $("#answer_div").append(
      $('<input>').prop({
        type: 'radio',
        value: $("#question_answers_attributes__content").val(),
        name: 'question[right_answer]',
        class: "radio-inline"
      })
    );
    $("#question_answers_attributes__content").clone().attr("id", null).appendTo("#answer_div");
    $("#question_answers_attributes__content").val("");
  });
  $(".selectpicker").selectpicker();
});
