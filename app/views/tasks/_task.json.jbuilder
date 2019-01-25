json.extract! task, :id, :title, :photo, :content, :created_at, :updated_at
json.url task_url(task, format: :json)
