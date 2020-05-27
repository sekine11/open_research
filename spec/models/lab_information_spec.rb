require 'rails_helper'

RSpec.describe LabInformation, type: :model do
  before do
  	create(:user)
  	create(:laboratory)
    @lab_information = build(:lab_information)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@lab_information.valid?).to eq(true)
    end
    it 'subjectが空なら不可' do
      @lab_information.subject = nil
      expect(@lab_information.valid?).to eq(false)
    end
    it 'contentが空なら不可' do
      @lab_information.content = nil
      expect(@lab_information.valid?).to eq(false)
    end
    it 'subjectが2文字未満なら無効' do
      @lab_information.subject = "テ"
      expect(@lab_information.valid?).to eq(false)
    end
    it 'subjectが50文字超過なら無効' do
      @lab_information.subject = SecureRandom.hex(26)
      expect(@lab_information.valid?).to eq(false)
    end
    it 'contentが30文字未満なら無効' do
      @lab_information.content = "テ" * rand(1..29)
      expect(@lab_information.valid?).to eq(false)
    end
    it 'contentが2000文字超過なら無効' do
      @lab_information.content = SecureRandom.hex(1001)
      expect(@lab_information.valid?).to eq(false)
    end
  end
end