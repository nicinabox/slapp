class Slapp::Parser
  include Slapp::Helpers

  attr_accessor :lines, :contents, :slackware_version

  def initialize(path, slackware_version)
    @lines = File.readlines(path, :encoding => 'ISO-8859-1')
    @contents = @lines.join('')
    @slackware_version = slackware_version
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
      package = Slapp::Package.new pkg.first, slackware_version
      package.to_hash
    }
  end

private

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
