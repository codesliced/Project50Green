class MessagesController < ApplicationController
  include ApplicationHelper

  def index
    @tweets = create_messages
    @message = Message.new
    @messages = Message.all
  end

  def create
    message = Message.new(source: 'web',
                          # country: sometime... todo
                          description: params['message']['description'])
    message.populate_tags
    message.save!
    redirect_to root_path
  end

  def show
    @messages = Message.tagged_with(params[:tag])
    render json: {
      html: render_to_string(partial: 'display_messages', locals: { messages: @messages })
    }
  end
end
