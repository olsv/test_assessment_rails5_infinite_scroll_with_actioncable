require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valid?' do
    let(:valid_attributes) { attributes_for(:user) }

    subject(:valid?) { described_class.new(attributes).valid? }

    context 'valid record' do
      let(:attributes) { valid_attributes }

      it { expect(valid?).to be_truthy }
    end

    %i(first_name last_name email).each do |field|
      context "when #{ field } is missing" do
        let(:attributes) { valid_attributes.except(field) }

        it { expect(valid?).to be_falsey }
      end
    end

    context 'email' do
      %w(string string@ some@string @string.com string.com).each do |sample|
        let(:attributes) { valid_attributes.merge(email: sample) }

        it { expect(valid?).to be_falsey }
      end
    end
  end

end
