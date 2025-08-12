module FileHelpers
  def read_file(path)
    File.read(path)
  end

  def write_file(path, content)
    File.open(path, "w") { |file| file.write(content) }
  end

  def append_to_file(path, content)
    File.open(path, "a") { |file| file.puts(content) }
  end

  def file_exists?(path)
    File.exist?(path)
  end

  def delete_file(path)
    File.delete(path) if file_exists?(path)
  end

  def count_lines(path)
    File.foreach(path).inject(0) { |c, _| c + 1 }
  end
end