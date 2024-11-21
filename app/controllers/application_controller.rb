class ApplicationController < ActionController::Base
    include PublicActivity::StoreController 
    before_action :authenticate_user! 
    around_action :set_time_zone, if: :current_user 
    before_action :set_notification, if: :current_user 

    private 
    def set_time_zone(&block)
        Time.use_zone(current_user.time_zone, &block)
    end

    def set_notification
        notifications = Noticed::Notification.where(recipient: current_user).newest_first.limit(5) 
        @unread = current_user.notifications.unread 
        @read = current_user.notifications.read
    end
end
