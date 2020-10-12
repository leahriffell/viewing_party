class AddTitleToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :title, :string
  end
end
