class LikesController < ApplicationController
  def save_new_row
    like = Like.new
    like.photo_id = params.fetch("picture_id")
    like.fan_id = current_user.id

    like.save

    photo = Photo.where({ :id => like.photo_id }).at(0)
    photo.likes_count = photo.likes_count + 1
    photo.save

    redirect_to("/photos/" + like.photo_id.to_s)
  end
  
  def goodbye
    l = Like.where({ :id => params.fetch("id_to_remove") }).at(0)
    l.destroy
    redirect_to("/photos/" + l.photo_id.to_s)
  end
end
