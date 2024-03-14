task sample_data: :environment do

  puts "Creating sample data"
  if Rails.env.development?
    User.destroy_all
    p "users destroyyyy"
  end

  usernames = Array.new(2) { Faker::Name.first_name.downcase }

  usernames << "alice"
  usernames << "bob"

  usernames.each do |username|
    User.create!(
      email: "#{username}@example.com",
      password: "password",
      username: username,
      private: [true, false].sample,
    )
  end

  10.times do
    name = Faker::Name.first_name.downcase
    User.create!(
      email: "#{name}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )
  end

  puts "There are now #{User.count} users."

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.7
        first_user.sent_follow_requests.create!(
          recipient: second_user,
          status: ["pending", "accepted", "rejected"].sample
        )
      end
    end
  end

  users.each do |first_user|
    users.each do |second_user|
      next if first_user == second_user

      if rand < 0.75
        first_user.sent_follow_requests.create!(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create!(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  puts "There are now #{FollowRequest.count} follow requests."

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create!(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5 && !photo.fans.include?(follower)
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create!(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end

  puts "There are now #{User.count} users."
  puts "There are now #{FollowRequest.count} follow requests."
  puts "There are now #{Photo.count} photos."
  puts "There are now #{Like.count} likes."
  puts "There are now #{Comment.count} comments."
end
