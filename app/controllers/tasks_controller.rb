class TasksController < ApplicationController

# to do >> create before_action :set_task method. Include error messages and error partial
  def index
    @task = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "A new task has been created"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "A task has been updated"
      redirect_to tasks_path(@task)
    else
      render :edit
    end
  end


  private

  def task_params
    params.require(:task).permit(:name, :description, :importance, :due, :status, :foreign_key)
  end


end
