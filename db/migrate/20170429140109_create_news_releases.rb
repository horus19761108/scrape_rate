class CreateNewsReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :news_releases do |t|
      t.string :rating_agency
      t.string :news_id
      t.date :news_date
      t.string :syubetu
      t.text :news
      t.string :links

      t.timestamps
    end
  end
end
