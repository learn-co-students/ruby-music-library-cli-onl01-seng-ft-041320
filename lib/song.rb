require 'pry'

class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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

    def self.create(song, artist = nil, genre = nil)
        song = Song.new(song, artist, genre)
        @@all << song
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.new_from_filename(song)
        song_parted = song.split(' - ')
        song = song_parted[1]
        artist = Artist.find_or_create_by_name(song_parted[0])
        genre = Genre.find_or_create_by_name(song_parted[2].split('.')[0])
        self.create(song, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end
end