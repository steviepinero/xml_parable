class Project < ActiveRecord::Base
  attr_accessor :opml
  has_many :items
  has_attached_file :opml, :url => "/:class/:attachment/:id/"
  validates_attachment_content_type :opml, :content_type => 'opml/xml'
  # before_save :contents_of_file_into_body


 def parse_file
   File.open("#{:name}.opml") { |f| Nokogiri::XML(f) }
 end


 def contents_of_file_into_body
   path = opml.queued_for_write[:project]
    File.open(path).read
end

end
