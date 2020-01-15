# How the project is structured
1. I decided to make make `currency` and `user` as agents since they will require to store and some information

2. Each `ExBanking` application will be it's own process that connects to a `user`

# How to run program
1. `cd ex_banking`
2. `mix deps.get`
3. `iex -S mix`
4. `ExBanking.init_bank()` will return a pid which you can use to tes the main apis



