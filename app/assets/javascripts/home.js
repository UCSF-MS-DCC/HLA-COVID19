$(document).on('turbolinks:load',function(){

  if (window.location.pathname === "/home/new_account_approval") {
    // when either an approve or remove button is clicked, disable the other option and send the params to the controller method.
    $('.approve-new-user-button').on('click', function() {
      var idx = $(this).data("index")
      var email = $(this).data("email")
      $('.remove-new-user-button[data-index="'+idx+'"]').prop('disabled', true )
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "POST",
        url: "/home/new_account_approval_handler.json",
        data: {"email":email, "approved":true, "suppress_from_approval_view":true},
        dataType: "json",
        success: function(response){
          console.log(response)
          if (response["accepted"] === "OK") {
            $('.approve-new-user-button[data-index="'+idx+'"]').html("Approved")
            $('.remove-new-user-button[data-index="'+idx+'"]').html("-")
            $('.approve-new-user-button[data-index="'+idx+'"]').prop('disabled', true)
            $('tr[data-index="'+idx+'"]').css('background-color', "green");
            } else {
              $('.approve-new-user-button[data-index="'+idx+'"]').html("Server Error")
              $('.approve-new-user-button[data-index="'+idx+'"]').prop('disabled', true)
              $('tr[data-index="'+idx+'"]').css('background-color', "yellow");
            }
          }
      });
    });

    $('.remove-new-user-button').on('click', function() {
      var idx = $(this).data("index")
      var email = $(this).data("email")
      $('.approve-new-user-button[data-index="'+idx+'"]').prop('disabled', true )
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "POST",
        url: "/home/new_account_approval_handler.json",
        data: {"email":email, "approved":false, "suppress_from_approval_view":true},
        dataType: "json",
        success: function(response){
          console.log(response)
          if (response["accepted"] === "OK") {
            $('.approve-new-user-button[data-index="'+idx+'"]').html("Rejected")
            $('.remove-new-user-button[data-index="'+idx+'"]').html("Removed")
            $('.remove-new-user-button[data-index="'+idx+'"]').prop('disabled', true)
            $('tr[data-index="'+idx+'"]').css('background-color', "red");
            } else {
              $('.approve-new-user-button[data-index="'+idx+'"]').html("Server Error")
              $('.remove-new-user-button[data-index="'+idx+'"]').prop('disabled', true)
              $('tr[data-index="'+idx+'"]').css('background-color', "yellow");
            }
          }
      });
    });
  }

    $.get('/home/age_data.json', function(response){

        adMatrix = response['data'];
        adMatrix.forEach(function(arr){
            arr.push('stroke-color: black; stroke-width: 2');
        });
        adMatrix.unshift(['Age', 'N', { role: 'style' } ]);

        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawAgeChart);
    
        function drawAgeChart() {
    
          var data = google.visualization.arrayToDataTable(adMatrix);
    
          var options = {
            title: 'Age',
            fontName: 'Josefin Sans',
            fontSize: '16',
            bar: {groupWidth: "61.8%"},
            legend: { position: "none" },
            width: "100%",
            height: 400,
            backgroundColor: { fill:'transparent' }
          };
    
          var chart = new google.visualization.ColumnChart(document.getElementById('age-chart'));
          chart.draw(data, options);
        }


    });

    $.get('/home/sex_data.json', function(response){

        sdMatrix = response['data'];
        sdMatrix.unshift(['Sex', 'N']);

        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawSexChart);
    
        function drawSexChart() {
    
          var data = google.visualization.arrayToDataTable(sdMatrix);
    
          var options = {
            fontName: 'Josefin Sans',
            fontSize: '16',
            title: 'Sex',
            bar: {groupWidth: "95%"},
            legend: { position: "bottom" },
            width: "95%",
            height: 400,
            backgroundColor: { fill:'transparent' }
          };
    
          var chart = new google.visualization.PieChart(document.getElementById('sex-chart'));
          chart.draw(data, options);
        }
    });

    $('#reg-chkbox').on('change', function() {
      if ($(this).prop('checked') == true) {
        $('#new_registration_submit').prop('disabled',false);
      } else {
        $('#new_registration_submit').prop('disabled',true);
      }
    })

});
