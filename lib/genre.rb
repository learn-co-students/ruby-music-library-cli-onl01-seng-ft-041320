class Genre
    extend Concerns::Findable
    @@all = []

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def save
        @@all << self
    end

    def artists
        genre_artists = []
        @songs.each do |song|
            genre_artists << song.artist if !(genre_artists.include?(song.artist))
        end
        genre_artists
    end

    def self.create(name)
        self.new(name)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end
end