class Page < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { message: 'already exists, try another page name.' }, format: { with: /\A[a-zA-Z0-9\-_]*\z/, message: 'can only contain letters and numbers. Special characters and whitespace is not allowed.' }

  def path
    "/#{name}"
  end

  def url
    "#{ENV['ROOT_URL']}/#{name}"
  end

  def size
    path_to_file = Rails.root.join("#{ENV['PUBLIC_PATH']}/#{name}.html")

    return unless File.exists?(path_to_file)

    File.size(path_to_file)
  end
end
