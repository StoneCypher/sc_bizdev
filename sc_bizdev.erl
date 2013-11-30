
-module(sc_bizdev).





-export([

    break_even/2,
    break_even_time/4

]).





%%%%%%%%%
%%
%%  @doc Calculates the number of sold units required to break even.

break_even(Cost, UnitProfit) ->

    Cost / UnitProfit.





%%%%%%%%%
%%
%%  @doc Calculates the time unit count until an investment will break even.  If this number comes back negative, your investment
%%  is losing money, and will never break even.

break_even_time(Invest, CostPerTime, UnitProfitPerTime, UnitsSold) ->

    Invest / ((UnitProfitPerTime * UnitsSold) - CostPerTime).