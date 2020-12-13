# frozen_string_literal: true

class AddPositionToFruit < ActiveRecord::Migration[6.0]
  def change
    add_column :fruits, :position, :integer
  end
end
