# frozen_string_literal: true

json.extract! fruit, :id, :name, :description, :created_at, :updated_at, :position
json.url fruit_url(fruit, format: :json)
