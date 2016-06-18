class Project < ActiveRecord::Base
  attr_accessor :opml
  has_many :items
  has_attached_file :opml, :url => "/:class/:attachment/:id/"
  validates_attachment_content_type :opml, :content_type => 'opml/xml'
   after_save :parse_file
   #parse file after its saved? or before? either way, error states cannot convert file from nil so something is going wrong here.

 def parse_file
   File.open(@project) { |f| Nokogiri::XML(f) }
 end



end
