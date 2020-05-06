require 'pry'
class Artist
    
    attr_accessor :name, :songs

    @@all = []
    
    extend Concerns::Findable
    
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

    def add_song(song)
        #checks if an artist was input when Song class was instantiated.
        if  song.artist == nil 
            #assigns current artist to the artists property 
            song.artist= self 
            songs << song if !songs.include?(song)
            
        end
        
        songs << song if !songs.include?(song)
       
    end
    
    def genres
        #create a statement that iterates throught an array of the songs of the artists and returns all of the genres or
        self.songs.collect{|song| song.genre}.uniq
    end
end