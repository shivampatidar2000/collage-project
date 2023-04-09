require 'rails_helper'

RSpec.describe Private::Message, type: :model do
    context 'Methods' do
        it 'gets a previous message' do
          conversation = create(:private_conversation)
          message1 = create(:private_message, conversation_id: conversation.id)
          message2 = create(:private_message, conversation_id: conversation.id)
          expect(message2.previous_message).to eq message1
        end
      end
end
