# State machine for books
module CanChangeStatus
  extend ActiveSupport::Concern

  included do
    include AASM

    enum status: {
      available: 1,
      on_loan: 2
    }

    aasm column: :status, enum: true do
      state :available, initial: true
      state :on_loan

      event :borrow do
        transitions from: :available,
                    to: :on_loan,
                    after: :set_borrower
      end

      event :return do
        transitions from: :on_loan,
                    to: :available,
                    after: :clear_borrower
      end
    end
  end

  def set_borrower
    # TODO: Set user who borrows the book
  end

  def clear_borrower
    # TODO: Remove user who borrowed the book
  end
end
