require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'ordinalize' do
    it 'gives the nth version of a number' do
      expect(ordinalize(3)).to eq('3rd')
    end

    it 'is nil for nil' do
      expect(ordinalize(nil)).to be_nil
    end
  end
end
