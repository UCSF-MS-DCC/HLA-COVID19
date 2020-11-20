class AdminMailer < ApplicationMailer
    default from: 'admin@database-hlacovid19.org'

    def new_user_waiting_for_approval(user)
        @email = user.email
        @affiliation = user.affiliation
        mail(to:'adam.renschen@ucsf.edu, covid.hla@gmail.com', subject: 'New HLA COVID19 registration awaiting approval')
    end
    def new_user_welcome_message(user)
        @email = user.email
        mail(to:@email, subject:"Thank you for registering for the HLA COVID19 database. The data governing team is evalutating your application and may contact you for additional information.")
    end
    def user_approved_notification(user)
        @email = user.email
        mail(to:@email, subject:"Your account on the HLA | COVID19 database has been approved")
    end
    def notify_admin_of_new_user_approval(user)
        @email = user.email
        mail(to:"adam.renschen@ucsf.edu", subject:"New user account has been approved.")
    end
    def notify_admin_of_server_account_creation(user, created)
        @user_account = user.email
        @created = created
        mail(to:"adam.renschen@ucsf.edu", subject:"New user server account attempted")
end
