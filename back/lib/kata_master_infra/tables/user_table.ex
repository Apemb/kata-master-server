defmodule KataMasterInfra.UserTable do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:pseudo, :string)
    field(:name, :string)
    field(:email, :string)
    field(:github_id, :string)

    timestamps()
  end

  def user_aggregate_changeset(%UserTable{} = user, attrs) do
    user
    |> cast(attrs, [
      :pseudo,
      :name,
      :email,
      :github_id
    ])
  end

  #  def with_recurring_shift_changeset(shift, attrs, timezone) do
  #    changeset = base_changeset(shift, attrs)
  #
  #    changeset
  #    |> cast_assoc(:recurring_shift,
  #      with: &RecurringShift.changeset(&1, &2, changeset, timezone),
  #      required: true
  #    )
  #  end
end
