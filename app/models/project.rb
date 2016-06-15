class Project < ActiveRecord::Base
  attr_accessor :blueprint
  has_many :items
  # has_attached_file :blueprint
end
