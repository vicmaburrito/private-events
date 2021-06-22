json.extract! event, :id, :name, :start_date, :location, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
