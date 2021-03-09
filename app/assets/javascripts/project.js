$(document).on('turbolinks:load',function(){

$('#project-select-control').change(function(e){
    console.log($(this).val())
    var project_id = $(this).val();
    window.location.href = '/project/index/' + project_id;
})

$('#subjects-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "initComplete": function (settings, json) {  
        $('#subjects-datatable').wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#subjects-datatable').data('source')
    },
    //"dom":"lBfrtip",
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "hlac19_id"},
      {"data": "origin_identifier"},
      {"data": "sex"},
      {"data": "gender"},
      {"data": "education"},
      {"data": "age"},
      {"data": "ethnicity"},
      {"data": "pregnant"},
      {"data": "ancestry"},
      {"data": "height_cm"},
      {"data": "weight_kg"},
      {"data": "race"},
      {"data": "country_of_residence"},
      {"data": "vaccinated"},
      {"data": "vaccine_type"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#c19-symptoms-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    // "scrollX":true,
    "initComplete": function (settings, json) {  
        $('#c19-symptoms-datatable').wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#c19-symptoms-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"},       
      {"data": "dry_cough"},
      {"data": "mucus_cough"},
      {"data": "days_cough"},
      {"data": "difficulty_breathing"},
      {"data": "fever"},
      {"data": "highest_temp"},
      {"data": "days_fever"},
      {"data": "fatigue"},
      {"data": "pain_chest_heart"},
      {"data": "pain_back"},
      {"data": "runny_nose"},
      {"data": "sore_throat"},
      {"data": "loss_taste_smell"},
      {"data": "diarrhea"},
      {"data": "nausea"},
      {"data": "other_symptoms"},
      {"data": "c19_test_result_positive"},
      {"data": "type_of_c19_test"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#hla-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#hla-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#hla-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"},   
      {"data": "drb1_1"},
      {"data": "drb1_2"},
      {"data": "dqb1_1"},
      {"data": "dqb1_2"},
      {"data": "dpb1_1"},
      {"data": "dpb1_2"},
      {"data": "a_1"},
      {"data": "a_2"},
      {"data": "b_1"},
      {"data": "b_2"},
      {"data": "c_1"},
      {"data": "c_2"},
      {"data": "dpa1_1"},
      {"data": "dpa1_2"},
      {"data": "dqa1_1"},
      {"data": "dqa1_2"},
      {"data": "drbo_1"},
      {"data": "drbo_2"},
      {"data": "drb345_1"},
      {"data": "drb345_2"},
      {"data": "reference_database"},
      {"data": "reference_database_version"},
      {"data": "typing_method_name"},
      {"data": "typing_method_version"},
      {"data": "gl_string"},
      {"data": "novel_polymorphisms"},
      {"data": "pop"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#comorbidity-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#comorbidity-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#comorbidity-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "hiv"},
      {"data": "cd4_cell_count"},
      {"data": "hiv_load"},
      {"data": "immunocompromised"},
      {"data": "organ_transplant"},
      {"data": "organ_transplant_type"},
      {"data": "bone_marrow_transplant"},
      {"data": "autoimmune_rheum_disease"},
      {"data": "diabetes_type_1"},
      {"data": "diabetes_type_2"},
      {"data": "asthma"},
      {"data": "copd"},
      {"data": "cycstic_fib"},
      {"data": "liver_disease"},
      {"data": "gallbladder_disease"},
      {"data": "pancreas_disease"},
      {"data": "angio_coronary_intervention"},
      {"data": "artery_bypass"},
      {"data": "cong_heart_failure"},
      {"data": "hypertension"},
      {"data": "infarction_type_1"},
      {"data": "infarction_type_2"},
      {"data": "peri_vascular_dis"},
      {"data": "stroke"},
      {"data": "arythmia"},
      {"data": "dementia"},
      {"data": "neur_disease"},
      {"data": "leukemia"},
      {"data": "lymphoma"},
      {"data": "malignant_solid_tumor"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#hospitalization-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#hospitalization-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#hospitalization-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "icu_admit"},
      {"data": "icu_duration_days"},
      {"data": "reason_hosp_ended"},
      {"data": "septic_shock"},
      {"data": "days_after_c19_septic_shock"},
      {"data": "organ_failure"},
      {"data": "resp_failure"},
      {"data": "resp_rate_intake"},
      {"data": "resp_breath_per_min"},
      {"data": "blood_o2_sat"},
      {"data": "highest_resp_support"},
      {"data": "days_ventilator"},
      {"data": "pa02_min"},
      {"data": "fio2_max"},
      {"data": "lung_infiltrates"},
      {"data": "pneumonia"},
      {"data": "pneumonia_days_after_c19_symptoms"},
      {"data": "ef_echo"},
      {"data": "hepatitis"},
      {"data": "pancreatitis"},
      {"data": "pleural_effusion"},
      {"data": "acute_kidney_failure"},
      {"data": "acute_kidney_chronic"},
      {"data": "ascites"},
      {"data": "dyspnea"},
      {"data": "hospitalization_duration_days"},
      {"data": "hospitalization_admit"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#riskfactor-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#riskfactor-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#riskfactor-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "smoke_freq"},
      {"data": "alcohol_freq"},
      {"data": "substances_freq"},
      {"data": "smoke"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#labtest-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#labtest-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "beforeSend": function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      "type":"POST",
      "url": $('#labtest-datatable').data('source'),
      "data": function(d) { d.project_id = $('#labtest-datatable').data('project')},
      "contentType":"application/json",
      "dataType":"json"
    },
    // "ajax":{"url":'/project/labtest.json', "data": function(d) { d.disease = superindex_disease } }
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "blood_type"},
      {"data": "rh_factor"},
      {"data": "wbc"},
      {"data": "lymphocytes"},
      {"data": "neutrophils"},
      {"data": "monocytes"},
      {"data": "eosinophils"},
      {"data": "basophils"},
      {"data": "crp"},
      {"data": "trop_i"},
      {"data": "trop_t"},
      {"data": "bnp"},
      {"data": "idh"},
      {"data": "ast"},
      {"data": "alt"},
      {"data": "bilirubin"},
      {"data": "ggt"},
      {"data": "alp"},
      {"data": "d_dimer"},
      {"data": "il6"},
      {"data": "tumor_necrosis_factor"},
      {"data": "serum_femtin"},
      {"data": "hba1c"},
      {"data": "cholesterol"},
      {"data": "triglycerides"},
      {"data": "hdl"},
      {"data": "ldl"},
      {"data": "ace"},
      {"data": "ace2r"},
      {"data": "hemoglobin"},
      {"data": "amylase"},
      {"data": "lipase"},
      {"data": "urea"},
      {"data": "creatinine"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#treatment-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#treatment-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#treatment-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "ace_inhib"},
      {"data": "angio_blocker"},
      {"data": "antibiotics"},
      {"data": "antiviral_med"},
      {"data": "allergy_med"},
      {"data": "androgen_med"},
      {"data": "asthma_med"},
      {"data": "immunosuppressor_light"},
      {"data": "immunosuppressor_strong"},
      {"data": "biologics_mabs"},
      {"data": "nsaid"},
      {"data": "antipytetics"},
      {"data": "blood_thinner"},
      {"data": "vitamin_d_med"},
      {"data": "vitamin_c_med"},
      {"data": "med_udca"},
      {"data": "treatment_duration_days"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('#kir-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    //"scrollX":true,
    "initComplete": function (settings, json) {  
      $("#kir-datatable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");            
    },
    "ajax": {
      "url": $('#kir-datatable').data('source')
    },
    "dom": "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    "buttons": [{ 'extend':'csv', 'text': 'Download CSV' }],
    "pagingType": "full_numbers",
    "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "All"]],
    "columns": [
      {"data": "id"},
      {"data": "hlac19_id"},
      {"data": "origin_identifier"}, 
      {"data": "k2dl4_1"},
      {"data": "k2dl4_2"},
      {"data": "k2dl23_1"},
      {"data": "k2dl23_2"},
      {"data": "k3dl1s1_1"},
      {"data": "k3dl1s1_2"},
      {"data": "k3dl2_1"},
      {"data": "k3dl2_2"},
      {"data": "k3dl3_1"},
      {"data": "k3dl3_2"},
      {"data": "k2dl1_1"},
      {"data": "k2dl1_2"}
    ],
    "columnDefs": [
        { "visible": false, "targets": 0 },
        { "orderable": false, "targets": [1,2] }
      ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
  $('.dt-button').addClass('btn btn-download');
});
