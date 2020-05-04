require_relative './musicimporter.rb'

class MusicLibraryController
  attr_accessor :path

  def initialize(path="./db/mp3s")
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"

    response = nil
    until response == "exit"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"



      response = gets.chomp.downcase


      if response == 'list songs'
        list_songs
      end
      def list_songs 
        array = Song.all.sort
        array.each_with_index do |song, index|
          print "#{index+1}. "
          puts song.name
        end
      end
      if response == 'list artists'
        list_artists
      end
      def list_artists
        Artist.all.each { |artist| puts artist.name }
      end
    if response == "list genres"
      list_genres
    end
    def list_genres
        Genre.all.each { |genre| puts genre.name }
      end
    if response == 'play song'
      play_song
    end
    def play_song
        Song.all.each_with_index do |song, index|
          print "#{index+1}. "
          puts song.information
        end
        input = gets.chomp.to_i
        puts "Playing #{Song.all[input-1].artist.name} - #{Song.all[input-1].name} - #{Song.all[input-1].genre.name}"
      end

    if response == 'list artist'
      list_artist
    end
      def list_artist
        Artist.all.each { |artist| puts "#{artist.name}" }
        input = gets.chomp
        Artist.find_by_name(input).songs.each do |song|
          puts song.information
        end
      end

       if response == 'list genre'
         list_genre
       end
       def list_genre
        Genre.all.each { |genre| puts "#{genre.name}" }
        input = gets.chomp
        Genre.find_by_name(input).songs.each do |song|
          puts song.information
        end
      end

    if response == 'exit'
      exit
    end
    def exit
        puts "You have exited your music library."
      end

    end
    end
  end