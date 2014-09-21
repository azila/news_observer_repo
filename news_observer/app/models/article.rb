class Article < ActiveRecord::Base

  belongs_to :category
  has_many :article_edits
  has_many :editors, :through => :article_edits, :class_name => "AdminUser"

  acts_as_list :scope => :category

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("articles.position ASC") }
  scope :newest_first, lambda { order("articles.created_at DESC")}
  
  CONTENT_TYPES = ['text', 'HTML']
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content

end
