require 'rails_helper'

RSpec.describe "CreatingBooks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'creates a new book' do
    visit '/books/new'
    fill_in 'Title', with: 'FOO'
    click_on 'Create Book'
    expect(page).to have_content('Book was successfully created.')
  end

  it 'creates a new book' do
    visit '/books/new'
    fill_in 'Title', with: ''
    click_on 'Create Book'
    expect(page).to have_content('Book could not be created')
  end

   it "sets and gets the book title" do
    book = Book.new(title: "Testing book")
    expect(book.title).to eq("Testing book")
  end

  it "sets and gets the author" do
    book = Book.new(author: "John Cena")
    expect(book.author).to eq("John Cena")
  end

  it "sets and gets the published date" do
    book = Book.new(published_date: "2024-12-12")
    expect(book.published_date.to_s).to eq("2024-12-12")
  end

  it "sets and gets the price" do
    book = Book.new(price: 44.44)
    expect(book.price).to eq(44.44)
  end

  it "creates a book with author, published date, and price" do
    post books_path, params: { book: { title: "Sample Title", author: "John Doe", published_date: "2022-01-01", price: 29.99 } }
    expect(response).to redirect_to(book_path(Book.last))
    follow_redirect!

    expect(response.body).to include("Sample Title")
    expect(Book.last.author).to eq("John Doe")
    expect(Book.last.published_date.to_s).to eq("2022-01-01")
    expect(Book.last.price).to eq(29.99)
  end

  let(:book) { Book.create(title: "Old Title", author: "Jane Doe", published_date: "2020-01-01", price: 19.99) }
  it "updates a book's details" do
    patch book_path(book), params: { book: { title: "New Title", author: "Jane Smith", published_date: "2021-01-01", price: 24.99 } }
    
    expect(response).to redirect_to(book_path(book))
    follow_redirect!
    
    expect(response.body).to include("New Title")
    book.reload
    expect(book.author).to eq("Jane Smith")
    expect(book.published_date.to_s).to eq("2021-01-01")
    expect(book.price).to eq(24.99)
  end
    
    
 
end
