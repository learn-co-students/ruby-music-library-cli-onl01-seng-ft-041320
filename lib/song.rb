

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
        #genre.songs << songs unless genre.songs.include?(self)
    end

    def self.create(name)
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def self.find_by_name(name)
        @@all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.create(name)
        else
            self.find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        artist, song, genre = filename.split (" - ")
        genre = genre.gsub(".mp3", "") #gsub takes off ".mp3" and replaces it with ""(aka: nothing)
        new_artist = Artist.find_or_create_by_name(artist)
        new_genre = Genre.find_or_create_by_name(genre)
        self.new(song, new_artist, new_genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
  
        
    def self.destroy_all
        self.all.clear
    end


end
