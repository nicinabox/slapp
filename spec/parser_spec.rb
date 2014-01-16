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
      @parser.file.should_not be_nil
    end
  end

  describe '#raw' do
    it "parses the name"
    it "parses the location"
    it "parses the size"
    it "parses the description"
  end

  it "returns the name"
  it "returns the version"
  it "returns the arch"
  it "returns the build"
  it "returns the path"
  it "returns the uncompressed size, in bytes"
  it "returns the compressed size, in bytes"
  it "returns the description"
  it "returns the one line summary"

end
