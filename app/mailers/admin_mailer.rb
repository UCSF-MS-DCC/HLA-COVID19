class AdminMailer < ApplicationMailer
    default from: 'no-reply@hlacovid19.org'
    layout 'mailer'

    def new_user_waiting_for_approval(email)
        @email = email
        mail(to:'adam.renschen@ucsf.edu', subject: 'New HLA COVID19 registration awaiting approval')
    end
    def new_user_notice(email)
        @email = email
        mail(to:@email, subject:"Thank you for registering for the HLA COVID19 database")
    end

end
