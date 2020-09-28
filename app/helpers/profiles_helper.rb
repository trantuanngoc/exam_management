module ProfilesHelper
  # Returns the Gravatar for the given user.
  def avatar_for(user, width, height)
    image_tag("profile_picture", alt: user.email, height: height, width: width)
  end
end
