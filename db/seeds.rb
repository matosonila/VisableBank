Client.create!(first_name: "Sonila", last_name: "Mato", client_number: "J42034823")
Client.create!(first_name: "Test", last_name: "Test", client_number: "J42033823")
client = Client.first
client2 = Client.last
BankAccount.create!(client: client, account_number: "000000001")
BankAccount.create!(client: client2, account_number: "000000002")

