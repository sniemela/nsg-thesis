class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name(params[:id])
    raise ActiveRecord::RecordNotFound unless @tag

    event_ids = @tag.taggings.select('taggings.taggable_id as id').where('taggings.taggable_type = ?', 'Event')
    @events = event_ids ? Event.find(event_ids.map(&:id)) : []
  end
end

