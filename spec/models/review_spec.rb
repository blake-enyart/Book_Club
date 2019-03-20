require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :text }
    it { should validate_presence_of :username }
  end

  describe 'relationships' do
    it { should belong_to :book }
  end
end
