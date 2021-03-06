# frozen_string_literal: true

class AddLastUpdatedUserToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :last_updated_user_id, :integer
  end
end
