
class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clea
        r
    end
    def save
        @@all << self
    end

#initializes and saves the genre
    def self.create(name)
    artist = self.new(name)
    artist.save
    artist
    end

#assigns the current artist to the song's 'artist' 
#property (song belongs to artist)
#adds the song to the current artist's 'songs' collection
    def add_song(song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end
    
#returns a collection of genres for all of the artist's 
#songs (artist has many genres through songs)    
    def genres
        songs.map {|song| song.genre}.uniq
    end
end