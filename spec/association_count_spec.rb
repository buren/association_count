require 'spec_helper'

describe AssociationCount do
  it 'has a version number' do
    expect(AssociationCount::VERSION).not_to be nil
  end

  it "counts associations of a given type" do
    res = Post.all.first.answer_count
    expect(res).to eq(2)
  end

  it "counts associations of a given type" do
    res = Post.all.include_answer_count.first.answer_count
    expect(res).to eq(2)
  end

  it "can not reach the raw count if it is not included" do
    expect{ Post.all.first.answer_count_raw }.to raise_error
  end

  it "can reach the raw count if it is included" do
    expect{ Post.all.include_answer_count.first.answer_count_raw }.to_not raise_error
  end
end
