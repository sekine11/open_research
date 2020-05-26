require 'rails_helper'

RSpec.describe Laboratory, type: :model do
  before do
    create(:user)
    @laboratory = build(:laboratory)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@laboratory.valid?).to eq(true)
    end
    it 'nameが空なら不可' do
      @laboratory.name = nil
      expect(@laboratory.valid?).to eq(false)
    end
    it 'nameが5文字未満なら不可' do
      @laboratory.name = "テ" * rand(1..4)
      expect(@laboratory.valid?).to eq(false)
    end
    it 'nameが30文字超過なら不可' do
      @laboratory.name = "テ" * 31
      expect(@laboratory.valid?).to eq(false)
    end
  end
end
