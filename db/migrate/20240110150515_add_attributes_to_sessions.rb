class AddAttributesToSessions < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :sessions, :user
    add_column :sessions, :token, :string
  end
end
