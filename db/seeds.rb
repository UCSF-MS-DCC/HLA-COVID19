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

# admin user account
User.new(email:"dev@dev.org", password:"321321", password_confirmation:"321321", affiliation:"UCSF", can_upload:true, approved:true).save(validate:false)
# create separate domains for different users
domains = [Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name,Faker::GreekPhilosophers.name].uniq
# create project owner accounts
domains.each do |d|
    @user = User.new(email:Faker::Internet.email, password:"321321", password_confirmation:"321321", can_upload:true, approved:true, project_owner:true, project_name:[d])
    @user.save(validate:false)
end
# create general user accounts
10.times do
    User.new(email:"#{Faker::Internet.email}", password:"321321", password_confirmation:"321321", can_upload:true, approved:true,).save(validate:false)
end
# create Subjects for each project
Project.all.each do |p|
    25.times do |idx|
        n = 3
        sub = Subject.new(project_id:p.id, origin_identifier:"#{p.name}#{idx.to_s.rjust(n,'0')}", country_of_residence:Faker::Address.country, sex:["F","M"][Faker::Number.between(from:0, to:1)],
                        gender:"", education:["Primary", "College", "n/a"][Faker::Number.between(from:0, to:2)], age:Faker::Number.between(from:18, to:80),
                        ethnicity:["AA", "White", "Hispanic"][Faker::Number.between(from:0, to:2)], pregnant:false, ancestry:nil,
                        height_cm:Faker::Number.between(from:100, to:180), weight_kg:Faker::Number.between(from:60, to:90), race:nil,
                        project_name:p.name)
        if sub.save 
        C19Symptom.new(subject_id:sub.id, dry_cough:Faker::Boolean.boolean, mucus_cough:Faker::Boolean.boolean, days_cough:Faker::Number.between(from:1, to:10),
                                difficulty_breathing:Faker::Boolean.boolean, fever:Faker::Boolean.boolean, days_fever:Faker::Number.between(from:1, to:10),
                                fatigue:Faker::Boolean.boolean, pain_chest_heart:Faker::Boolean.boolean, pain_back:Faker::Boolean.boolean, runny_nose:Faker::Boolean.boolean,
                                sore_throat:Faker::Boolean.boolean, loss_taste_smell:nil, diarrhea:Faker::Boolean.boolean, nausea:Faker::Boolean.boolean,
                                c19_test_result_positive:Faker::Boolean.boolean, patient_self_reported_positive:Faker::Boolean.boolean).save
            Hla.new(subject_id:sub.id, drb1_1:"DRB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        drb1_2:"DRB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dqb1_1:"DQB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dqb1_2:"DQB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dpb1_1:"DPB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dpb1_2:"DPB*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}", 
                                        a_1:"A*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        a_2:"A*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}", 
                                        b_1:"B*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        b_2:"B*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        c_1:"C*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        c_2:"C*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dpa1_1:"DPA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dpa1_2:"DPA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dqa1_1:"DQA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        dqa1_2:"DQA*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        drbo_1:"DRBo*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}",
                                        drbo_2:"DRBo*#{Faker::Number.between(from:1, to:20).to_s.rjust(2,'0')}").save

        end
    end
end
