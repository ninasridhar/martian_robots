require 'martian_robots'

RSpec.describe MartianRobots do

  describe '#parse_instructions' do
    subject(:subject) { described_class.parse_instructions(instructions) }

    let(:instructions) do
      "5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL"
    end

    let(:expected_response) do
      "1 1 E\n3 3 N LOST\n2 3 S"
    end

    it 'produces the correct output' do
      expect(subject).to eq(expected_response)
    end
  end
end