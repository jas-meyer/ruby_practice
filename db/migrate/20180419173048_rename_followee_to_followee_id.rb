class RenameFolloweeToFolloweeId < ActiveRecord::Migration
  def change
  	change_table :follows do |t|
      t.rename :followee, :followee_id
  end
  end
end
