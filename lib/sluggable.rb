module Sluggable
  extend ActiveSupport::Concern
  included do
    before_save :generate_slug
    class_attribute :slug_column
  end

  def generate_slug
    the_slug = self.class.slug_column.to_sym
    self.slug = self.send(the_slug).gsub(' ','-').downcase
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end
