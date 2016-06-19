class Project < ActiveRecord::Base
  attr_accessor :opml, :name
  has_many :items
  has_attached_file :opml, :url => "/:class/:attachment/:id/"
  validates_attachment_content_type :opml, :content_type => 'opml/xml'
   #before_save :parse_file
   #parse file after its saved, error states cannot convert file from nil so something is going wrong here.

 def parse_file
   File.open(@project.opml.url) { |f| Nokogiri::XML(f) }
 end



end
