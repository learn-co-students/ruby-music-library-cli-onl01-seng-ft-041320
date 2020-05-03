require_relative '../config/environment'

class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
    
    @@all = []

    def initialize (name)
        @name = name
        @songs = []
    end

    def add_song (song)
        song.artist = self if song.artist == nil
        @songs << song unless @songs.include?(song)
    end

    def genres
        genre_array = []
        @songs.each do |song|
            genre_array << song.genre unless genre_array.include?(song.genre)
        end
        genre_array
    end

    def save
        @@all << self
    end

    def Artist.all
        @@all
    end

    def Artist.create (name)
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def Artist.destroy_all
        @@all.clear
    end
end