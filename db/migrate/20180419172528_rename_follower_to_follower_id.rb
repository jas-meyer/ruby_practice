class RenameFollowerToFollowerId < ActiveRecord::Migration
  def change
  	change_table :follows do |t|
      t.rename :follower, :follower_id
  end
end
end
