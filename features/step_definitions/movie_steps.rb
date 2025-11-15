# Add a declarative step here for populating the DB with movies.

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # Parse the release_date string - handle both "25-Nov-1992" and "1979-05-25" formats
    release_date = if movie['release_date'] =~ /^\d{4}-\d{2}-\d{2}$/
                     Date.parse(movie['release_date'])
                   else
                     Date.strptime(movie['release_date'], '%d-%b-%Y')
                   end
    Movie.create!(
      title: movie['title'],
      rating: movie['rating'],
      release_date: release_date,
      director: movie['director']
    )
  end
end

Then(/(.*) seed movies should exist/) do |n_seeds|
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then(/^I should see "(.*)" before "(.*)"(?: in the movie list)?$/) do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  body = page.body
  index1 = body.index(e1)
  index2 = body.index(e2)
  
  expect(index1).not_to be_nil, "Expected to find '#{e1}' on the page"
  expect(index2).not_to be_nil, "Expected to find '#{e2}' on the page"
  expect(index1).to be < index2, "Expected '#{e1}' to appear before '#{e2}', but it didn't"
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I check only the following ratings: PG, G, R"

When(/I check the following ratings: (.*)/) do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(',').map(&:strip)
  ratings.each do |rating|
    step %{I check "#{rating}"}
  end
end

Then(/^I should (not )?see the following movies: (.*)$/) do |no, movie_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/
  movies = movie_list.split(',').map(&:strip)
  movies.each do |movie|
    if no
      step %{I should not see "#{movie}"}
    else
      step %{I should see "#{movie}"}
    end
  end
end

Then(/^I should see all the movies$/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

### Utility Steps Just for this assignment.

Then(/^debug$/) do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"
  byebug
  1 # intentionally force debugger context in this method
end

Then(/^debug javascript$/) do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then(/complete the rest of of this scenario/) do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  raise "Remove this step from your .feature files"
end
