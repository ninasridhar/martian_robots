require 'grid'

RSpec.describe Grid do

  describe '#new' do
    subject(:subject) { described_class.new(bounds) }

    context 'if x bound is less than 0' do
      let(:bounds) { '-1 9' }

      it 'produces the correct excepetion' do
        expect{subject}.to raise_exception 'X bound too small'
      end
    end

    context 'if y bound is less than 0' do
      let(:bounds) { '9 -2' }

      it 'produces the correct excepetion' do
        expect{subject}.to raise_exception 'Y bound too small'
      end
    end

    context 'if x bound is greater than 50' do
      let(:bounds) { '424 10' }

      it 'produces the correct excepetion' do
        expect{subject}.to raise_exception 'X bound too large'
      end
    end

    context 'if y bound is greater than 50' do
      let(:bounds) { '4 1034' }

      it 'produces the correct excepetion' do
        expect{subject}.to raise_exception 'Y bound too large'
      end
    end

    context 'if x and y bounds are within limits' do
      let(:bounds) { '32 38' }

      it 'produces the correct grid' do
        expect(subject.x_bound).to eq 32
        expect(subject.y_bound).to eq 38
      end
    end
  end
end