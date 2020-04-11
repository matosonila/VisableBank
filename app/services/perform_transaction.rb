 class PerformTransaction
    def initialize(amount: , transaction_type: , receiver_bank_account_id: , sender_bank_account_id: )
      @amount = amount.to_f
      @transaction_type = transaction_type
      @bank_account_id = receiver_bank_account_id
      @sender_id = sender_bank_account_id
      @bank_account = BankAccount.where(id: @bank_account_id).first
      @sender = BankAccount.where(id: @sender_id).first
    end

    def execute!()
        AccountTransaction.create!(
            bank_account: @bank_account,
            amount: @amount,
            transaction_type: @transaction_type
        )

        if @transaction_type == "transfer"
          @bank_account.update!(balance: @bank_account.balance.to_f + @amount)
          @sender.update!(balance: @sender.balance.to_f - @amount)
        end

      @bank_account
    end
end
