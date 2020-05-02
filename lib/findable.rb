module Concerns::Findable
  attr_accessor :name
  def find_by_name(name)
   self.all.detect {|find| find.name == name}
    end
    def find_or_create_by_name(name)
      #binding.pry
      self.find_by_name(name) || self.create(name)
    end
end 
