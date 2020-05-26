require 'rails_helper'

RSpec.describe Protocol, type: :model do
  before do
  	create(:user)
    @protocol = build(:protocol)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@protocol.valid?).to eq(true)
    end
    it 'subjectが空なら不可' do
      @protocol.subject = nil
      expect(@protocol.valid?).to eq(false)
    end
    it 'contentが空なら不可' do
      @protocol.content = nil
      expect(@protocol.valid?).to eq(false)
    end
    it 'protocol_listが空なら不可' do
      @protocol.protocol_list = nil
      expect(@protocol.valid?).to eq(false)
    end
    it 'subjectが5文字未満なら無効' do
      @protocol.subject = "テ" * rand(1..4)
      expect(@protocol.valid?).to eq(false)
    end
    it 'subjectが50文字超過なら無効' do
      @protocol.subject = SecureRandom.hex(26)
      expect(@protocol.valid?).to eq(false)
    end
    it 'contentが30文字未満なら無効' do
      @protocol.content = "テ" * rand(1..29)
      expect(@protocol.valid?).to eq(false)
    end
    it 'contentが5000文字超過なら無効' do
      @protocol.content = SecureRandom.hex(2501)
      expect(@protocol.valid?).to eq(false)
    end
  end
end