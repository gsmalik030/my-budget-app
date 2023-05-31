require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject do
    user = User.create(name: 'malik', password: 'password', email: 'malik@gmail.com')
    Entity.new(name: 'abc', amount: 123.4, user:)
  end

  before { subject.save }

  it 'should have valid name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have valid amount' do
    subject.amount = -1
    expect(subject).to_not be_valid
  end
end
