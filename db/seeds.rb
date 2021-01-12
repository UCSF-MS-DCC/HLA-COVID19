# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count > 0
    User.delete_all
end
if Project.count > 0
    Project.delete_all
end
if Subject.count > 0
    Subject.delete_all
end

# admin user account
User.new(email:"dev@dev.org", password:"321321", password_confirmation:"321321", affiliation:"UCSF", can_upload:true, approved:true, firstname:"Admin", lastname:"User").save(validate:false)
# # create separate domains for different users
domains = [Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name].uniq
# create project owner accounts
domains.each do |d|
    @user = User.new(email:Faker::Internet.email, password:"321321", password_confirmation:"321321", can_upload:true, approved:true, project_owner:true ,firstname:Faker::Name.first_name, lastname:Faker::Name.last_name)
    @user.save(validate:false)
    project = Project.new(user_id:@user.id, name:d)
    project.save
end
# create general user accounts
# 4.times do
#     user = User.new(email:"#{Faker::Internet.email}", password:"321321", password_confirmation:"321321", can_upload:true, approved:true)
#     user.save(validate:false)
# end

def get_value(val_type)
    case val_type
    when "integer"
         Faker::Number.between(from:1, to: 20)
    when "string"
        Faker::Lorem.words(number: 1)[0]
    when "boolean"
        Faker::Boolean.boolean
    when "text"
        Faker::Lorem.sentence(word_count: 3)
    when "date"
        Faker::Date.between(from:3.years.ago, to:Date.today)
    when "datetime"
        Faker::Time.between_dates(from:1000.days.ago, to:2.days.ago, period: :all)
    when "decimal"
        Faker::Number.decimal(l_digits:1, r_digits:3)
    else
        nil
    end
end

Project.all.each do |p|
    # create Subjects for each project
    p.subjects.destroy_all
    100.times do |idx|
        n = 3
        spi = "#{p.name}#{idx.to_s.rjust(3,'0')}" # Subject's Project ID S.P.I.
        sjt_cols = Subject.column_names.reject{ |cn| ["id", "project_id", "created_at", "updated_at", "origin_identifier"].include? cn }
        sjt_hash = {project_id:p.id, origin_identifier:spi}
        sjt_cols.each do |cn|
            sjt_hash[cn] = get_value(Subject.column_for_attribute(cn).type.to_s)
        end
        sub = Subject.new(sjt_hash)
        if sub.save 
            # Hla.new(subject_id:sub.id, drb1_1:"DRB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             drb1_2:"DRB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dqb1_1:"DQB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dqb1_2:"DQB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dpb1_1:"DPB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dpb1_2:"DPB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}", 
            #                             a_1:"A*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             a_2:"A*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}", 
            #                             b_1:"B*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             b_2:"B*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             c_1:"C*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             c_2:"C*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dpa1_1:"DPA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dpa1_2:"DPA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dqa1_1:"DQA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             dqa1_2:"DQA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             drbo_1:"DRBo*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
            #                             drbo_2:"DRBo*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}").save
            #c19 symptoms
            cs_cols = C19Symptom.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            cs_hash = {subject_id:sub.id}
            cs_cols.each do |cn|
                cs_hash[cn] = get_value(C19Symptom.column_for_attribute(cn).type.to_s)
            end
            C19Symptom.new(cs_hash).save
            #comorbidities
            comorb_cols = Comorbidity.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            comorb_hash = {subject_id:sub.id}
            comorb_cols.each do |cn|
                comorb_hash[cn] = get_value(Comorbidity.column_for_attribute(cn).type.to_s)
            end
            Comorbidity.new(comorb_hash).save
            #hospitalizations
            hosp_cols = Hospitalization.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            hosp_hash = {subject_id:sub.id}
            hosp_cols.each do |cn|
                hosp_hash[cn] = get_value(Hospitalization.column_for_attribute(cn).type.to_s)
            end
            Hospitalization.new(hosp_hash).save
            #lab tests
            lt_cols = LabTest.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            lt_hash = {subject_id:sub.id}
            lt_cols.each do |cn|
                lt_hash[cn] = get_value(LabTest.column_for_attribute(cn).type.to_s)
            end
            LabTest.new(lt_hash).save
            #risk factors
            rf_cols = RiskFactor.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            rf_hash = {subject_id:sub.id}
            rf_cols.each do |cn|
                rf_hash[cn] = get_value(RiskFactor.column_for_attribute(cn).type.to_s)
            end
            RiskFactor.new(rf_hash).save
            #treatments
            tmt_cols = Treatment.column_names.reject{ |cn| ["id", "subject_id", "created_at", "updated_at"].include? cn }
            tmt_hash = {subject_id:sub.id}
            tmt_cols.each do |cn|
                tmt_hash[cn] = get_value(Treatment.column_for_attribute(cn).type.to_s)
            end
            Treatment.new(tmt_hash).save
        end
    end
end
