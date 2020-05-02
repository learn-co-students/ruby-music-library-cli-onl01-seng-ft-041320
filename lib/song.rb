
class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(name)
        @artist = name
        artist.add_song(self)
    end

    def genre=(name)
        @genre = name
        genre.add_song(self)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        @@all.detect { |song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end
    
    def self.new_from_filename(filename)
        song_file = filename.split(" - ")
        artist_name = song_file[0]
        song_name = song_file[1]
        genre_name = song_file[2].gsub(".mp3", "")
    
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
    
        self.new(song_name, artist, genre)
    end
    
    def self.create_from_filename(filename)
        self.new_from_filename(filename).save 
    end
end