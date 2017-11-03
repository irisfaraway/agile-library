json.extract! book, :id, :status, :title, :author, :location, :created_at, :updated_at
json.url book_url(book, format: :json)
