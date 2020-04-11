class BankAccount < ApplicationRecord
  belongs_to :client

  validates :client, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true

  before_validation :load_defaults

  has_many :account_transactions

  def get_json
    j = {}
    j[:account_number] = account_number
    j[:client] = client
    j[:balance] = balance
    j
  end

  def load_defaults
    self.balance = 0.00 if self.new_record?
  end
end
