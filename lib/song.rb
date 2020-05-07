require 'pry'
class Song

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist= artist if artist #the if argument makes this call optional because if artist isn't there code isn't run.
        self.genre= genre if genre #the if argurment makes this call optional based on if an artist is passed in
        # binding.pry
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
        create_song = Song.new(name)
        create_song.save
        create_song
    end

    def artist=(artist)
        @artist = artist
        self.artist.add_song(self)
    end
    
    def genre=(genre)
        @genre = genre
        genre.songs << self if !genre.songs.include?(self)
    end  

    def self.find_by_name(name)
        Song.all.find{|song| song if song.name == name}
    end
    
    def self.find_or_create_by_name(name)
        if self.find_by_name(name)
            self.find_by_name(name)
        else
            Song.create(name)
        end
    end

    def self.new_from_filename(file)
        #take file name and split it at " - "
        #files are split in db\mp3 folder by:  artist - song - genre.mp3
        song_name = file.split(" - ")[1]
        artist_name = file.split(" - ")[0]
        genre_name = file.split(" - ")[2].split(".mp3")[0]
        
        # binding.pry
        song = Song.new(song_name)
        # song = self.find_or_create_by_name(song_name)
        
        song.artist = Artist.find_or_create_by_name(artist_name)
        song.genre = Genre.find_or_create_by_name(genre_name)
        song
        
    end

    def self.create_from_filename(name)
        self.all << self.new_from_filename(name)
    end

end