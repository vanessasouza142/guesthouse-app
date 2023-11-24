class ChangeReviewTextFromStringToText < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :review_text, :text
  end
end
