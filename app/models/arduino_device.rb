class ArduinoDevice < ApplicationRecord
	belongs_to :user
	belongs_to :cow  
	has_many :cow_histories 

	  scope :created_on, lambda {|date| {:conditions => ['created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day]}}

  def self.today
    self.created_on(Date.today)
  end
end
