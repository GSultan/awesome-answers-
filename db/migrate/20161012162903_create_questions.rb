class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    #this is called DSL: Domain Specific Language.
    #It's still Ruby code but written in a way that seems like a new language. Ruby is flexible and allows that.
    #The Create_table method comes from the ActiveRecord gem
    create_table :questions do |t|
      #by default rails will always create a primary key integer : id
      t.string :title
      t.text :body


      #this generates two timestamp colmns: created at and updated at
      t.timestamps
    end
  end
end
