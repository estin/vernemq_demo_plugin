-module(vernemq_demo_plugin_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).
-define(ENV_API_KEYS, http_mgmt_api_keys).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->

    %% set api key from env variable
    ApiKey = os:getenv("API_KEY"),
    if
        ApiKey =:= false -> error_logger:info_msg("api key not defined");
        true ->
            NewKey = list_to_binary(ApiKey),
            Keys = vmq_config:get_env(vmq_server, ?ENV_API_KEYS, []),
            error_logger:info_msg("api keys before: ~p", [Keys]),
            Keys1 = lists:delete(NewKey, Keys),
            vmq_config:set_global_env(vmq_server, ?ENV_API_KEYS, [NewKey|Keys1], true),
            error_logger:info_msg("api keys after: ~p", [vmq_config:get_env(vmq_server, ?ENV_API_KEYS, [])])
    end,

    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

