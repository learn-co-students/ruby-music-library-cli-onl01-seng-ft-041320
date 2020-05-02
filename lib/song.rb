require_relative '../concerns/concerns.rb'

class Song

    extend Concerns::Findable

    attr_reader :artist, :genre
    attr_accessor :name

    @@all = []

    def initialize(name, new_artist=nil, new_genre=nil)
        @name = name
        self.artist = new_artist if new_artist != nil
        self.genre = new_genre if new_genre != nil
    end

    def self.all
        @@all
    end

    def save
        self.class.all.push(self)
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name, artist=nil, genre=nil)
        new_inst = self.new(name, artist, genre)
        new_inst.save
        new_inst
    end

    def artist=(new_artist)
        @artist = new_artist
        @artist.add_song(self)
    end

    def genre=(new_genre)
        @genre = new_genre
        @genre.add_song(self)# if !genre.songs.include?(self)
    end

    def self.new_from_filename(file_name)
        file_name_fixed = file_name.split(".mp3")[0]
        artist = Artist.find_or_create_by_name(file_name_fixed.split(" - ")[0])
        song = file_name_fixed.split(" - ")[1]
        genre = Genre.find_or_create_by_name(file_name_fixed.split(" - ")[2])

        self.new(song, artist, genre)
    end

    def self.create_from_filename(file_name)
        new_from_filename(file_name).save
    end

end