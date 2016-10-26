class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  has_many :answers, lambda { order(created_at: :DESC) }, dependent: :destroy

  validates :title, presence: true,
  uniqueness: { case_sensitive: false,
  message: "must be unique"}

#with scope we valudate that the combination of two fields is unique. In the example below
#we are validating that the combination of title/body is unique.

  validates :body, length: {minimum: 5},
            uniqueness: {scope: :title}

  # validates :view_count, numericality: {greater_than_or_equal_to: 0}
# This is the more verbose form of doing validation , to show classes
  validates(:view_count, { numericality: {greater_than_or_equal_to: 0} } )

# assign a private method for something obscure like 'no monkey'
  validate :no_monkey

#callback methods:
  after_initialize :set_defaults
  before_validation :titleize_title

# scope :recent_ten, lambda { limit(10).order(created_at: :desc)}
#
  def self.recent_ten
    Question.limit(10).order(created_at: :desc)
  end

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end


  private

  def no_monkey
# add an error on the title field
    if title && title.include?('monkey')
      errors.add(:title, 'No monkeys please!')
    end
  end

  def set_defaults #if you wanna set something in ruby , you have instance variables @viewcount - something , or the other option , if you have attr accessor , you can self.viewcount , that value to something
    #if you wanna set the value of a
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize
  end
end
