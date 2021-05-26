module ApplicationHelper

  def gravatar_for(user, size = 80)
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    # size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle mt-4 shadow mx-auto d-block")
  end
end
