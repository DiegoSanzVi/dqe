-module(dqe_max_trans).
-behaviour(dqe_fun).

-include_lib("mmath/include/mmath.hrl").

-export([spec/0, describe/1, init/1, chunk/1, resolution/2, run/2, help/0]).

-record(state, {
          const :: number()
         }).

init([Const]) when is_float(Const) ->
    #state{const = Const}.

chunk(#state{const = Const}) ->
    Const * ?RDATA_SIZE.

resolution(_Resolution, State) ->
    {1, State}.

describe(#state{const = Const}) when is_float(Const)->
    ["max(", float_to_list(Const), ")"].

spec() ->
    [{<<"max">>, [metric, float], none, metric}].

run([Data], S = #state{const = Const}) ->
    {mmath_trans:max(Data, Const), S}.

help() ->
    <<"Returns the maximun of each value or a given constant.">>.
