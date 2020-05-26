require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
  	create(:user)
    @question = build(:question)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@question.valid?).to eq(true)
    end
    it 'subjectが空なら不可' do
      @question.subject = nil
      expect(@question.valid?).to eq(false)
    end
    it 'contentが空なら不可' do
      @question.content = nil
      expect(@question.valid?).to eq(false)
    end
    it 'question_listが空なら不可' do
      @question.question_list = nil
      expect(@question.valid?).to eq(false)
    end
    it 'subjectが5文字未満なら無効' do
      @question.subject = "テ" * rand(1..4)
      expect(@question.valid?).to eq(false)
    end
    it 'subjectが50文字超過なら無効' do
      @question.subject = SecureRandom.hex(26)
      expect(@question.valid?).to eq(false)
    end
    it 'contentが30文字未満なら無効' do
      @question.content = "テ" * rand(1..29)
      expect(@question.valid?).to eq(false)
    end
    it 'contentが2000文字超過なら無効' do
      @question.content = SecureRandom.hex(1001)
      expect(@question.valid?).to eq(false)
    end
  end
end