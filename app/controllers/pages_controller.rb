class PagesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, only: :preview

  include ActionView::Helpers::OutputSafetyHelper

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
      successful_save = @page.valid?
      unless successful_save
        error_message = @page.errors.full_messages.join("\n")
      end
      logger.info successful_save
    end

    if successful_save
      # Do security checks...

      doc = Nokogiri::HTML.parse(page_html)
      doc.search('script').each do |script|
        script.remove
      end

      existing_content_security_policy_meta_tag = doc.css("meta[http-equiv=\"Content-Security-Policy\"]")
      if existing_content_security_policy_meta_tag.length > 0
        existing_content_security_policy_meta_tag.each do |tag|
          tag.remove
        end
      end

      header_tag = doc.search('head').first
      content_security_policy_meta_tag = "<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'; img-src https://*; style-src 'unsafe-inline'; script-src 'none';\">"
      header_tag << content_security_policy_meta_tag

      path_to_file = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{page_name}.html")
      if File.exists?(path_to_file)
        successful_save = false
      else
        successful_save = File.write(path_to_file, doc.to_html)
      end
      logger.info successful_save
    end

    if successful_save
      successful_save = @page.save
    end

    # TODO - send text to job?
    # turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :info, content: "Trying to create the page..." })

    if successful_save
      redirect_to pages_created_path(@page.id)
    else
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :alert, content: error_message})
    end
  end

  def created
    @page = current_user.pages.find(params[:id])
  end

  def edit
    @page = current_user.pages.find(params[:id])

    file_path = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{@page.name}.html")
    @page_html = Nokogiri::HTML.parse(file_path).to_html
  end

  def preview
    page_html = params[:page_html]
    doc = Nokogiri::HTML.parse(page_html)
    doc.search('script').each do |script|
      script.remove
    end

    existing_content_security_policy_meta_tag = doc.css("meta[http-equiv=\"Content-Security-Policy\"]")
    if existing_content_security_policy_meta_tag.length > 0
      existing_content_security_policy_meta_tag.each do |tag|
        tag.remove
      end
    end

    header_tag = doc.search('head').first
    content_security_policy_meta_tag = "<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'; img-src https://*; style-src 'unsafe-inline'; script-src 'none';\">"
    header_tag << content_security_policy_meta_tag

    raw_html = raw(doc.to_html)

    render layout: false, html: raw_html
  end

  def update
    @page = current_user.pages.find(params[:id])

    successful_save = true
    error_message = nil

    page_name = CGI.escape(params[:page_name]&.strip)
    @page.name = page_name

    page_html = params[:page_html]

    estimated_page_size = page_html.bytesize

    logger.info estimated_page_size

    if estimated_page_size > 200000
      successful_save = false
      error_message = "Couldn't save your page. It's too big. Try making it smaller."
      logger.info successful_save
    end

    if successful_save
      successful_save = @page.valid?
      unless successful_save
        error_message = @page.errors.full_messages.join("\n")
      end
      logger.info successful_save
    end

    if successful_save
      # Do security checks...

      doc = Nokogiri::HTML.parse(page_html)
      doc.search('script').each do |script|
        script.remove
      end

      existing_content_security_policy_meta_tag = doc.css("meta[http-equiv=\"Content-Security-Policy\"]")
      if existing_content_security_policy_meta_tag.length > 0
        existing_content_security_policy_meta_tag.each do |tag|
          tag.remove
        end
      end

      header_tag = doc.search('head').first
      content_security_policy_meta_tag = "<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'; img-src https://*; style-src 'unsafe-inline'; script-src 'none';\">"
      header_tag << content_security_policy_meta_tag

      path_to_file = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{page_name}.html")
      if @page.will_save_change_to_name?
        path_to_old_file = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{@page.name_was}.html")
        File.delete(path_to_old_file)
      end
      successful_save = File.write(path_to_file, doc.to_html)
      logger.info successful_save
    end

    if successful_save
      successful_save = @page.save
    end

    # TODO - send text to job?
    # turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :info, content: "Trying to create the page..." })

    if successful_save
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :notice, content: "Success! You can visit your at page <a class='text-slate-500 underline' href='#{ENV['ROOT_URL']}/#{page_name}' target='_blank'>localhost:3000/#{page_name}</a>" })
    else
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :alert, content: error_message})
    end
  end

  def show_confirmation_modal_for_delete
    @page = current_user.pages.find(params[:id])

    render turbo_stream: turbo_stream.update(:modal, partial: 'pages/confirmation_modal_for_delete', locals: { })
  end

  def destroy
    @page = current_user.pages.find(params[:id])
    page_name = @page.name

    if destroy_html_file(page_name) && @page.destroy
      render turbo_stream: [
          turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :notice, content: "Success! Your page at #{ENV['ROOT_URL']}/#{page_name} has been deleted." }),
          turbo_stream.update(:modal, html: ''),
          turbo_stream.remove(@page)
      ]
    else
      render turbo_stream: turbo_stream.append(:flash_notification_container, partial: 'shared/flash', locals: { kind: :alert, content: "Oops. There was a problem with deleting your page."})
    end
  end

  private

  def destroy_html_file(page_name)
    path_to_file = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{page_name}.html")
    if File.exist?(path_to_file)
      File.delete(path_to_file)
    else
      true
    end
  end
end
