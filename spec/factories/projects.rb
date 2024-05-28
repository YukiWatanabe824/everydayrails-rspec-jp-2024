FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description { "A test project." }
    due_on { 1.week.from_now }
    association :owner

    # 今日が締め切りのプロジェクト
    factory :project_due_today do
      due_on { Date.current.in_time_zone }
    end

    # 締切が明日
    trait :due_tomorrow do
      due_on { 1.day.from_now }
    end

    # メモ付きのプロジェクト
    trait :with_notes do
      after(:create) do |project|
        create_list(:note, 5, project: project)
      end
    end
  end

  # 昨日が締め切りのプロジェクト
  factory :project_due_yesterday, class: Project do
    sequence(:name) { |n| "Test Project #{n}" }
    description { "Sample project for testing purposes" }
    due_on { 1.day.ago }
    association :owner
  end
end
