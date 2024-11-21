class TasksController < ApplicationController
    before_action :set_sprint_task, only: %i[ show edit update destroy ]
    before_action :set_tasks

    def new
        @sprint = Sprint.find(params[:sprint_id])
        @task = Task.new 
        @task.sprint_id = @sprint.id
        @task.created_by = current_user
    end 

    def show 
    end 

    def create
        p "came to tasks create action"
        begin
            @sprint = Sprint.find(params[:sprint_id])
            p "found sprint #{@sprint.inspect}"
            @task = @sprint.tasks.build(task_params)
            p "after task #{@task.inspect}"
            @task.created_by = current_user
            # @task.assigned_to = current_user 
            @task.user_ids = params[:task][:user_ids][0].split(",").map(&:to_i)
            p "after task2 #{@task.inspect}"
            respond_to do |format|
                if @task.save 
                    format.turbo_stream
                else
                    format.html { render :new, status: :unprocessable_entity }
                end 
            end 
        rescue StandardError => e
            p "Error #{e.message}"
        end 
    end 

    def edit 
    end 

    def update
        respond_to do |format|
            @task.user_ids = params[:task][:user_ids][0].split(",").map(&:to_i)
            if @task.update(task_params)
                format.turbo_stream
            else
                format.html { render :edit, status: :unprocessable_entity }
            end 
        end 
    end

    def mark_pending
        @task = Task.find(params[:id])
        respond_to do |format|
            if @task.update(status: "pending")
                format.turbo_stream
            end
        end
    end 

    def mark_complete
        @task = Task.find(params[:id])
        respond_to do |format|
            if @task.update(status: "completed")
                format.turbo_stream
            end
        end
    end 

    def destroy
        @task.destroy! 
    
        respond_to do |format|
          format.turbo_stream
        end
    end 

    private
    def set_tasks
        @sprint = Sprint.find(params[:sprint_id])
        @tasks = @sprint.tasks.all
    end 

    def set_sprint_task
        @sprint = Sprint.find(params[:sprint_id])
        @task = Task.find(params[:id])
    end 
    
    def task_params
        params.require(:task).permit(:name, :desciption)
    end 
end 