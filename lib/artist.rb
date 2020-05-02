

class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs, :musiclibrarycontroller, :musicimporter

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def add_song(song)
        song.artist=self unless song.artist==self
        songs << song unless songs.include?(song)
    end

    def genres
        songs.collect{ |song| song.genre}.uniq
    end

    # def self.find_or_create_by_name(name)
        # self.all.detect{ |artist| artist.name == name} || new(name)
    # end
end