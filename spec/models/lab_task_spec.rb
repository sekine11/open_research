require 'rails_helper'

RSpec.describe LabTask, type: :model do
  before do
  	create(:user)
  	create(:laboratory)
    @lab_task = build(:lab_task)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@lab_task.valid?).to eq(true)
    end
    it 'contentが空なら不可' do
      @lab_task.content = nil
      expect(@lab_task.valid?).to eq(false)
    end
    it 'contentが20文字超過なら不可' do
      @lab_task.content = "テ" * 21
      expect(@lab_task.valid?).to eq(false)
    end
  end
end
