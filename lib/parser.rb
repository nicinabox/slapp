class Parser
  attr_accessor :file, :lines

  def initialize(path)
    @file = File.read(path)
    @lines = File.readlines(path)
  end

  def total_size_uncompressed
    line = lines.select { |line| line =~ total_size('uncompressed') }
    match = total_size('uncompressed').match(line.first)
    convert_to_bytes match[1]
  end

  def total_size_compressed
    line = lines.select { |line| line =~ total_size('compressed') }
    match = total_size('compressed').match(line.first)
    convert_to_bytes match[1]
  end

private

  def total_size(type)
    /Total size.+\(#{type}\):\s+(.+)$/
  end

  def convert_to_bytes(string)
    units = {
      :'KB' => 1024,
      :'MB' => 1024 * 1024
    }

    formula = units.map {|u| u.last if string.include? u.first.to_s }.compact
    string.to_i * formula.first
  end

end
