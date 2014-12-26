Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :name
      String :handler, null: false
      String :encrypted_password, null: false
    end
  end

  down do
    drop_table :users
  end
end