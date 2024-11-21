# To deliver this notification:
#
# TaskNotifier.with(record: @post, message: "New post").deliver(User.all)

class TaskNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
  def message 
    @sprint = record.sprint 
    @user = record.created_by 
    "#{@user.email} added task to the sprint #{@sprint.name}"
  end 

  def url
    sprint_path(record.sprint)
  end 
end
