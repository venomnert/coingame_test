defmodule ExBanking.Application do

  use Application
  import Supervisor.Spec

  alias ExBanking.Server

  def start(_type, _args) do
    children = [
      worker(Server, [])
    ]

    options = [
      name: ExBanking.Supervisor,
      strategy: :simple_one_for_one,
    ]

    Supervisor.start_link(children, options)
  end

end
