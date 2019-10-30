require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensure name presence' do
      user = User.new(uid: '123', provider: 'twitter').save
      expect(user).to eq(false)
    end
    it 'ensure it saves correctly with name' do
      user = User.new(uid: '123', provider: 'twitter', name: 'name').save
      expect(user).to eq(true)
    end
  end
end
