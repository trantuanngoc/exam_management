module ProfilesHelper
  # Returns the Gravatar for the given user.
  def avatar_for(user)
    image_tag("profile_picture", alt: user.email, height: "100", width: "100")
  end
end
