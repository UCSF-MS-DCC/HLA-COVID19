$(document).on('turbo:load', () => {
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

  /* JQUERY API CALLS TO GET DASHBOARD DATA AND DRAW CHARTS. ONLY RUN THESE FOR HOME#INDEX */
  if (window.location.pathname === "/") {
    /* CONTRIBUTORS TABLE */
    $.get('/home/contributor_table_data.json', function(response){
      google.charts.load('current', {'packages':['table']});
      google.charts.setOnLoadCallback(drawContributorTable);

      function drawContributorTable() {
        var dt = new google.visualization.DataTable();
        response["data"]["colnames"].forEach(function(column){
          dt.addColumn('string', column);
         });
        for(let member in response["data"]["members"]) {
            var url = response["data"]["members"][member]["pub_url"] ? '<a href='+response["data"]["members"][member]["pub_url"]+' target="_blank" rel="noopener noreferrer">Link</a>' : '-'
          dt.addRow([member, response["data"]["members"][member]["n"].toString(), url])
        };

        var table = new google.visualization.Table(document.getElementById('contributor-chart'));

        table.draw(dt, {showRowNumber: true, width: '100%', height: '100%', allowHtml: true});
      }
    });
    /* SEX PIE CHART */
    $.get('/home/sex_data.json', function(response){
      let sdMatrix = response['data'];
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
    /* AGE HISTOGRAM */
    $.get('/home/age_data.json', function(response){

      let adMatrix = response['data'];
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

    /* ALLELE FREQUENCY HISTOGRAMS */
    $('.allele-freq-chart').each(function(){
      var gene = $(this).data("gene");
      var element_id = $(this).prop("id")

      $.get('/home/allele_freq_data.json?gene='+gene, function(response){
        google.charts.load("current", {packages:['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
          var data = google.visualization.arrayToDataTable(response["data"]);
          var numberFormat = new google.visualization.NumberFormat(
            {pattern:'#.#####'}
          );
          numberFormat.format(data, 1);
          var view = new google.visualization.DataView(data);
          var options = {
            title: "HLA-"+gene.toUpperCase(),
            height: 400,
            backgroundColor: "transparent",
            bar: { groupWidth: "61.8%"},
            legend: { position: "none" },
            vAxis: { logScale: true }
          };

          var chart = new google.visualization.ColumnChart(document.getElementById(element_id));
          chart.draw(view, options);
        }
      });
    });
  }

  $('#reg-chkbox').on('change', function() {
    if ($(this).prop('checked') == true) {
      $('#new_registration_submit').prop('disabled',false);
    } else {
      $('#new_registration_submit').prop('disabled',true);
    }
  });

  // $('#subjects-datatable').dataTable({
  //   "processing": true,
  //   "serverSide": true,
  //   "ajax": {
  //     "url": $('#subjects-datatable').data('source')
  //   },
  //   //"dom":"lBfrtip",
  //   "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
  //   "buttons": ['csv', 'pdf'],
  //   "pagingType": "full_numbers",
  //   "columns": [
  //     {"data": "hlac19_id"},
  //     {"data": "origin_identifier"},
  //     {"data": "sex"},
  //     {"data": "age"},
  //     {"data": "height_cm"},
  //     {"data": "weight_kg"}
  //   ]
  //   // pagingType is optional, if you want full pagination controls.
  //   // Check dataTables documentation to learn more about
  //   // available options.
  // });
  // $('#c19-symptoms-datatable').dataTable({
  //   "processing": true,
  //   "serverSide": true,
  //   "scrollX":true,
  //   "ajax": {
  //     "url": $('#c19-symptoms-datatable').data('source')
  //   },
  //   "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
  //   "buttons": ['csv', 'pdf'],
  //   "pagingType": "full_numbers",
  //   "columns": [
  //     {"data": "hlac19_id"},
  //     {"data": "origin_identifier"},
  //     {"data": "dry_cough"},
  //     {"data": "mucus_cough"},
  //     {"data": "days_cough"},
  //     {"data": "difficulty_breathing"},
  //     {"data": "fever"},
  //     {"data": "highest_temp"},
  //     {"data": "days_fever"},
  //     {"data": "fatigue"},
  //     {"data": "pain_chest_heart"},
  //     {"data": "pain_back"},
  //     {"data": "runny_nose"},
  //     {"data": "sore_throat"},
  //     {"data": "loss_taste_smell"},
  //     {"data": "diarrhea"},
  //     {"data": "nausea"},
  //     {"data": "other_symptoms"},
  //     {"data": "c19_test_result_positive"},
  //     {"data": "type_of_c19_test"}
  //   ]
  //   // pagingType is optional, if you want full pagination controls.
  //   // Check dataTables documentation to learn more about
  //   // available options.
  // });
  // $('#hla-datatable').dataTable({
  //   "processing": true,
  //   "serverSide": true,
  //   //"scrollX":true,
  //   "initComplete": function (settings, json) {  
  //     $("#hla-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
  //   },
  //   "ajax": {
  //     "url": $('#hla-datatable').data('source')
  //   },
  //   "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
  //   "buttons": ['csv', 'pdf'],
  //   "pagingType": "full_numbers",
  //   "columns": [
  //     {"data": "drb1_1"},
  //     {"data": "drb1_2"},
  //     {"data": "dqb1_1"},
  //     {"data": "dqb1_2"},
  //     {"data": "dpb1_1"},
  //     {"data": "dpb1_2"},
  //     {"data": "a_1"},
  //     {"data": "a_2"},
  //     {"data": "b_1"},
  //     {"data": "b_2"},
  //     {"data": "c_1"},
  //     {"data": "c_2"},
  //     {"data": "dpa1_1"},
  //     {"data": "dpa1_2"},
  //     {"data": "dqa1_1"},
  //     {"data": "dqa1_2"},
  //     {"data": "drbo_1"},
  //     {"data": "drbo_2"},
  //     {"data": "drb345_1"},
  //     {"data": "drb345_2"},
  //     {"data": "reference_database"},
  //     {"data": "reference_database_version"},
  //     {"data": "typing_method_name"},
  //     {"data": "typing_method_version"},
  //     {"data": "gl_string"},
  //     {"data": "novel_polymorphisms"},
  //     {"data": "pop"}
  //   ]
  //   // pagingType is optional, if you want full pagination controls.
  //   // Check dataTables documentation to learn more about
  //   // available options.
  // });

  // $('.dt-button').addClass('btn btn-primary');

});
