require 'rails_helper'

describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :number_of_pages }
    it { should validate_presence_of :year_published}
    it { should validate_presence_of :book_cover_url}
  end
end
