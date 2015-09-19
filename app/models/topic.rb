class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :possibilities

  def to_s
    question
  end
end
