require 'pry'
class Artist
    
    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = [] #an artist has many songs!
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
        create_artist = Artist.new(name)
        create_artist.save
        create_artist
    end
    
    #-----------------------------------------------------------------------------

    # def songs
    #     # Song.all.select{|song| song.artist == self}
        
    # end

    def add_song(song)
        if  song.artist == nil #checks if an artist was input when Song class was instantiated.
            song.artist= self #assigns current artist to the artists property 
            songs << song if !songs.include?(song)
        end
        
    end
    
    def genres
        #create a statement that iterates throught an array of the songs of the artists and returns all of the genres or
        binding.pry
        .collect{|song| song.genre}
    end
end