module NavigationHelper

  def collapsible_links_partial_path
    if user_signed_in?
      'layouts/navigation/collapsible_elements/signed_in_links'
    else
      'layouts/navigation/collapsible_elements/non_signed_in_links'
    end
  end

  def nav_header_content_partials
    partials = []
    if params[:controller] == 'messengers' 
      partials << 'layouts/navigation/header/messenger_header'
    else # controller is not messengers  
      partials << 'layouts/navigation/header/toggle_button'
      partials << 'layouts/navigation/header/home_button'
      partials << 'layouts/navigation/header/dropdowns' if user_signed_in?
    end
    partials
  end

  def conversation_header_partial_path(conversation)
    if conversation.class == Private::Conversation
      'layouts/navigation/header/dropdowns/conversations/private_conversation'
    else
      'layouts/navigation/header/dropdowns/conversations/group_conversation'
    end  
  end  
end