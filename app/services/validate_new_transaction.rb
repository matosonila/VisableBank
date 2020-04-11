class ValidateNewTransaction
    def initialize(amount: , transaction_type: , bank_account_id: , sender_bank_account_id: )
      @amount = amount.try(:to_i)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id
      @bank_account = BankAccount.where(id: @bank_account_id).first
      @sender_bank_account_id = BankAccount.where(id: sender_bank_account_id).first
      @errors = []
    end

    def execute!
      validate_existence_of_account!

      if @transaction_type == "transfer" && @bank_account.present?
        validate_withdrawal!
      end
      @errors
    end

    private

    def validate_withdrawal!
      if @sender_bank_account_id.balance - @amount < 0.00
        @errors << "Not enough money"
      end
    end

    def validate_existence_of_account!
      @errors << "Account not found" if @bank_account.blank? || @sender_bank_account_id.blank?
      @errors << "Account is the same" if @bank_account == @sender_bank_account_id
    end
end