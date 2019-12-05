defmodule KataMasterInfra.UserTable do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "users" do
    field(:pseudo, :string)
    field(:name, :string)
    field(:email, :string)

    timestamps()
  end

  #  def base_changeset(%UserTable{} = shift, attrs) do
  #    shift
  #    |> cast(attrs, [
  #      :name,
  #      :start_at,
  #      :end_at,
  #      :drivers_instructions,
  #      :service_request_id
  #    ])
  #    |> foreign_key_constraint(:service_request_id)
  #  end

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
