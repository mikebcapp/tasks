class TasksController < ApplicationController

helper_method :important_tasks, :urgent_tasks, :unimportant_tasks, :non_urgent_tasks, :important_and_urgent

  def index
    @task = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    if @task.save
      flash[:success] = "A new task has been created"
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
      flash[:success] = "A task has been updated"
      redirect_to tasks_path(@task)
    else
      render :edit
    end
  end

  def important_and_urgent
    important_tasks
    urgent_tasks
  end

  def unimportant_and_non_urgent
    @task = unimportant_tasks
    @task = non_urgent_tasks
  end


  
  def important_tasks
      @task = Task.select do |task|
      @task = task.importance > 8
    end
  end

    def unimportant_tasks
        @task = Task.select do |task|
        @task = task.importance < 8
      end
    end

  def urgent_tasks
    @task = Task.select do |task|
    @task = task.due > urgent_range
    end
  end


  def non_urgent_tasks
    @task = Task.select do |task|
    @task = task.due < urgent_range
    end
  end

  def urgent_range
    task = Time.now-3.day
  end



  private

  def task_params
    params.require(:task).permit(:name, :description, :importance, :due, :status, :foreign_key)
  end


end
