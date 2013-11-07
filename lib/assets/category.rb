module Category
  TECHNOLOGY = 'Technology'
  ENGLISH = 'English'
  BUSINESS = 'Business'

  def self.all
    self.constants.map{ |name| self.const_get(name) }
  end
end