require "pry"
class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end
    
    def files
        #how do you load all mp3 files in the path directory?
        Dir.chdir(self.path){|path|Dir.glob("*.mp3")}
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
    end
end