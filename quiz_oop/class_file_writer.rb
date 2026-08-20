class FileWriter
  
  def initialize filename, mode
    @filename = filename
    @mode = mode
  end

  def write content
    File.write(
    @filename, 
    content,
    mode: @mode
    )
  end
  
end