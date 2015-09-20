require 'csv'

class Possibility < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |possibility|
        csv << possibility.attributes.values_at(*column_names)
      end
    end
  end
end
