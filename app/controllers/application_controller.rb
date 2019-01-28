class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :count_todos

  def count_todos
    if signed_in?
      @todos = Todo.all
      @count = []
      @todos.each do |todo|
        if todo.user_id == current_user.id and todo.done == true
          @count << todo
        end
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :photo])
  end
end
