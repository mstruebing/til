defmodule Til.Learnings do
  @moduledoc """
  The Learnings context.
  """

  import Ecto.Query, warn: false
  alias Til.Repo
  alias Til.Accounts

  alias Til.Learnings.Learning

  @doc """
  Returns the list of learnings.

  ## Examples

      iex> list_learnings()
      [%Learning{}, ...]

  """
  def list_learnings do
    Repo.all(Learning)
  end

  def list_learnings(%{user_id: user_id}) do
    Repo.get_by(Learning, user_id: user_id)
  end

  def list_learnings(%{handle: handle}) do
    user = Accounts.get_user_by_handle(handle)
    Repo.get_by(Learning, user_id: user.id)
  end

  def list_learnings(%{tag: tag}) do
    query =
      from(l in Learning,
        where: ^tag in l.tags,
        select: [:id, :user_id, :content, :tags, :updated_at, :inserted_at]
      )

    Repo.all(query)
  end

  @doc """
  Gets a single learning.

  Raises `Ecto.NoResultsError` if the Learning does not exist.

  ## Examples

      iex> get_learning!(123)
      %Learning{}

      iex> get_learning!(456)
      ** (Ecto.NoResultsError)

  """
  def get_learning!(id), do: Repo.get!(Learning, id)

  @doc """
  Creates a learning.

  ## Examples

      iex> create_learning(%{field: value})
      {:ok, %Learning{}}

      iex> create_learning(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_learning(attrs \\ %{}) do
    %Learning{}
    |> Learning.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a learning.

  ## Examples

      iex> update_learning(learning, %{field: new_value})
      {:ok, %Learning{}}

      iex> update_learning(learning, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_learning(%Learning{} = learning, attrs) do
    learning
    |> Learning.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Learning.

  ## Examples

      iex> delete_learning(learning)
      {:ok, %Learning{}}

      iex> delete_learning(learning)
      {:error, %Ecto.Changeset{}}

  """
  def delete_learning(%Learning{} = learning) do
    Repo.delete(learning)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking learning changes.

  ## Examples

      iex> change_learning(learning)
      %Ecto.Changeset{source: %Learning{}}

  """
  def change_learning(%Learning{} = learning) do
    Learning.changeset(learning, %{})
  end
end
