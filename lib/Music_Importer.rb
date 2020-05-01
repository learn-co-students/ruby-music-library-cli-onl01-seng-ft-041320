class MusicImporter

    attr_reader :path

#initialize accepts a file path
#"./spec/fixtures/mp3s"
  def initialize(path)
      @path = path
  end

#files loads all the MP3 files in the path directory
#just the MP3 filename with no path
#"Action Bronson - Larry Csonka - indie.mp3"
#Dir['**/*.jpg'].each {|f| f}  get jpg in the current directory
#"hello".gsub(/[aeiou]/, '*') => "h*ll*"
  def files
  files = Dir.glob(path+"/*.mp3").map {|f| f.gsub(path+"/", "") }
end

#imports the files into the library 
#by invoking Song.create_from_filename
  def import
    files.each{ |f| Song.create_from_filename(f) }
  end
end

