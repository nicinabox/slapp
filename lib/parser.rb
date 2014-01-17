require 'helpers'
require 'package'

class Parser
  include Helpers
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
      package = Package.new pkg.first
      package.to_hash
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

  def total_size_regex(type)
    /Total size.+\(#{type}\):\s+(.+)$/
  end

end
