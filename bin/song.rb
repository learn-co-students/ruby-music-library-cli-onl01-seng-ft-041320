class Song
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize (name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) unless artist == nil
        self.genre=(genre) unless genre == nil
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self) unless artist.songs.include?(self)
    end
    def genre=(genre)
        @genre = genre
        genre.add_song(self) unless genre.songs.include?(self)
    end


    def save
        @@all << self
    end

    def Song.create (name)
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def Song.new_from_filename (file_name)
        data = file_name.split(" - ")
        new_song = self.new(data[1])
        new_song.artist = Artist.find_or_create_by_name(data[0])
        new_song.genre = Genre.find_or_create_by_name(data[2].split(".mp3").join)
        new_song
    end

    def Song.create_from_filename(file_name)
        new_song = self.new_from_filename(file_name)
        new_song.save
        new_song
    end

    def Song.all
        @@all
    end

    def Song.destroy_all
        @@all.clear
    end



end
