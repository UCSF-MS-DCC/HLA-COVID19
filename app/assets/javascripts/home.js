$(document).on('turbolinks:load',function(){

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
            bar: {groupWidth: "61.8%"},
            legend: { position: "none" },
            width: "100%",
            height: 400
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
            title: 'Sex',
            bar: {groupWidth: "95%"},
            legend: { position: "bottom" },
            width: "95%",
            height: 400,
          };
    
          var chart = new google.visualization.PieChart(document.getElementById('sex-chart'));
          chart.draw(data, options);
        }
    });

    $.get('/home/ethnicity_data.json', function(response){

        edMatrix = response['data'];
        edMatrix.unshift(['Ethnicity', 'N']);

        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawEthnicityChart);
    
        function drawEthnicityChart() {
    
          var data = google.visualization.arrayToDataTable(edMatrix);
    
          var options = {
            title: 'Ethnicity',
            bar: {groupWidth: "95%"},
            legend: { position: "bottom" },
            width: "95%",
            height: 400,
            colors:['purple','green','orange','blue']
          };
    
          var chart = new google.visualization.PieChart(document.getElementById('ethnicity-chart'));
          chart.draw(data, options);
        }
    });


});
