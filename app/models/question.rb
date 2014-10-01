require 'csv'

class Question < ActiveRecord::Base
  validates_presence_of :question, :answer
  validates_length_of   :distractors, minimum: 1, too_short: "can't be empty"

  scope :search, ->(query) {
    if query.present?
      where(%{
        to_tsvector('english', question || ' ' || answer || ' ' || array_to_string_immutable(distractors, ', ')) @@
          plainto_tsquery(?)
      }, query)
    end
  }

  scope :sort, ->(sort_by) {
    if sort_by.present?
      order(sort_by)
    else
      order(:created_at)
    end
  }

  scope :filter, ->(filter_by) {
    case filter_by.to_s
    when 'short'
      filter_short
    when 'long'
      filter_long
    end
  }

  scope :filter_short, -> { where("array_length(questions.distractors, 1) < 4") }
  scope :filter_long,  -> { where("array_length(questions.distractors, 1) > 3") }

  def self.from_csv(io)
    CSV.parse(io.read, headers: true, col_sep: "|") do |row|
      Question.create!(row.to_h)
    end
  end

  def distractors=(d)
    write_attribute "distractors", case d
    when String
      d.split(/, ?/)
    else
      d
    end
  end
end
