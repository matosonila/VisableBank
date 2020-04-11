class Client < ApplicationRecord

  validates :client_number, presence: true, uniqueness: true

  has_many :account_transactions

  def get_json
    j = {}
    j[:client_number] = client_number
    j
  end


end
