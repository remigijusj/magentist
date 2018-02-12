defmodule MagentistWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types MagentistWeb.Schema.AccountTypes

  alias MagentistWeb.Resolvers

  query do
    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.find_user/3
    end
  end
end
