require 'spec_helper'

describe 'Books' do
  let(:user) { FactoryGirl.create(:user) }

  before {
    visit signin_path
    click_link 'Developer'
    fill_in 'name', with: user.name
    fill_in 'email', with: user.email
    click_button 'Sign In'
  }

  describe 'GET /books' do
    it 'displays a list of books' do
      b1 = user.books.create(:title => 'Fitness for Geeks')
      b2 = user.books.create(:title => 'Search Patterns')

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
      b1 = user.books.create(:title => 'Fitness for Geeks')
      b2 = user.books.create(:title => 'Search Patterns')

      visit books_path
      page.find("#delete-#{b1.id}").click

      page.should_not have_content('Fitness for Geeks')
      page.should have_content('Search Patterns')
    end
  end
end
