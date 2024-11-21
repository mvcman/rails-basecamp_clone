class SprintsController < ApplicationController 
    before_action :set_sprint, only: %i[ show edit update destroy ]
    def index 
        @sprints = Sprint.all
        @activities = PublicActivity::Activity.all
    end 

    def new
        @sprint = Sprint.new
        @sprint.start_date = Date.today 
        @sprint.end_date = Date.today + 7.days
    end 

    def show
        @tasks = @sprint.tasks.all 
        mark_notifications_as_read
    end 

    def edit 
    end 

    def create 
        @sprint = current_user.sprints.build(sprint_params)
        respond_to do |format|
            if @sprint.save 
                format.html { redirect_to sprint_path(@sprint), notice: "Sprint created successfully!"}
                format.turbo_stream
            else
                format.html { render :new, status: :unprocessable_entity }
            end 
        end 
    end

    def update 
        respond_to do |format|
            if @sprint.update(sprint_params)
                format.html { redirect_to sprint_path(@sprint), notice: "Sprint created successfully!"}
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
            end 
        end 
    end  

    def destroy
        @sprint.destroy! 
    
        respond_to do |format|
          format.html { redirect_to sprints_path, notice: "Quote was successfully destroyed." }
          format.json { head :no_content }
          format.turbo_stream
        end
    end

    private 

    def set_sprint
        @sprint = Sprint.find(params[:id])
    end 

    def sprint_params
        params.require(:sprint).permit(:name, :start_date, :end_date) 
    end  

    def mark_notifications_as_read
        return unless current_user 
        notifications_to_mark_as_read = @sprint.notifications.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.zone.now) 
    end 
end 