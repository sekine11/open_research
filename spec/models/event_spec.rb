require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
  	create(:user)
  	create(:laboratory)
    @event = build(:event)
  end
  describe 'バリデーション' do
    it 'すべて入力済みなら可' do
      expect(@event.valid?).to eq(true)
    end
    it 'titleが空なら不可' do
      @event.title = nil
      expect(@event.valid?).to eq(false)
    end
    it 'startが空なら不可' do
      @event.start = nil
      expect(@event.valid?).to eq(false)
    end
    it 'endが空なら不可' do
      @event.end = nil
      expect(@event.valid?).to eq(false)
    end
    it 'titleが20文字超過なら不可' do
      @event.title = "テ" * 21
      expect(@event.valid?).to eq(false)
    end
  end
end
