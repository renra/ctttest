class Postman < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.postman.invitation.subject
  #
  def invitation( email, password )
    @password = password

    mail :to => email
  end
end
