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
      question: "What is the best bear?",
      answer: "brown",
      distractors: ["panda"]
    )

    visit "/"
    assert_see "brown"
    refute_see "black"

    click_link "Edit"

    fill_in "Answer", with: "black"
    click_button "Update Question"

    assert_see "black"
    refute_see "brown"
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

  test "search questions" do
    Question.from_csv(fixture_file("questions-medium.csv"))
    visit "/"
    fill_in "query", with: "Question 200"
    click_button "Search"
    assert_see "Question 200"
  end

  test "pagination and search" do
    Question.from_csv(fixture_file("questions-medium.csv"))
    visit "/"
    fill_in "query", with: "Question"
    click_button "Search"
    assert_see "Question 49"
    refute_see "Question 65"
    click_link "2"
    refute_see "Question 49"
    assert_see "Question 65"
  end

  test "sorting" do
    Question.from_csv(fixture_file("questions-medium.csv"))
    visit "/"
    refute_see "Question 98"
    within '.distractors' do
      click_link "v"
    end
    assert_see "Question 98"
    within '.distractors' do
      click_link "^"
    end
    refute_see "Question 98"
    assert_see "Question 100"
  end

  test "filter by number of distractions" do
    Question.from_csv(fixture_file("questions-small-varied.csv"))
    visit "/"

    assert_see "Short Question"
    assert_see "Long Question"

    click_link "1-3 Distractions"
    assert_see "Short Question"
    refute_see "Long Question"

    click_link "4-10 Distractions"
    assert_see "Long Question"
    refute_see "Short Question"
  end
end
