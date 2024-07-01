class CreateBulletinsAndCategories < ActiveRecord::Migration[7.1]
  def change
    users = []
    categories = Category.all
    image_names = ['image_0.jpg', 'image_1.jpg', 'image_2.jpg']

    2.times do
      users << User.create(name: Faker::Name.name, email: Faker::Internet.email)
    end

    100.times do
      bulletin = Bulletin.build(user: users.sample,
                                title: Faker::Lorem.sentence(word_count: 1),
                                description: Faker::Lorem.paragraph,
                                category: categories.sample,
                                state: 'published')

      bulletin.image.attach(io: File.open("test/fixtures/files/#{image_names.sample}"), filename: 'filename.jpg')
      bulletin.save
    end
  end
end
