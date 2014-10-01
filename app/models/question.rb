require 'csv'

class Question < ActiveRecord::Base
  validates_presence_of :question, :answer
  validates_length_of   :distractors, minimum: 1, too_short: "can't be empty"

  scope :search, ->(query) {
    if query.present?
      where(%{
        to_tsvector(question || ' ' || answer || ' ' || array_to_string(distractors, ', ')) @@
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
