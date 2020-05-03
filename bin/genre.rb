require_relative '../config/environment'

class Genre
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize (name)
        @name = name
        @songs = [] 
    end

    def add_song (song)
        song.genre = self if song.genre == nil
        @songs << song
    end

    def artists
        artist_array = []
        @songs.each do |song|
            artist_array << song.artist unless artist_array.include?(song.artist)
        end
        artist_array
    end

    def save
        @@all << self
    end
    
    def Genre.all
        @@all
    end
    def Genre.create (name)
        new_genre = Genre.new(name)
        new_genre.save
        new_genre
    end

    def Genre.destroy_all
        @@all.clear
    end
end