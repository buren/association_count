require 'spec_helper'

describe AssociationCount do
  it "includes records that have 0 associations" do
    authors = Author.all.include_post_count
    expect(authors.length).to eq(2)
  end

  it "does not include records that have 0 associations if join_type is inner join" do
    authors = Author.all.include_post_count(join_type: :joins)
    expect(authors.length).to eq(1)
  end

  it "counts associations of a given type" do
    res = Post.all.first.answer_count
    expect(res).to eq(2)
  end

  it "counts associations of a given type" do
    res = Post.all.include_answer_count.first.answer_count
    expect(res).to eq(2)
  end

  it 'by default counts non-distinct for has_many through relationships' do
    res = Post.all.include_author_count.first.author_count
    expect(res).to eq(2)
  end

  it 'counts non-distinct for has_many through relationships' do
    res = Post.all.include_author_count(distinct: false).first.author_count
    expect(res).to eq(2)
  end

  it 'counts distinct for has_many through relationships' do
    res = Post.all.include_author_count(distinct: true).first.author_count
    expect(res).to eq(1)
  end

  it "can not reach the raw count if it is not included" do
    expect { Post.all.first.answer_count_raw }.to raise_error(NoMethodError)
  end

  it "can reach the raw count if it is included" do
    expect do
      Post.all.include_answer_count.first.answer_count_raw
    end.to_not raise_error
  end

  context "can_count" do
    context 'new classes' do
      it 'raises an error if called in a bad way' do
        expect do
          class ExtraPost < ActiveRecord::Base
            can_count :answers
          end
        end.to raise_error(ArgumentError, "No such reflection: 'answers'")
      end

      context 'non standard cases' do
        class ExtraPost < ActiveRecord::Base
          has_many  :extra_answers
          can_count :extra_answers
          belongs_to :author
          has_many :authors, through: :extra_answers
          can_count :authors, distinct: false

        end
        class ExtraAnswer < ActiveRecord::Base
          belongs_to :extra_post
          belongs_to :author
        end

        it 'raises no error if called in a good way' do
          expect do
            ep = ExtraPost.create(text: 'tmp')
            ExtraAnswer.create(extra_post: ep, text: 'test')
            expect(ep.extra_answer_count).to eq(1)
            expect(ExtraPost.include_extra_answer_count.first.extra_answer_count).to eq(1)
            expect(ExtraPost.include_extra_answer_count.first.extra_answer_count_raw).to eq(1)
          end.to_not raise_error
        end

        it 'does not count distinct if it is set to false' do
          author = Author.create(name: 'Albin')
          ep = ExtraPost.create(text: 'tmp', author: author)
          ExtraAnswer.create(extra_post: ep, text: 'test', author: author)
          ExtraAnswer.create(extra_post: ep, text: 'test', author: author)
          expect(ExtraPost.all.include_author_count.last.author_count).to eq(2)
        end
      end
    end
  end
end
