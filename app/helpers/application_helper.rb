module ApplicationHelper
  @random_image = "upload/" + Image.all[rand(Image.all.size)].nameHash + "_medium.jpg"
end
