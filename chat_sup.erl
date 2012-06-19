-module (chat_sup).

-behaviour (supervisor).

-export ([init/1, start_link/0]).

start_link() ->
    supervisor:start_link({global, ?MODULE}, ?MODULE, []).

init(_) ->
    {ok, 
        {
            {simple_one_for_one, 10, 1},
            [{
                chat,
                {chat, start_link, [undefined]},
                permanent,
                5000,
                worker,
                [chat]
            }]
        }
    }.
        