require 'rails_helper'

RSpec.describe DiscussComment, type: :model do
  before do
    create(:user)
    create(:discussion)
    @discuss_comment = build(:discuss_comment)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@discuss_comment.valid?).to eq(true)
    end
    it 'contentが空なら不可' do
      @discuss_comment.content = nil
      expect(@discuss_comment.valid?).to eq(false)
    end
  end
end