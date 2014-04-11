FactoryGirl.define do
  factory :route do
    id "44"
    name "U. of Chicago/Midway"
    number "170"
  end

  factory :direction do
    name "North"
  end

  factory :stop do
    number "572"
    name "Chicago & Franklin (Brown Line)"
  end
end
