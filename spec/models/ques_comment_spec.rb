require 'rails_helper'

RSpec.describe QuesComment, type: :model do
  before do
    create(:user)
    create(:question)
    @ques_comment = build(:ques_comment)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@ques_comment.valid?).to eq(true)
    end
    it 'contentが空なら不可' do
      @ques_comment.content = nil
      expect(@ques_comment.valid?).to eq(false)
    end
  end
end