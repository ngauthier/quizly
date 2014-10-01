class CreateFullTextSearchIndex < ActiveRecord::Migration
  def up
    # the normal array_to_string is technically mutable because it depends
    # on the language. We'll create an immutable one here to wrap the original
    # since in our index we're only using some characters
    execute %{
    create function array_to_string_immutable(text[], text) returns text
      language sql
      immutable strict
      as $$
        select array_to_string($1, $2)
      $$
    }
    execute %{
      create index questions_full_text_vector on questions using gin(
        to_tsvector('english', question || ' ' || answer || ' ' || array_to_string_immutable(distractors, ', '))
      )
    }
  end

  def down
    execute %{drop index questions_full_text_vector}
    execute %{drop function array_to_string_immutable(text[], text)}
  end
end
