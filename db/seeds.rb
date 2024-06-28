# frozen_string_literal: true

Bulletin.destroy_all
Category.destroy_all

users = []
categories = []
bulletin_states = Bulletin.aasm.states.map(&:name)
categories_names = ['Личные вещи', 'Транспорт', 'Работа', 'Недвижимость', 'Электронника', 'Животные']
image_names = ['image_0.jpg', 'image_1.jpg', 'image_2.jpg']

4.times do
  users << User.create(name: Faker::Name.name, email: Faker::Internet.email)
end

categories_names.each do |name|
  category = Category.find_or_create_by(name:)
  categories << category
end

100.times do
  bulletin = Bulletin.build(user: users.sample,
                            title: Faker::Lorem.sentence(word_count: 1),
                            description: Faker::Lorem.paragraph,
                            category: categories.sample,
                            state: bulletin_states.sample)

  bulletin.image.attach(io: File.open("test/fixtures/files/#{image_names.sample}"), filename: 'filename.jpg')
  bulletin.save
end
