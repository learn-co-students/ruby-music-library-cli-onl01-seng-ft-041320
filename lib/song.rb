class Song
  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.genre = genre
    self.artist = artist
  end

  def save
    @@all << self
  end

  def artist=(artist)
    return nil if artist.nil?

    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    return nil if genre.nil?

    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(song)
    self.all.find { |s| s.name == song }
  end

  def self.find_or_create_by_name(song)
    if find_by_name(song).nil?
      create(song)
    else
      find_by_name(song)
    end
  end

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.chomp(".mp3").split(" - ")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.new(song_name, artist, genre)
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

  def self.create(name)
    song = new(name)
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end
end
