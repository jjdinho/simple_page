class Page < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { message: 'already exists, try another page name.' }, format: { with: /\A[a-zA-Z0-9\-_]*\z/, message: 'no special characters allowed, only letters and numbers' }

  def path
    "/#{name}"
  end

  def url
    "#{ENV['ROOT_URL']}/#{name}"
  end

  def size
    path_to_file = Rails.root.join("public/#{name}.html")

    return unless File.exists?(path_to_file)

    File.size(path_to_file)
  end
end
