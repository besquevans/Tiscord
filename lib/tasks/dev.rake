require "net/http"
require "uri"

namespace :dev do
  task fake_users: :environment do
    print "\n正在建立使用者資料"
    User.destroy_all

    count = 10
    uri = URI("https://uifaces.co/api?limit=#{count}")
    req = Net::HTTP::Get.new(uri)

    req['X-API-KEY'] = ENV["UI_face_X_API_KEY"]
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
    avatars = JSON.parse(response.body)

    avatars.each do |avatar|
      # image_url = Faker::Avatar.image(size: "50x50", format: "jpg")
      image_url = avatar["photo"]
      user = User.create!(
        username: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: "123456",
        remote_avatar_url: image_url             #carrierwave
      )

      print "."
    end

    puts "\n成功建立 #{User.count} 筆 使用者資料！"
    puts User.last.email
  end

  task fake_groups: :environment do
    print "\n正在建立使用者 board 資料"
    Group.destroy_all

    count = 3
    count.times do
      num = rand(1000)
      Group.create!(
        remote_avatar_url: "https://picsum.photos/500/500/?random=#{num}",
        name: Faker::Name.first_name,
        manager_id: User.find(User.pluck(:id).sample).id
      )
      print "."
    end

    puts "\n成功建立 #{Group.count} 筆 group 資料！"
  end

  task fake_boards: :environment do
    print "\n正在建立使用者 boards 資料"
    Board.destroy_all

    count = 2
    Group.all.each do |group|
      count.times do
        group.boards.create!(
          name: Faker::Name.first_name
        )
        print "."
      end
    end

    puts "\n成功建立 #{Board.count} 筆 board 資料！"
  end

  task fake_messages: :environment do
    print "\n正在建立使用者 messages 資料"
    Message.destroy_all

    count = 8
    Board.all.each do |group|
      count.times do
        group.messages.create!(
          content: Faker::Lorem.sentence,
          user_id: User.find(User.pluck(:id).sample).id
        )
        print "."
      end
    end

    puts "\n成功建立 #{Message.count} 筆 message 資料！"
  end

  task fake_all: :environment do
    Rake::Task["dev:fake_users"].invoke
    Rake::Task["dev:fake_groups"].invoke
    Rake::Task["dev:fake_boards"].invoke
    Rake::Task["dev:fake_messages"].invoke
  end
end
