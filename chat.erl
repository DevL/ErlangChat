-module (chat).

-behaviour(gen_server).

-record(state,{}).

-export([start_link/1,
          init/1,
          terminate/2,
          handle_call/3,
          handle_cast/2,
          handle_info/2,
          code_change/3,
          stop/1,
          chat_msg/1]).

start_link(_) ->
    io:format("start_link()",[]),
    gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).

init(_) ->
    io:format("starting up...",[]),
    {ok, #state{}}.
    
handle_call(stop = Request, _From, State) ->
    {stop, normal, State};
handle_call(Request, _From, State) ->
    {reply, Request, State}.    
    
handle_cast({chat_msg, String}, State) ->
    io:format("~p~n",[String]),
    {noreply, ok, State}.
    
handle_info(Request, State) ->
    io:format("~p: got ~p~n",[self(), Request]),
    {noreply, State}.
    
stop(_Reason) ->
    gen_server:call({global, ?MODULE}, stop).
    
terminate(_,_) ->
    ok.
    
code_change(OldVsn, State, Extra) ->
    {ok, State}.
    
chat_msg(String) ->
    gen_server:cast({global, ?MODULE}, String).