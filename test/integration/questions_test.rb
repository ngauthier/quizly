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

  test "create a question" do
    visit "/"
    click_link "Create a question"

    fill_in "Question", with: "What color is the sky?"
    fill_in "Answer",   with: "Blue"
    fill_in "Distractors", with: "Red, Green, Purple"
    click_button "Create Question"

    assert_see "Questions"
    assert_see "What color is the sky?"

    assert_equal 1, Question.count
    question = Question.last
    assert_equal "What color is the sky?",   question.question
    assert_equal "Blue",                     question.answer
    assert_equal ["Red", "Green", "Purple"], question.distractors
  end

  test "try to create a bad question" do
    visit "/"
    click_link "Create a question"
    click_button "Create Question"
    assert_see "Question can't be blank"
    assert_see "Answer can't be blank"
    assert_see "Distractors can't be empty"
  end

  test "edit a question" do
    Question.create!(
      question: "What is 1+1?",
      answer: "3",
      distractors: ["4", "5"]
    )

    visit "/"
    assert_see "3"
    refute_see "2"

    click_link "Edit"

    fill_in "Answer", with: "2"
    click_button "Update Question"

    assert_see "2"
    refute_see "3"
  end

  test "try to edit a question in a bad way" do
    Question.create!(
      question: "What is 1+1?",
      answer: "3",
      distractors: ["4", "5"]
    )

    visit "/"
    click_link "Edit"

    fill_in "Answer", with: ""
    click_button "Update Question"

    assert_see "Answer can't be blank"
  end

  test "delete a question" do
    Question.create!(
      question: "What is 1+1?",
      answer: "3",
      distractors: ["4", "5"]
    )

    visit "/"
    assert_see "What is 1+1?"
    click_link "Delete"
    refute_see "What is 1+1?"
    assert_see "Questions"
    assert_equal 0, Question.count
  end
end
