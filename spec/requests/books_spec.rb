require 'spec_helper'

describe 'Books' do
  describe 'GET /books' do
    it 'displays a list of books' do
      b1 = Book.create!(:title => 'Fitness for Geeks')
      b2 = Book.create!(:title => 'Search Patterns')

      visit books_path

      page.should have_content('Fitness for Geeks')
      page.should have_content('Search Patterns')
    end
  end

  describe 'POST /books' do
    it 'can create a book' do
      visit books_path

      fill_in 'Title', with: 'Search Patterns'
      click_button 'Add Book'

      page.should have_content('Search Patterns')
    end
  end

  describe 'DELETE /books' do
    it 'can delete a book', :js => true do
      b1 = Book.create!(:title => 'Fitness for Geeks')
      b2 = Book.create!(:title => 'Search Patterns')

      visit books_path
      page.find("#delete-#{b1.id}").click

      page.should_not have_content('Fitness for Geeks')
      page.should have_content('Search Patterns')
    end
  end
end
