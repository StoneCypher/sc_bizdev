
-module(sc_bizdev).





-export([

    break_even/2,
      break_even_time/4,

    funnel/2,

    unfunnel/2,
      unfunnel/3

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





%% @doc <span style="color:red;font-style:italic">Untested</span> <span style="color:orange;font-style:italic">Stoch untested</span> Reverse a marketing funnel, to go from goal needed to input needed.  ```1> % Using the data from http://www.forentrepreneurs.com/lessons-from-leaders/jboss-example/
%% 1> sc_bizdev:unfunnel(300, [{1/4,"Web activity scoring"}, {1/3,"Telemarketing"}, {1/4,"Inside Sales"}]).
%% [ { 14400, "Input Needed" },
%%   { 3600,  "Web activity scoring", 0.25 },
%%   { 1200,  "Telemarketing",        0.3333333333333333 },
%%   { 300,   "Inside Sales",         0.25 },
%%   { 300,   "Result" } ]'''

unfunnel(Tgt, ProbPropList) ->

    unfunnel(Tgt, ProbPropList, ceil).





unfunnel(Tgt, ProbPropList, MaybeCeil)

    when is_number(Tgt),
         is_list(ProbPropList) ->

    unfunnel(Tgt, [ { Tgt, "Result" } ], lists:reverse(ProbPropList), MaybeCeil).





unfunnel(Counter, Output, [], _WhoCaresIfCeil) ->

    [{Counter, "Input Needed"}]++Output;





unfunnel(Counter, Output, [{Scale,Label} | RemWork], no_ceil) ->

    unfunnel(Counter/Scale, [{Counter, Label, Scale}]++Output, RemWork, no_ceil);





unfunnel(Counter, Output, [{Scale,Label} | RemWork], ceil) ->

    unfunnel(sc:ceil(Counter/Scale), [{Counter, Label, Scale}]++Output, RemWork, ceil).





funnel(Base, Percents) ->

    funnel([Base], Base, Percents).





funnel(Work, _Last, []) ->

    lists:reverse( Work );





funnel(Work, Last, [NextPct | Pcts]) ->

    Step = Last * NextPct,

    funnel([Step]++Work, Step, Pcts).
