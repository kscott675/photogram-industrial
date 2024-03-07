desc "Fill the database tables with some sample data"
task sample_data: :environment do
  puts "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
    User.destroy_all
  end

  12.times do
    name = Faker::Name.unique.first_name.downcase
    user = User.create(
      email: "#{name}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )
  end

  puts "There are now #{User.count} users."

  users = User.all

  12.times do
    sender = users.sample
    recipient = users.sample

    # Ensure sender and recipient are different users
    while sender == recipient
      recipient = users.sample
    end

    sender.sent_follow_requests.create(
      recipient: recipient,
      status: FollowRequest.statuses.keys.sample,
    )
  end

  puts "There are now #{FollowRequest.count} sent follow requests"

  users.each do |user|
    photo_image = Faker::Avatar.image
    caption = Faker::Quotes::Shakespeare.as_you_like_it_quote

    photo = Photo.create(
      image: photo_image,
      caption: caption,
      owner_id: user.id,
    )
  end

  puts "There are now #{Photo.count} photos"

  photos = Photo.all

  photos.each do |photo|
    users = User.all.pluck(:id)
    random_quote = Faker::JapaneseMedia::OnePiece.quote
    comment = Comment.create(
      photo_id: photo.id,
      author_id: users.sample,
      body: random_quote,
    )

    like = Like.create(
      fan_id: users.sample,
      photo_id: photo.id,
    )
  end

  puts "There are now #{Like.count} likes and #{Comment.count} comments"
end
