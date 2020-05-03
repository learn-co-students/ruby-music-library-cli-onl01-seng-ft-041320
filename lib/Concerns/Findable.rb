module Concerns::Findable
#defines a module named Concerns::Findable

    def find_by_name(name)
        self.all.find{|find| find.name == name}
      end

#invokes .find_by_name
#invokes the extended class's .create method
      def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
      end
    
end