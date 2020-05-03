module Concerns::Findable

  def find_by_name(song)
    all.find { |s| s.name == song }
  end

  def find_or_create_by_name(song)
    if find_by_name(song).nil?
      create(song)
    else
      find_by_name(song)
    end
  end
end
