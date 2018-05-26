require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valid?' do
    let(:valid_attributes) { attributes_for(:user) }

    subject(:record) { described_class.new(attributes) }
    subject(:valid?) { record.valid? }

    context 'valid record' do
      let(:attributes) { valid_attributes }

      it { expect(valid?).to be_truthy }
    end

    %i(first_name last_name email).each do |field|
      context "when #{ field } is missing" do
        let(:attributes) { valid_attributes.except(field) }

        it 'is invalid' do
          expect(valid?).to be_falsey
          expect(record.errors[field]).to eql ["can't be blank"]
        end
      end
    end

    context 'email' do
      %w(string string@ some@string @string.com string.com).each do |sample|
        let(:attributes) { valid_attributes.merge(email: sample) }

        it 'is invalid' do
          expect(valid?).to be_falsey
          expect(record.errors[:email]).to eql ["is invalid"]
        end
      end
    end
  end

end
