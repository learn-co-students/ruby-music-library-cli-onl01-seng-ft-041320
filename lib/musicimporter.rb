

class MusicImporter

    attr_reader :path

    def initialize(filepath)
        @path = filepath
    end

    def files
        files = []
        Dir.glob("#{self.path}/*.mp3").collect do |file|
            files << file.gsub("#{self.path}/", "")
        end
        files
    end

    def import
        self.files.each {|file| Song.create_from_filename(file)}
    end
end