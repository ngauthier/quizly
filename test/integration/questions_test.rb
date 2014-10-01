require 'test_helper'

class QuestionsTest < ActionDispatch::IntegrationTest
  test "load and view questions" do
    Question.from_csv(fixture_file("questions-single.csv"))
    assert_equal 1, Question.count
    
    visit "/"

    assert_see "Questions"
    assert_see "What is 2+2?"
    assert_see "4"
    assert_see "6"
    assert_see "8"
  end

  test "paginate questions" do
    Question.from_csv(fixture_file("questions-medium.csv"))
    assert_equal 200, Question.count

    visit "/"

    assert_see "Question 15"
    refute_see "Question 55"

    within ".pagination" do
      click_link "2"
    end

    refute_see "Question 15"
    assert_see "Question 55"
  end
end
