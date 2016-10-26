class AddViewCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :view_count, :integer
    #migrations are strictly for changing the structure of the data , not adding data itself

  end
end
