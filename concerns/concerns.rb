module Concerns

    module Findable

        def find_by_name(name)
            self.all.find {|inst| inst.name == name}
        end

        def find_or_create_by_name(name)
            result = find_by_name(name)
            result != nil ? result : self.create(name)
        end

    end

end
