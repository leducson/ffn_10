module FootballNewsHelper
  def new_content content
    raw content[0..200]
  end
end
