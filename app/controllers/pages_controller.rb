class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = current_user.pages
  end

  def new
    @page = Page.new
  end

  def create
    successful_save = true
    error_message = nil

    @page = Page.new
    page_name = CGI.escape(params[:page_name]&.strip)
    @page.name = page_name
    @page.user = current_user

    page_html = params[:page_html]

    estimated_page_size = page_html.bytesize

    logger.info estimated_page_size

    if estimated_page_size > 200000
      successful_save = false
      error_message = "Couldn't save your page. It's too big. Try making it smaller."
      logger.info successful_save
    end

    if successful_save
      successful_save = @page.save
      logger.info successful_save
    end

    if successful_save
      # Do security checks...
      successful_save = File.write("public/#{page_name}.html", page_html)
      logger.info successful_save
    end

    # TODO - send text to job?
    # turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :info, content: "Trying to create the page..." })

    if successful_save
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :notice, content: "Success! You can visit your at page <a class='text-blue hover:text-underline' href='http://localhost:3000/#{page_name}.html' target='_blank'>localhost:3000/#{page_name}.html</a>" })
    else
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :alert, content: error_message})
    end
  end
end
