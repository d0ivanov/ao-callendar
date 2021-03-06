class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def index
    @tasks = Task.find(:all)
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments.recent.limit(10).all
  end

  def create
    event = Event.find(params['event_id'])
    event.tasks << Task.create(task_params)
    redirect_to event_path(event), notice: "You have successfuly created the task"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    if task.update_attributes(task_params)
      redirect_to :action => 'show', :id => task
    else
      tasks = Task.find(:all)
      render :action => 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
  end

  private
    def task_params
      params.fetch(:task, {}).permit(:title, :description)
    end
end
