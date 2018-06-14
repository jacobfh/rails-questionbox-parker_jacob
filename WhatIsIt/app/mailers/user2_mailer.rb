class User2Mailer < ApplicationMailer
  def summary(user)
    @user = user
    @question = user.questions.where('created_at >= ?', 1.week.ago).count
    @question_list = user.questions.where('created_at >= ?', 1.week.ago)
    @answer - user.answers.where('created_at >= ?', 1.week.ago).count
    @answer_list = user.answers.where('created_at >= ?', 1.week.ago)


    mail to: "to@example.org"
  end
end
