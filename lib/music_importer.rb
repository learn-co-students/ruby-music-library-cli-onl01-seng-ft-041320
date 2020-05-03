class MusicImporter
    attr_reader :path, :files
  
    def initialize(path)
      @path= path
      @files = Dir.entries(path).grep(/.*\.mp3/)
    end
  
    def import 
      @files.each {|file| Song.create_from_filename(file)}
    end
  end