require 'spec_helper'

describe AssociationCount do
  it 'has a version number' do
    expect(AssociationCount::VERSION).not_to be nil
  end

  it "counts associations of a given type" do
    res = Post.all.first.answer_count
    expect(res).to eq(2)
  end
end
