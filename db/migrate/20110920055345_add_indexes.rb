class AddIndexes < ActiveRecord::Migration
  def up
    # events
    add_index :events, [:submitter_id, :submitter_type]
    add_index :events, :approved

    # categories
    add_index :categories, :name, :unique => true

    # categorization
    add_index :categorizations, [:event_id, :category_id]
    add_index :categorizations, :category_id

    # clients
    add_index :clients, :confirmed

    # tags
    add_index :tags, :name, :unique => true

    # tagging
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, :tag_id

    # ads
    add_index :ads, :client_id
    add_index :ads, :price
    add_index :ads, :confirmed

    # users
    add_index :users, :client_id
    add_index :users, :admin

    # showtimes
    add_index :showtimes, :event_id
  end

  def down
    # events
    remove_index :events, [:submitter_id, :submitter_type]
    remove_index :events, :approved

    # categories
    remove_index :categories, :name

    # categorization
    remove_index :categorizations, :category_id
    remove_index :categorizations, [:event_id, :category_id]

    # clients
    remove_index :clients, :confirmed

    # tags
    remove_index :tags, :name

    # taggings
    remove_index :taggings, :tag_id
    remove_index :taggings, [:taggable_id, :taggable_type]

    # ads
    remove_index :ads, :confirmed
    remove_index :ads, :price
    remove_index :ads, :client_id

    # users
    remove_index :users, :admin
    remove_index :users, :client_id

    # showtimes
    remove_index :showtimes, :event_id
  end
end
