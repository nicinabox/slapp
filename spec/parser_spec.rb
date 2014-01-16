require 'parser'

describe Parser do
  before do
    @parser = Parser.new('spec/support/PACKAGES.TXT')
  end

  it "parses the total size (uncompressed)" do
    @parser.total_size_uncompressed.should == 5942280192
  end

  it "parses the total size (compressed)" do
    @parser.total_size_compressed.should == 1701838848
  end

  describe '.read' do
    it 'reads the file' do
      @parser.lines.should_not be_empty
    end
  end

  describe '#packages' do
    before do
      @package = @parser.packages.first
    end

    it "parses the filename" do
      @package[:filename].should == 'ConsoleKit-0.4.3-i486-1.txz'
    end

    it "parses the name" do
      @package[:name].should == 'ConsoleKit'
    end

    it "parses the version" do
      @package[:version].should == '0.4.3'
    end

    it "parses the location" do
      @package[:location].should == '/slackware/l'
    end

    it "parses the path" do
      @package[:path].should == '/slackware/l/ConsoleKit-0.4.3-i486-1.txz'
    end

    it "parses the size" do
      @package[:size].should == {
        :compressed => 131072,
        :uncompressed => 624640
      }
    end

    it "parses the description" do
      desc = <<-desc
ConsoleKit (user, login, and seat tracking framework)

ConsoleKit is a framework for defining and tracking users, login
sessions, and seats.

Homepage: http://freedesktop.org/wiki/Software/ConsoleKit
      desc

      parsed_desc = <<-desc
ConsoleKit (user, login, and seat tracking framework)

ConsoleKit is a framework for defining and tracking users, login sessions, and seats.

Homepage: http://freedesktop.org/wiki/Software/ConsoleKit
      desc

      @package[:description][:raw].should == desc.strip
      @package[:description][:parsed].should == parsed_desc.strip
    end

    it "parses the summary" do
      @package[:summary].should == "ConsoleKit (user, login, and seat tracking framework)"
    end
  end

  it "parses the aalib description" do
    desc = <<-desc
aalib (ASCII Art library)

AA-lib is an ASCII art graphics
library.  Internally, the AA-lib
API is similar to other graphics
libraries, but it renders the
the output into ASCII art (like
the example to the right :^)
The developers of AA-lib are
Jan Hubicka, Thomas A. K. Kjaer,
Tim Newsome, and Kamil Toman.
    desc
  end

end
