require 'rails_helper'

RSpec.describe Discussion, type: :model do
  before do
  	create(:user)
    @discussion = build(:discussion)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@discussion.valid?).to eq(true)
    end
    it 'subjectが空なら不可' do
      @discussion.subject = nil
      expect(@discussion.valid?).to eq(false)
    end
    it 'contentが空なら不可' do
      @discussion.content = nil
      expect(@discussion.valid?).to eq(false)
    end
    it 'discussion_listが空なら不可' do
      @discussion.discussion_list = nil
      expect(@discussion.valid?).to eq(false)
    end
    it 'subjectが5文字未満なら無効' do
      @discussion.subject = "テ" * rand(1..4)
      expect(@discussion.valid?).to eq(false)
    end
    it 'subjectが50文字超過なら無効' do
      @discussion.subject = SecureRandom.hex(26)
      expect(@discussion.valid?).to eq(false)
    end
    it 'contentが30文字未満なら無効' do
      @discussion.content = "テ" * rand(1..29)
      expect(@discussion.valid?).to eq(false)
    end
    it 'contentが2000文字超過なら無効' do
      @discussion.content = SecureRandom.hex(1001)
      expect(@discussion.valid?).to eq(false)
    end
  end
end
