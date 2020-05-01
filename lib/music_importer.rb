require 'pry'
class MusicImporter
  attr_accessor :path

  def initialize(file_path)
    @path = file_path
  end

  def files
    Dir.glob("#{@path}/*.mp3").map {|filename| filename.gsub("#{@path}/", "")}
  end

  def import
    self.files.each {|filename| Song.create_from_filename(filename)}
  end
end
