class Possibility < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
end
