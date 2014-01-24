class Slapp::Package
  include Slapp::Helpers

  attr_accessor :data

  def initialize(data, slackware_version)
    @data = data
    @slackware_version = slackware_version

    @name_match = regex('name').match(data)
    @location_match = regex('location').match(data)
    @size_match = data.scan regex('size')
    @description_match = regex('description').match(data)
  end

  def name
    @name_match[3]
  end

  def file_name
    @name_match[2]
  end

  def package_name
    @name_match[1]
  end

  def version
    @name_match[4]
  end

  def arch
    @name_match[5]
  end

  def build
    @name_match[6]
  end

  def location
    @location_match[1]
  end

  def path
    File.join "/slackware/slackware#{"64" if x86_64?}-#{@slackware_version}",
              location,
              package_name
  end

  def size_uncompressed
    convert_to_bytes @size_match.flatten.last
  end

  def size_compressed
    convert_to_bytes @size_match.flatten.first
  end

  def description
    original_description
      .gsub(/(\S)\n(\S)/, '\1 \2')
      .gsub(/\n\n\s/, "\n\n")
      .strip
  end

  def original_description
    if name == 'aalib'
      parsed_description.split("\n").map { |line|
        line[0..34].strip
      }.join("\n").strip
    else
      parsed_description
        .gsub(/\n\n /, "\n\n")
        .gsub(/\n /, "\n")
        .strip
    end
  end

  def summary
    parsed_description
      .slice(/^(.+)\n/)
      .strip
  end

  def to_hash
    methods = [:name, :file_name, :package_name, :version, :arch, :build, :location, :path, :size_uncompressed, :size_compressed, :description, :original_description, :summary]
    methods.each_with_object({}) { |m, hash|
      hash[m] = self.send(m)
    }
  end

private

  def x86_64?
    location.include? 'slackware64' or arch == "x86_64"
  end

  def parsed_description
    @description_match[1].gsub(/^#{name}:/, "")
  end

  def regex(type)
    regexes[type.to_sym]
  end

  def regexes
    {
      name: /PACKAGE NAME:\s+(((.+)-(.+)-(.+)-(.+))\.t\wz)/,
      location: /PACKAGE LOCATION:\s+\.([\S]+)/,
      size: /PACKAGE SIZE\s+\(\w+\):\s+(.+)/,
      description: /PACKAGE DESCRIPTION:\s+(.+)/m
    }
  end

end
