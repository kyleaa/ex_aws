if Code.ensure_loaded?(SweetXml) do
  defmodule ExAws.ElasticBeanstalk.Parsers do
    import SweetXml, only: [sigil_x: 2]
    def parse({:ok, %{body: xml}=resp}, :describe_environment_resources) do
      parsed_body = xml
      |> SweetXml.xpath(~x"//DescribeEnvironmentResourcesResponse/DescribeEnvironmentResourcesResult/EnvironmentResources",
        instances: [
          ~x"./Instances/member"l,
          id: ~x"./Id/text()"s
        ],
        environment_name: ~x"./EnvironmentName/text()"s,
        load_balancers: [
          ~x"./LoadBalancers/member"l,
          name: ~x"./Name/text()"s
        ]
      )
      {:ok, Map.put(resp, :body, parsed_body)}
    end

    def parse(val, _), do: val

  end
end
