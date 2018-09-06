require 'spec_helper'

describe AssociationCount::Configuration do
  describe '#join_type=' do
    it 'can set the join type' do
      expect(AssociationCount.config.join_type).to eq(:left_outer_joins)

      AssociationCount.configure do |config|
        config.join_type = 'joins'
      end

      expect(AssociationCount.config.join_type).to eq(:joins)

      # Reset to default
      AssociationCount.configure do |config|
        config.join_type = :left_outer_joins
      end
    end

    it 'raises ArgumentError for unknown join type' do
      expect do
        AssociationCount.configure do |config|
          config.join_type = 'watman'
        end
      end.to raise_error(ArgumentError)
    end
  end
end
