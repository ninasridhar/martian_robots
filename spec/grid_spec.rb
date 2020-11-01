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

  describe '#protect_bounds' do
    subject(:subject) { grid.protect_bound(bounds) }

    let(:grid) { Grid.new('5 2') }
    let(:bounds) { [5, 1] }

    it 'protects bounds' do
      expect{ subject }.to change { grid.protected_bounds.count }.by(1)
    end
  end

  describe '#is_protected?' do
    subject(:subject) { grid.is_protected?(bounds) }
    let(:grid) { Grid.new('5 2') }

    context 'is protected' do
      before do
        grid.protected_bounds.push([5,1, 'S'])
      end

      let(:bounds) { [5, 1, 'S'] }

      it 'is true' do
        expect(subject).to be_truthy
      end
    end

    context 'is not protected' do
      let(:bounds) { [5, 2, 'S'] }

      it 'is false' do
        expect(subject).to be_falsey
      end
    end
  end
end