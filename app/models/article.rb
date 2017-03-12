class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  # def to_s
  #   title
  # end

  def tag_list
    # tags.collect {|t| t.name}.join(", ")
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect {|name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  # def tag_list=(input)
  #   #self.tags = []
  #   names = input.split(",").collect{|text| text.strip.downcase}
  #   names.each do |name|
  #     tag = Tag.find_or_create_by_name(name)
  #     self.tags << tag unless self.tags.include?(tag)
  #   end
  #   self.tags = self.tags.select{|tag| names.include?(tag.name)}
  # end
end
