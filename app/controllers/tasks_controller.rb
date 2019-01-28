class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :finish, :unfinish]
  before_action :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  def finish
    @user = User.find(current_user.id)
    @todo = Todo.where(user_id: @user.id, task_id: @task.id)
    if @todo.one?
      @todo[0].update(done: true, finished_at: DateTime.now)
      redirect_to tasks_path
    end
  end

  def unfinish
    @user = User.find(current_user.id)
    @todo = Todo.where(user_id: @user.id, task_id: @task.id)
    if @todo.one?
      @todo[0].update(done: false, finished_at: nil)
      redirect_to tasks_path
    end
  end

  def done
    @todos = Todo.all
  end

  def not_done
    @todos = Todo.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @users = User.all
    find_ranking(@task)
  end

  def find_ranking(list)
    @all = []
    list.todos.each do |t|
      if t.done == true
        @all << t
      end
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        @users = User.all
        @users.each do |user|
          user.tasks << @task
        end
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
    destroy_todos
  end

  def destroy_todos
    @todos = Todo.where(task_id: nil)
    @todos.delete_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :photo, :content)
    end
end
