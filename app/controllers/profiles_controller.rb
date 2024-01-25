class ProfilesController < ApplicationController
    include Wicked::Wizard
    before_action :set_user
    before_action :set_progress
    steps :general, :educational, :professional
  
    def index 
        @profile = @user.profile
    end 

    def show
      @profile = @user.profile || @user.build_profile
      render_wizard
    end
  
    def create
      @profile = @user.profile || @user.build_profile
      redirect_to wizard_path(steps.first, profile_id: @profile.id)
    end
  
    def update
      @profile = @user.profile || @user.build_profile
      @profile.status = step.to_s
      @profile.status = 'active' if step == steps.last
      @profile.update(profile_params)
      render_wizard @profile
    end
  
    private

    def set_user 
        @user = current_user
    end

    def set_progress
        if steps.any? && steps.index(step).present?
          @progress = ((steps.index(step)).to_f / steps.count.to_f) * 100
        else
          @progress = 0
        end
    end
  
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :age, :email, :university, :level_of_education, :cgpa, :job_title, :company)
    end
end