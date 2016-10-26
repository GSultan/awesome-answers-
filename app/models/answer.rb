class Answer < ApplicationRecord
  #This assumes that you have an integer field called 'question_id' in your answers table
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
end
