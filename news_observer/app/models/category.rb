class Category < ActiveRecord::Base

  belongs_to :newspaper
  has_many :articles
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  acts_as_list :scope => :newspaper

  before_validation :add_default_permalink
  after_save :touch_newspaper
  after_destroy :delete_related_articles

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("categories.position ASC") }
  scope :newest_first, lambda { order("categories.created_at DESC")}

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink

  private

    def add_default_permalink
      if permalink.blank?
        self.permalink = "#{id}-#{name.parameterize}"
      end
    end

    def touch_newspaper
       newspaper.touch
    end

    def delete_related_articles
      self.articles.each do |article|
      section.destroy
      end
    end

end
