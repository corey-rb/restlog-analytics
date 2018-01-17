class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def bug_report(subject,description)
    @subject = subject
    @description = description
    mail(
        :subject => @subject,
        :to      => 'kaufmajh@gmail.com',
        :from    => 'user@prestigeworldwide.com'
    )
  end
end
