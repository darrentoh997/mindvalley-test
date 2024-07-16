# Server
Before starting the server, ensure that your terminal is in the right directory

To start the server:
  * Change the database credentials to your credentials in the file `/config/dev.exs`
  * Run `mix setup`
  * Run `mix phx.server`
  * If the seed is not inserted during `mix setup` you may also run `mix run priv/repo/seeds.exs` to insert it

To run the test cases: 
  * Run `mix test`