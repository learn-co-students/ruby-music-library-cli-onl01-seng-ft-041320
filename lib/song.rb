require 'pry'
class Song

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist= artist if artist #the if argument makes this call optional because if artist isn't there code isn't run.
        self.genre= genre if genre #the if argurment makes this call optional based on if an artist is passed in
        binding.pry
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
        create_song = Song.new(name)
        create_song.save
        create_song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end
    
    def genre=(genre)
        @genre = genre
        genre.songs << self if !genre.songs.include?(self)
    end  
    
end