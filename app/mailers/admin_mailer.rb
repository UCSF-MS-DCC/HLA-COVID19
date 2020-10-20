class AdminMailer < ApplicationMailer
    default from: 'no_reply@hlacovid19.org'
    layout 'mailer'

    def new_user_waiting_for_approval(user)
        email = user.email
        mail(to:'adam.renschen@ucsf.edu, covid.hla@gmail.com', subject: 'New HLA COVID19 registration awaiting approval')
    end
    def new_user_welcome_message(user)
        email = user.email
        mail(to:email, subject:"Thank you for registering for the HLA COVID19 database. The data governing team is evalutating your application and may contact you for additional information.")
    end

end
