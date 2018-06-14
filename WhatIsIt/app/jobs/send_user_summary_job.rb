class SendUserSummaryJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    User2Mailer.summary(user).deliver_now

  end
end
