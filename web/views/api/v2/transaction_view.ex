defmodule ExMoney.Api.V2.TransactionView do
  use ExMoney.Web, :view

  alias ExMoney.Api.V2.TransactionView

  def render("recent.json", %{transactions: transactions}) do
    render_many(transactions, TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
       id: transaction.id,
       made_on: transaction.made_on,
       amount: transaction.amount,
       amount_millicents: ExMoney.Money.to_millicents(transaction.amount),
       currency_code: transaction.currency_code,
       description: transaction.description,
       account_id: transaction.account_id,
       transaction_info: render_one(transaction.transaction_info, TransactionView, "transaction_info.json", as: :transaction_info),
       category: render_one(transaction.category, TransactionView, "category.json", as: :category)
     }
  end

  def render("transaction_info.json", %{transaction_info: transaction_info}) do
    %{
       payee: transaction_info.payee,
       information: transaction_info.information,
       additional: transaction_info.additional
     }
  end

  def render("category.json", %{category: category}) do
    %{
       id: category.id,
       name: category.name
     }
  end
end