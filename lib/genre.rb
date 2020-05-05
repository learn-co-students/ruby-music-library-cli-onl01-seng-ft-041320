class Genre

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self 
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        create_genre = Genre.new(name)
        create_genre.save
        create_genre
    end

end