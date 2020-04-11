module Api
  module V1
    class BankAccountsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def new_transaction
        if params[:amount] && params[:transaction_type] && params[:bank_account_id] && params[:sender_bank_account_id]
        amount = params[:amount]
        transaction_type = params[:transaction_type]
        bank_account_id = params[:bank_account_id]
        sender_bank_account_id = params[:sender_bank_account_id]

        errors = ValidateNewTransaction.new(
            amount: amount,
            transaction_type: transaction_type,
            bank_account_id: bank_account_id,
            sender_bank_account_id: sender_bank_account_id
        ).execute!

        if errors.size > 0
          render json: { errors: errors }, status: 402
        else
          bank_account = PerformTransaction.new(
              amount: amount,
              transaction_type: transaction_type,
              receiver_bank_account_id: bank_account_id,
              sender_bank_account_id: sender_bank_account_id
          ).execute!

          render json: { data: bank_account.get_json }
        end
        else
          render json: { error: 'Check params'}, status: 402
        end
      end

      def show
        if params[:id]
          @bank_account = BankAccount.find(params[:id])
          @transactions = @bank_account.account_transactions.last(10)
          render json: { data: { bank_account: @bank_account.get_json, transactions: @transactions } }
        else
          render json: { error: 'id is required'}, status: 402
        end
      end

      private

      def bank_account_params
        params.require(:bank_account).permit(:account_number, :client_id)
      end
    end
  end
end