module UploadHelper
    # creates a master list of valid column headers for each table
    def valid_colnames
        Subject.column_names.reject{ |cn| ["created_at", "updated_at", "id", "hlac19_id"].include? cn }.concat(
        C19Symptom.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat(
        Comorbidity.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat(
        Hla.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat(
        Hospitalization.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat(
        LabTest.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat(
        RiskFactor.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn }).concat( 
        Treatment.column_names.reject{ |cn| ["created_at", "updated_at", "id", "subject_id"].include? cn })
    end
    # this checks the headers in an uploaded CSV file against the schema table headers and returns headers not found in the schema
    def check_headers(csvHeaders)
        bad_headers = csvHeaders.reject{ |h| valid_colnames.include? h }
        headers_ok = bad_headers.size > 0 ? false : true
        { :form_ok => headers_ok, :bad_headers => bad_headers }
    end
    # this separates the one long CSV row into smaller hashes aligned to each table's variables.
    def parse_row(row)
        {
            :subject => parse_subject_fields(row),
            :c19_symptom => parse_c19symptom_fields(row),
            :comorbidity => parse_comorbidity_fields(row),
            :hla => parse_hla_fields(row),
            :hospitalization => parse_hospitalization_fields(row),
            :labtest => parse_labtest_fields(row),
            :riskfactor => parse_riskfactor_fields(row),
            :treatment => parse_treatment_fields(row)
        }
    end
    def parse_row_longitudinal(row)
        {
            :subject => parse_subject_fields(row),
            :c19_symptom => parse_c19symptom_fields(row),
            :comorbidity => nil,
            :hla => nil,
            :hospitalization => parse_hospitalization_fields(row),
            :labtest => parse_labtest_fields(row),
            :riskfactor => nil,
            :treatment => parse_treatment_fields(row)
        }
    end
    # these methods extract values from the csv row that match variable names in the table the methods are named after.
    # if there are no values for a particular table's variables, nil is returned.
    def parse_subject_fields(row)
        sub_params = row.select{ |k,v| Subject.column_names.include? k } 
        sub_params = Hash[sub_params.collect{ |arr| [arr[0], arr[1]] } ] 
        sub_params.values.reject{ |v| v == nil }.count > 0 ? sub_params : nil
    end

    def parse_c19symptom_fields(row)
        c19_params = row.select{ |k,v| C19Symptom.column_names.include? k } 
        c19_params = Hash[c19_params.collect{ |arr| [arr[0], arr[1]] } ] 
        c19_params.values.reject{ |v| v == nil }.count > 0 ? c19_params : nil
    end

    def parse_comorbidity_fields(row)
        com_params = row.select{ |k,v| Comorbidity.column_names.include? k } 
        com_params = Hash[com_params.collect{ |arr| [arr[0], arr[1]] } ] 
        com_params.values.reject{ |v| v == nil }.count > 0 ? com_params : nil
    end

    def parse_hla_fields(row)
        hla_params = row.select{ |k,v| Hla.column_names.include? k } 
        hla_params = Hash[hla_params.collect{ |arr| [arr[0], arr[1]] } ] 
        hla_params.values.reject{ |v| v == nil }.count > 0 ? hla_params : nil
    end

    def parse_hospitalization_fields(row)
        hzn_params = row.select{ |k,v| Hospitalization.column_names.include? k } 
        hzn_params = Hash[hzn_params.collect{ |arr| [arr[0], arr[1]] } ] 
        hzn_params.values.reject{ |v| v == nil }.count > 0 ? hzn_params : nil
    end

    def parse_labtest_fields(row)
        lab_params = row.select{ |k,v| LabTest.column_names.include? k } 
        lab_params = Hash[lab_params.collect{ |arr| [arr[0], arr[1]] } ] 
        lab_params.values.reject{ |v| v == nil }.count > 0 ? lab_params : nil
    end

    def parse_riskfactor_fields(row)
        rkf_params = row.select{ |k,v| RiskFactor.column_names.include? k } 
        rkf_params = Hash[rkf_params.collect{ |arr| [arr[0], arr[1]] } ] 
        rkf_params.values.reject{ |v| v == nil }.count > 0 ? rkf_params : nil
    end

    def parse_treatment_fields(row)
        tmt_params = row.select{ |k,v| Treatment.column_names.include? k } 
        tmt_params = Hash[tmt_params.collect{ |arr| [arr[0], arr[1]] } ] 
        tmt_params.values.reject{ |v| v == nil }.count > 0 ? tmt_params : nil
    end
    # this builds and saves subject-related models 
    def build_relations(sub, data)
        unless !data[:c19_symptom]
            @c19 = C19Symptom.new(data[:c19_symptom])
            @c19[:subject_id] = sub.id
            @c19.save
        end
        unless !data[:comorbidity]
            #sub.build_comorbidity(data[:comorbidity]).save
            @com = Comorbidity.new(data[:comorbidity])
            @com[:subject_id] = sub.id
            @com.save
        end
        unless !data[:hla]
            #sub.build_hla(data[:hla]).save
            @hla = Hla.new(data[:hla])
            @hla[:subject_id] = sub.id
            @hla.save
        end
        unless !data[:hospitalization]
            #sub.build_hospitalization(data[:hospitalization]).save
            @hos = Hospitalization.new(data[:hospitalization])
            @hos[:subject_id] = sub.id
            @hos.save
        end
        unless !data[:labtest]
            #sub.build_lab_test(data[:labtest]).save
            @lab = LabTest.new(data[:labtest])
            @lab[:subject_id] = sub.id
            @lab.save
        end
        unless !data[:riskfactor]
            #sub.build_risk_factor(data[:risk_factor]).save
            @rf = RiskFactor.new(data[:risk_factor])
            @rf[:subject_id] = sub.id
            @rf.save
        end
        unless !data[:treatment]
            #sub.build_treatment(data[:treatment]).save
            @tmt = Treatment.new(data[:treatment])
            @tmt[:subject_id] = sub.id
            @tmt.save
        end
    end

end