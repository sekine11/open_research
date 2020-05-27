require 'rails_helper'

RSpec.describe LabInformationComment, type: :model do
  before do
    create(:user)
    create(:laboratory)
    create(:lab_information)
    @lab_information_comment = build(:lab_information_comment)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@lab_information_comment.valid?).to eq(true)
    end
    it 'contentが空なら不可' do
      @lab_information_comment.content = nil
      expect(@lab_information_comment.valid?).to eq(false)
    end
  end
end
