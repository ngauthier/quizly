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
- [x] binary to load data from file
- [ ] pretty errors on question form
- [x] high performance benchmarking

## Assumptions


## Notes

Data loading and display, pagination, create, edit, delete, sort, and filtering were done in under 2 hours with 83 LOC of Ruby and 81 LOC of templates. There were 132 LOC of tests, yielding a test:code ratio of 0.80.

For 1 million records, a full text query too 20 seconds unindexed. After adding the index, the query took 2ms.
