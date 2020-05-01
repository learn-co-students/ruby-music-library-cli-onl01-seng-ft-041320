require 'pry'
class MusicLibraryController
  def initialize(path='./db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    user_input = ''
    while user_input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.chomp
      self.list_songs if user_input == "list songs"
      self.list_artists if user_input == "list artists"
      self.list_genres if user_input == "list genres"
      self.list_songs_by_artist if user_input == "list artist"
      self.list_songs_by_genre if user_input == "list genre"
      self.play_song if user_input == "play song"
    end
  end

  def list_songs
    Song.all.sort_by{|song| song.name}.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort_by{|artist| artist.name}.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort_by{|genre| genre.name}.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    if Artist.find_by_name(artist)
      Artist.find_by_name(artist).songs.sort_by{|song| song.name}.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    if Genre.find_by_name(genre)
      Genre.find_by_name(genre).songs.sort_by{|song| song.name}.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    number = gets.chomp
    if number.to_i.between?(1, Song.all.length)
      song = Song.all.sort_by{|song| song.name}[number.to_i - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
# Artist.find_by_name(artist).songs.sort_by{|song| song.name}.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
