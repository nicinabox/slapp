class Parser
  attr_accessor :lines, :contents

  def initialize(path)
    @lines = File.readlines(path)
    @contents = @lines.join('')
  end

  def total_size_uncompressed
    line = lines.select { |line| line =~ total_size_regex('uncompressed') }
    match = total_size_regex('uncompressed').match(line.first)
    convert_to_bytes match[1]
  end

  def total_size_compressed
    line = lines.select { |line| line =~ total_size_regex('compressed') }
    match = total_size_regex('compressed').match(line.first)
    convert_to_bytes match[1]
  end

  def packages
    raw_packages.map { |pkg|
      package = name_parts(pkg.first)

      location = location_regex.match(pkg.first)
      size = pkg.first.scan(size_regex).flatten
      description = description_regex.match(pkg.first)

      desc = description[1].gsub(/^#{package[:name]}:/, "")
      summary = desc.slice(/^(.+)\n/).strip

      raw_desc = desc.gsub(/\n\n /, "\n\n").gsub(/\n /, "\n").strip

      if package[:name] == 'aalib'
        parsed_desc = ''
      else
        parsed_desc = desc.gsub(/(?<!\n)\n /, " ").gsub(/\n\n\s/, "\n\n").strip
      end

      package.merge({
        size: {
          compressed: convert_to_bytes(size[0]),
          uncompressed: convert_to_bytes(size[1])
        },
        location: location[1],
        path: File.join(location[1], package[:filename]),
        description: {
          raw: raw_desc,
          parsed: parsed_desc
        },
        summary: summary
      })
    }
  end

private

  def name_parts(pkg)
    name = name_regex.match(pkg)

    {
      filename: name[1],
      name: name[2],
      version: name[3],
      build: name[4],
      arch: name[5]
    }
  end

  def raw_packages
    contents.scan(package_regex)
  end

  def package_regex
    /(PACKAGE NAME.+?)\n\n/m
  end

  def name_regex
    /PACKAGE NAME:\s+((.+)-(.+)-(.+)-(.+)\.t\wz)/
  end

  def location_regex
    /PACKAGE LOCATION:\s+\.([\S]+)/
  end

  def size_regex
    /PACKAGE SIZE\s+\(\w+\):\s+(.+)/
  end

  def description_regex
    /PACKAGE DESCRIPTION:\s+(.+)/m
  end

  def total_size_regex(type)
    /Total size.+\(#{type}\):\s+(.+)$/
  end

  def convert_to_bytes(string)
    units = {
      :'K' => 1024,
      :'MB' => 1024 * 1024
    }

    formula = units.map {|u| u.last if string.include? u.first.to_s }.compact
    string.to_i * formula.first
  end

end
