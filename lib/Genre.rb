class Genre

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
    @@all.clear
end

def save
    @@all << self
end

def self.create(name)
    genre = new(name)
    genre.save
    genre
end

#returns the genre's 'songs' collection 
#(genre has many songs)
def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
end

#returns a collection of artists for all of the 
#genre's songs (genre has many artists through songs)
def artists
    songs.map {|song| song.artist}.uniq
end
end