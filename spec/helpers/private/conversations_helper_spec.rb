require 'rails_helper'

RSpec.describe Private::ConversationsHelper, type: :helper do
  context '#load_private_messages' do
    let(:conversation) { create(:private_conversation) }
  
    it "returns load_messages partial's path" do
      create(:private_message, conversation_id: conversation.id)
      expect(helper.load_private_messages(conversation)).to eq (
        'private/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end
  
    it "returns empty partial's path" do
      expect(helper.load_private_messages(conversation)).to eq (
        'shared/empty_partial'
      )
    end
  end
  context '#get_contact_record' do
    it 'returns a Contact record' do
      contact = create(:contact, user_id: current_user.id, contact_id: recipient.id)
      helper.stub(:current_user).and_return(current_user)
      expect(helper.get_contact_record(recipient)).to eq contact
    end
  end
  context '#unaccepted_contact_request_partial_path' do
    let(:contact) { contact = create(:contact) }
  
    it "returns sent_by_current_user partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(true)
      helper.stub(:request_sent_by_user).and_return(true)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/sent_by_current_user' 
      )
    end
  
    it "returns sent_by_recipient partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(true)
      helper.stub(:request_sent_by_user).and_return(false)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/sent_by_recipient'
      )
    end
  
    it "returns an empty partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end
  end
  
  context '#not_contact_no_request' do
    let(:contact) { contact = create(:contact) }
  
    it "returns send_request partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/send_request'
      )
    end
  
    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(true)
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end
  
    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      helper.stub(:unaccepted_contact_exists).and_return(true)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end
  end
  
  context 'private scope' do
    context '#request_sent_by_user' do
      it 'returns true' do
        contact = create(:contact, user_id: current_user.id)
        helper.stub(:current_user).and_return(current_user)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq true
      end
  
      it 'returns false' do
        contact = create(:contact, user_id: recipient.id)
        helper.stub(:current_user).and_return(current_user)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq false
      end
    end
  end
end
