module Concerns::Findable
    def find_by_name (name)
        self.all.detect{|o| o.name == name}
    end
    def find_or_create_by_name (name)
        found = self.find_by_name(name)
        if found == nil
            found = self.create(name)
        end
        found
    end
end