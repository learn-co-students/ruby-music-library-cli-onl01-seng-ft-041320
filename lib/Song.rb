

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize name, artist=nil, genre=nil
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        #binding.pry
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

    def self.create name
        new_song = self.new(name)
        new_song.save
        new_song
    end

    def artist= artist
        @artist = artist
        artist.add_song(self)
    end

    def genre= genre
        @genre = genre
        genre.add_song(self)
    end

    def self.find_by_name name
       self.all.find { |song| song.name == name }
    end

    def self.find_or_create_by_name name
       self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end
    
    def self.new_from_filename(filename)
        artist, song, genre = filename.split (" - ")
        genre = genre.gsub(".mp3", "") 
        new_artist = Artist.find_or_create_by_name(artist)
        new_genre = Genre.find_or_create_by_name(genre)
        self.new(song, new_artist, new_genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end



end