require_relative '../lib/line_reader'

RSpec.describe LineReader, type: :class do
  describe '.read' do
    it 'raises an error when nil or empty string is passed' do
      expect {
        described_class.read('')
      }.to raise_error(LineReader::ReadError)
    end

    it 'raises an error when the line is one of the commands' do
      expect {
        described_class.read('NEGATE')
      }.to raise_error(LineReader::ReadError)
    end

    it 'responds properly when given PLACE command' do
      expect(described_class.read('PLACE 0,0,NORTH')).to be_instance_of Robot
      expect(described_class.read('pLaCe 2,3,wEsT')).to be_instance_of Robot

      expect {
        described_class.read('pLaCE 7,7,North')
      }.to raise_error(LineReader::ReadError)

      expect {
        described_class.read('pLaCE 0,0,Bacon')
      }.to raise_error(LineReader::ReadError)

      expect {
        described_class.read('plllaaacccceeee 3,3,right')
      }.to raise_error(LineReader::ReadError)
    end

    context 'without a `PLACE` command preceeding' do
      it 'responds to `MOVE` command'
      it 'responds to `LEFT` command'
      it 'responds to `RIGHT` command' 
      it 'responds to `REPORT` command'
    end

    context 'with a `PLACE` command preceeding' do
      it 'responds to `MOVE` command'
      it 'responds to `LEFT` command'
      it 'responds to `RIGHT` command' 
      it 'responds to `REPORT` command'
    end
  end
end
