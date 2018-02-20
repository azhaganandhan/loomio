class DiscussionMailer < BaseMailer
  layout 'discussion_mailer'
  REPLY_DELIMITER = "﻿﻿"*4 # surprise! this is actually U+FEFF
  %w(new_discussion invitation_created discussion_edited discussion_announced
     new_comment user_mentioned comment_replied_to new_comment).each do |action|
    define_method action, ->(recipient, event) { send_thread_email(recipient, event) }
  end

  private
  def send_thread_email(recipient, event)
    return if recipient == User.helper_bot

    @recipient = recipient
    @event = event
    @eventable = event.eventable
    @discussion = @eventable.discussion
    @author = @discussion.author
    @text = @discussion.body
    @link = polymorphic_url(@eventable)
    @following = @recipient.is_logged_in? && reader_is_loud?
    @utm_hash = utm_hash

    headers[message_id_header] = message_id
    headers['Precedence'] = 'bulk'
    headers['X-Auto-Response-Suppress'] = 'OOF'
    headers['Auto-Submitted'] = 'auto-generated'

    send_single_mail  to: @recipient.email,
                      from: from_user_via_loomio(@author),
                      reply_to: reply_to_address_with_group_name(discussion: @discussion, user: @recipient),
                      subject_key: "discussion_mailer.#{action_name}.subject",
                      subject_params: { actor: @author.name,
                                        group: @discussion.group.full_name,
                                        discussion: @discussion.title },
                      locale: @recipient.locale
  end

  def message_id_header
    action_name == 'new_discussion' ? 'Message-ID' : 'In-Reply-To'
  end

  def message_id
    "<#{@discussion.id}@#{ENV['SMTP_DOMAIN']}>"
  end

  def reader_is_loud?
    DiscussionReader.for(discussion: @discussion, user: @recipient).volume_is_loud?
  end
end
