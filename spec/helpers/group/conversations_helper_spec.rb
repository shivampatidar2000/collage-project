require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Group::ConversationsHelper. For example:
#
# describe Group::ConversationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Group::ConversationsHelper, type: :helper do

  context '#add_people_to_group_conv_list' do
    let(:conversation) { create(:group_conversation) }
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }
    before(:each) do
      create(:contact, 
              user_id: current_user.id, 
              contact_id: user.id,
              accepted: true)
    end
  
    it 'a user is not included in a list' do
      conversation.users << current_user
      conversation.users << user
      helper.stub(:current_user).and_return(current_user)
      expect(helper.add_people_to_group_conv_list(conversation)).not_to include user
    end
  
    it 'a user is included in a list' do
      conversation.users << current_user
      helper.stub(:current_user).and_return(current_user)
      expect(helper.add_people_to_group_conv_list(conversation)).to include user
    end
  end
end
