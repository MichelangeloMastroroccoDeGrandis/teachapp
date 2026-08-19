class AddFeedbackToSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_column :submissions, :feedback, :text
  end
end
