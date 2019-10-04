defmodule User.Application do

  use Application
  import Supervisor.Spec

  alias User

  def start(_type, _args) do
    children = [
      worker(User, [])
    ]

    options = [
      name: User.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
  end

end
