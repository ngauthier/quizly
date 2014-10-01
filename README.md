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
- [x] ux: find-as-you-type
- [x] binary to load data from file
- [ ] pretty errors on question form
- [x] high performance benchmarking

## Assumptions

1. Full text search is set to English, so stopwords like "what" are not queryable. This is unfortunate since the sample data provided only has stopwords (what and is) and numbers and punctuation. To do an interesting query, search for numbers.
1. UX/Design were not prioritized, just functionality. My next steps would certainly be to clean up the interface. This was just seen as uninteresting from a demonstration perspective.

## Notes

Data loading and display, pagination, create, edit, delete, sort, and filtering were done in under 2 hours with 83 LOC of Ruby and 81 LOC of templates. There were 132 LOC of tests, yielding a test:code ratio of 0.80.

Benchmarking and find as you type took about 90 minutes and the now there are 119 lines of Ruby, 86 lines of templates, and 141 lines of tests. T:C ratio is 0.69.

During all stages of development code coverage was 100%.

For 1 million records, a full text query too 20 seconds unindexed. After adding the index, the query took 2ms.

Total time spent on the assignment was just under 4 hours.
