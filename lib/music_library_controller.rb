class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    input = gets.strip

    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"


    if input == "list songs"
      list_songs
    elsif input == "list artists"
      list_artists
    elsif input == "list genres"
      list_genres
    elsif input == "list artist"
      list_songs_by_artist
    elsif input == "list genre"
      list_songs_by_genre
    elsif input == "play song"
      play_song
    else
      "Invalid entry - try again!"
    end
    if input != "exit"
      call
    end
  end

  def list_songs
    songs = Song.all.sort_by { |song| song.name }
    songs.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists = Artist.all.sort_by { |artist| artist.name }
    artists.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    genres = Genre.all.sort_by { |genre| genre.name }
    genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_choice = gets.chomp

    artist = Artist.all.find { |artist| artist.name == artist_choice }

    unless artist.nil?
      songs = artist.songs.sort_by { |song| song.name }
      songs.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_choice = gets.chomp

    genre = Genre.all.find { |genre| genre.name == genre_choice }

    unless genre.nil?
      songs = genre.songs.sort_by { |song| song.name }
      songs.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_choice = gets.strip.to_i

    songs = Song.all.sort { |song_a, song_b| song_a.name <=> song_b.name }
    song = songs[song_choice - 1]
    if 0 < song_choice && song_choice < songs.length
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
