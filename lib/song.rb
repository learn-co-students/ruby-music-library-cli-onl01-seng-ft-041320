class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all =[]

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist unless artist == nil
        self.genre = genre  unless genre == nil
    end

    # Class methods

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        split_file = filename.gsub(".mp3", "").split(" - ")
        artist = Artist.find_or_create_by_name(split_file[0])
        genre = Genre.find_or_create_by_name(split_file[2])
        self.new(split_file[1], artist, genre)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
    end

    #instance methods
    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end
end