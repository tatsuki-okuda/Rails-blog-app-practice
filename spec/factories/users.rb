FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    # userのダミーデータ作成と同時にプロフィールも一緒に作ることができる。  
    trait :with_profile do
      # 元になっているデータが作成された後に実行される。
      # 今回だとuserが作成された後に
      after :build do |user|
        build(:profile, user: user)
      end
    end
  end
end