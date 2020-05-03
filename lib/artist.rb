class Artist
    extend Concerns::Findable
    @@all = []

    attr_accessor :name, :songs, :genres

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def save
        @@all << self
    end

    def genres
        unique_genres = []
        Song.all.each do |song|
            if song.artist == self
                unique_genres << song.genre if !(unique_genres.include?(song.genre))
            end
        end
        @genres = unique_genres.dup
        @genres
    end

    def add_song(song)
        if (song.artist == nil)
            song.artist = self
            @songs << song if !(@songs.include?(song))
        end
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