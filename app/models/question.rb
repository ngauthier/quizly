require 'csv'

class Question < ActiveRecord::Base
  def self.from_csv(io)
    CSV.parse(io.read, headers: true, col_sep: "|") do |row|
      attrs = row.to_h
      attrs["distractors"] = attrs["distractors"].split(/, ?/)
      Question.create!(attrs)
    end
  end
end
