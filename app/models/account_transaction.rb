class AccountTransaction < ApplicationRecord
  belongs_to :bank_account

  TRANSACTION_TYPES = %w(transfer).freeze

  validates :bank_account, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_number, presence: true, uniqueness: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }

  before_validation :load_defaults

  def get_json
    j = {}
    j[:amount] = amount
    j[:transaction_number] = transaction_number
    j[:transaction_type] = transaction_type
  end

  def load_defaults
    self.transaction_number = SecureRandom.uuid if new_record?
  end
end
