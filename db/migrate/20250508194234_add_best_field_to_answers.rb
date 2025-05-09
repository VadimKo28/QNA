class AddBestFieldToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :by_best, :boolean, default: false
  end
end
