require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:customers) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items) }
  end
end
