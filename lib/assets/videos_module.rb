module Videos
  class Category
    TECHNOLOGY = 'Technology'
    ENGLISH = 'English'
    BUSINESS = 'Business'
    THREE_DIMENSIONS = 'ThreeDimensions'

    def self.all
      self.constants.map{ |name| self.const_get(name) }
    end
  end
end