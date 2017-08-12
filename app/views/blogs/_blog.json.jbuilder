json.extract! blog, :id, :article, :title, :image_id, :date, :lat, :lng, :created_at, :updated_at
json.url blog_url(blog, format: :json)
