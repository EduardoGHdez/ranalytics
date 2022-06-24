class GitHub::Event < ApplicationRecord
  self.inheritance_column = nil

  validates :type, presence: true
  validates :public, presence: true

  before_create -> do
    GitHub::Event::HourlyQueue.create!(
      type: type,
      count: 1,
      date: created_at.beginning_of_hour
    )
  end

  before_destroy -> do
    GitHub::Event::HourlyQueue.create!(
      type: type,
      count: -1,
      date: created_at.beginning_of_hour
    )
  end
end

