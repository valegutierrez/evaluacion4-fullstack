class Task < ApplicationRecord
  before_destroy :destroy_this

  has_many :todos
  has_many :users, through: :todos

  def destroy_this 
    self.todos.delete_all
  end

end
