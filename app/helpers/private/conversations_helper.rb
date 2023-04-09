module Private::ConversationsHelper

    def private_conv_recipient(conversation)
        conversation.opposed_user(current_user)
    end
    
    def load_private_messages(conversation)
        if conversation.messages.count > 0 
          'private/conversations/conversation/messages_list/link_to_previous_messages'
        else
          'shared/empty_partial'
        end 
      end
end
