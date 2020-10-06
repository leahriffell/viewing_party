class ChangeDateTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :viewing_parties, :date, :party_date
    rename_column :viewing_parties, :time, :start_time
  end
end
