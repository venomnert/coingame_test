defmodule Currency.Application do

  use Application
  import Supervisor.Spec
  alias Currency

  def start(_type, _args) do
    children = [
      worker(Currency, [])
    ]

    options = [
      name: Currency.Supervisor,
      strategy: :one_for_one,
    ]

    Supervisor.start_link(children, options)
  end

end
