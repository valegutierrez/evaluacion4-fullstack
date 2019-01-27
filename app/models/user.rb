class User < ApplicationRecord
  before_destroy :destroy_todos
  after_create :add_tasks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :todos
  has_many :tasks, through: :todos

  def destroy_todos 
    self.todos.delete_all
  end

  def add_tasks
    User.last.tasks << Task.all
  end
end
