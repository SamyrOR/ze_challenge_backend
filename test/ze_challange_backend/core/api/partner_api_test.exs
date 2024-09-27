defmodule ZeChallengeBackend.Core.Partner.ApiTest do
  use ZeChallengeBackend.DataCase

  alias ZeChallengeBackend.Core.Partner

  describe "Partner API" do
    setup do
      params = %{
        id: 11,
        address: %{
          coordinates: [
            -43.297337,
            -23.013538
          ],
          type: "Point"
        },
        trading_name: "Adega Osasco",
        owner_name: "Ze da Ambev",
        document: "02.453.716/000170",
        coverage_area: %{
          coordinates: [
            [
              [
                [
                  -43.36556,
                  -22.99669
                ],
                [
                  -43.36539,
                  -23.01928
                ],
                [
                  -43.26583,
                  -23.01802
                ],
                [
                  -43.25724,
                  -23.00649
                ],
                [
                  -43.23355,
                  -23.00127
                ],
                [
                  -43.2381,
                  -22.99716
                ],
                [
                  -43.23866,
                  -22.99649
                ],
                [
                  -43.24063,
                  -22.99756
                ],
                [
                  -43.24634,
                  -22.99736
                ],
                [
                  -43.24677,
                  -22.99606
                ],
                [
                  -43.24067,
                  -22.99381
                ],
                [
                  -43.24886,
                  -22.99121
                ],
                [
                  -43.25617,
                  -22.99456
                ],
                [
                  -43.25625,
                  -22.99203
                ],
                [
                  -43.25346,
                  -22.99065
                ],
                [
                  -43.29599,
                  -22.98283
                ],
                [
                  -43.3262,
                  -22.96481
                ],
                [
                  -43.33427,
                  -22.96402
                ],
                [
                  -43.33616,
                  -22.96829
                ],
                [
                  -43.342,
                  -22.98157
                ],
                [
                  -43.34817,
                  -22.97967
                ],
                [
                  -43.35142,
                  -22.98062
                ],
                [
                  -43.3573,
                  -22.98084
                ],
                [
                  -43.36522,
                  -22.98032
                ],
                [
                  -43.36696,
                  -22.98422
                ],
                [
                  -43.36717,
                  -22.98855
                ],
                [
                  -43.36636,
                  -22.99351
                ],
                [
                  -43.36556,
                  -22.99669
                ]
              ]
            ]
          ],
          type: "MultiPolygon"
        }
      }

      {:ok, sucess_params: params}
    end

    test "get all partners" do
      assert {:ok, []} = Partner.Api.all()
    end

    test "insert one partner", context do
      assert {:ok,
              %Partner{
                address: address,
                trading_name: trading_name,
                owner_name: owner_name,
                document: document,
                coverage_area: coverage_area
              }} = Partner.Api.insert(context.sucess_params)

      assert ^address = context.sucess_params.address
      assert ^trading_name = context.sucess_params.trading_name
      assert ^owner_name = context.sucess_params.owner_name
      assert ^document = context.sucess_params.document
      assert ^coverage_area = coverage_area
    end

    test "get all partner after insert", context do
      for _i <- 1..10 do
        assert {:ok, _} = Partner.Api.insert(context.sucess_params)
      end

      assert {:ok, items} = Partner.Api.all()
      assert 10 = Enum.count(items)
    end

    test "delete a partner", context do
      {:ok, partner} = Partner.Api.insert(context.sucess_params)
      assert {:ok, _} = Partner.Api.delete(partner.id)
      assert {:error, _} = Partner.Api.get(partner.id)
    end

    test "update a partner", context do
      {:ok, partner} = Partner.Api.insert(context.sucess_params)

      updated_params = %{
        context.sucess_params
        | trading_name: "Adega SBC",
          owner_name: "Samyr da Ambev"
      }

      {:ok, updated_partner} = Partner.Api.update(partner, updated_params)

      assert updated_partner.trading_name == updated_params.trading_name
      assert updated_partner.owner_name == updated_params.owner_name
    end

    test "get a partner by id", context do
      {:ok, partner} = Partner.Api.insert(context.sucess_params)
      {:ok, _} = Partner.Api.get(partner.id)
    end
  end
end
