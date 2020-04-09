FactoryBot.define do
  factory :inventory do
    user { nil }
    items { "rice\r\n\r\nwater\r\n\r\ntomato" }
  end
end
