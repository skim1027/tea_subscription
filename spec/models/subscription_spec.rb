require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to(:tea) }
    it { should belong_to(:customer)}
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:tea_id) }
    it { should define_enum_for(:status).with_values(cancelled: 0, active: 1) }
  end
end
