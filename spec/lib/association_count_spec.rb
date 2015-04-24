require 'spec_helper'

describe AssociationCount do
  it "counts associations of a given type" do
    res = Post.all.first.answer_count
    expect(res).to eq(2)
  end

  it "counts associations of a given type" do
    res = Post.all.include_answer_count.first.answer_count
    expect(res).to eq(2)
  end

  it 'counts for has_many through relationships' do
    res = Post.all.include_author_count.first.author_count
    expect(res).to eq(1)
  end

  it "can not reach the raw count if it is not included" do
    expect{ Post.all.first.answer_count_raw }.to raise_error
  end

  it "can reach the raw count if it is included" do
    expect{ Post.all.include_answer_count.first.answer_count_raw }.to_not raise_error
  end

  context "can_count" do
  
    context 'new classes' do
      it 'raises an error if called in a bad way' do
        expect do
          class ExtraPost < ActiveRecord::Base
            can_count :answers
          end
        end.to raise_error
      end

      it 'raises no error if called in a good way' do
        expect do
          class ExtraPost < ActiveRecord::Base
            has_many  :extra_answers
            can_count :extra_answers
          end
          class ExtraAnswer < ActiveRecord::Base
            belongs_to :extra_post
          end
          ep = ExtraPost.create(text: 'tmp')
          ExtraAnswer.create(extra_post: ep, text: 'test')
          expect(ep.extra_answer_count).to eq(1)
          expect(ExtraPost.include_extra_answer_count.first.extra_answer_count).to eq(1)
          expect(ExtraPost.include_extra_answer_count.first.extra_answer_count_raw).to eq(1)
        end.to_not raise_error
      end
    end

  end
end
