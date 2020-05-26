require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@user.valid?).to eq(true)
    end
    it 'public_nameが空なら不可' do
      @user.public_name = nil
      expect(@user.valid?).to eq(false)
    end
    it 'private_nameが空なら不可' do
      @user.private_name = nil
      expect(@user.valid?).to eq(false)
    end
    it 'emailが空なら不可' do
      @user.email = nil
      expect(@user.valid?).to eq(false)
    end
    it 'public_nameとprivate_nameが1文字なら無効' do
      @user.private_name = "テ"
      @user.public_name = "テ"
      expect(@user.valid?).to eq(false)
    end
    it 'public_nameとprivate_nameが20文字以上なら無効' do
      @user.private_name = SecureRandom.hex(11)
      @user.public_name = SecureRandom.hex(11)
      expect(@user.valid?).to eq(false)
    end
  end
end
