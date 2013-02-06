# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert_not_nil(/#{e1}(.*)#{e2}/m.match(page.body))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |field|
    uncheck ? uncheck('ratings_'+field) : check('ratings_'+field)
  end
end

Then /^I should see all movies$/ do
  all_movies = Movie.all
  all_movies.each do |m|
    step "I should see: #{m.title}"
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
  page.should have_content(movie)
  page.should have_content(director)
end