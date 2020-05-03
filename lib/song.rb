require "pry"

class Song
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name= name
        self.artist = artist
        self.genre = genre
        save
    end

    def artist=(artist)
        #binding.pry
        @artist = artist
        if artist != nil
        artist.add_song(self) unless artist.songs.include?(self)
        end
    end

    def genre=(genre)
       @genre = genre
       #binding.pry
        if @genre != nil && !genre.songs.include?(self)
          genre.songs << self
        end
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        Song.new(name)
    end

    def self.find_by_name(name)
        #binding.pry
        Song.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        Song.find_by_name(name) || Song.create(name)
    end
    
    def self.new_from_filename(filename)
        artist_name, song_name, type = filename.split(" - ")
        #binding.pry
        song = Song.find_or_create_by_name(song_name)
        song.artist= Artist.find_or_create_by_name(artist_name)
        type = type.gsub(/\.mp3/, "")
        song.genre= Genre.find_or_create_by_name(type)
        song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end


end