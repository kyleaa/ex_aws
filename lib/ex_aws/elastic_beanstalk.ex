defmodule ExAws.ElasticBeanstalk do
  @moduledoc """
  Operations on AWS EC2
  """

  import ExAws.Utils, only: [camelize_key: 1, camelize_keys: 1]

  @version "2010-12-01"

  @type describe_environment_resources_opts :: [
    {:environment_id, binary} |
    {:environment_name, binary}
  ]

  @doc """
  Returns AWS resources for this environment.
  """
  @spec describe_environment_resources() :: ExAws.Operation.RestQuery.t
  @spec describe_environment_resources(opts :: describe_environment_resources_opts) :: ExAws.Operation.RestQuery.t
  def describe_environment_resources(opts \\ []) do

    request(:describe_environment_resources, normalize_opts(opts))
  end

  ########################
  ### Helper Functions ###
  ########################

  defp request(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.put("Action", action_string),
      service: :elasticbeanstalk,
      action: action,
      parser: &ExAws.ElasticBeanstalk.Parsers.parse/2
    }
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
