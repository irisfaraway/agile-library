require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '#title' do
    context 'when a book is created' do
      it 'is not valid without a title' do
        book = build(:book, title: nil)
        expect(book).to_not be_valid
      end

      it 'is not valid with a duplicate title' do
        book_a = create(:book, title: 'Unique title')
        book_b = build(:book, title: 'Unique title')

        expect(book_a).to be_valid
        expect(book_b).to_not be_valid
      end
    end

    context 'when a book is updated' do
      let(:book) { build(:book) }

      it 'is not valid without a title' do
        book.title = nil
        expect(book).to_not be_valid
      end
    end
  end

  describe '#author' do
    context 'when a book is created' do
      it 'is not valid without an author' do
        book = build(:book, author: nil)
        expect(book).to_not be_valid
      end
    end

    context 'when a book is updated' do
      let(:book) { build(:book) }

      it 'is not valid without an author' do
        book.author = nil
        expect(book).to_not be_valid
      end
    end
  end

  describe '#status' do
    context 'when a book is created' do
      let(:book) { build(:book) }

      it 'should be available' do
        expect(book).to have_state(:available)
      end
    end

    context 'when a book is available' do
      let(:book) { build(:book, :is_available) }

      it 'should be able to be borrowed' do
        expect(book).to allow_event :borrow
      end

      it 'should not be able to be returned' do
        expect(book).to_not allow_event :return
      end
    end

    context 'when a book is borrowed' do
      let(:book) { build(:book, :is_available) }

      it 'should change status to on loan' do
        book.borrow!
        expect(book).to have_state(:on_loan)
      end
    end

    context 'when a book is on loan' do
      let(:book) { build(:book, :is_on_loan) }

      it 'should be able to be returned' do
        expect(book).to allow_event :return
      end

      it 'should not be able to be borrowed' do
        expect(book).to_not allow_event :borrow
      end
    end

    context 'when a book is returned' do
      let(:book) { build(:book, :is_on_loan) }

      it 'should change status to available' do
        book.return!
        expect(book).to have_state(:available)
      end
    end
  end
end
