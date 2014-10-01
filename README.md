# Quizly

## Setup

Standard Rails setup:

    bundle install

Tests:

    rake

Server:

    rails server

## TODO

- [x] pagination
- [x] create a question
- [x] edit a question
- [x] delete a question
- [x] search questions
- [x] sort questions
- [x] number of distractions filter
- [ ] basic styling
- [ ] ux: dynamic distraction fields
- [ ] ux: find-as-you-type
- [ ] binary to load data from file
- [ ] pretty errors on question form
- [ ] high performance benchmarking

## Assumptions


## Notes

Data loading and display, pagination, create, edit, delete, sort, and filtering were done in under 2 hours with 83 LOC of Ruby and 81 LOC of templates. There were 132 LOC of tests, yielding a test:code ratio of 0.80.
