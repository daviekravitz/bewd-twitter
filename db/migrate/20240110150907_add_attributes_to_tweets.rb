class AddAttributesToTweets < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :tweets, :user
    add_column :tweets, :message, :string
  end
end
