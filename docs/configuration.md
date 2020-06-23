# Configuration


TBD


FAXE supports a sysctl like configuration syntax.
Here are the simple rules of the syntax:

+ Everything you need to know about a single setting is on one line
+ Lines are structured Key = Value
+ Any line starting with # is a comment, and will be ignored.

```erlang

[
   {faxe, [
      {dfs, [
         {script_path, "/home/ubuntu/faxe/dfs/"}
      ]},
      {http_api_port, 8081},
      {python, [
         {version, "3"}, %% python version to use / string !
         {script_path, "/home/ubuntu/faxe/python/"}
      ]},
      {esq_base_dir, <<"/tmp/">>},
      {metrics, [
         %% {msg_queue_len_high_watermark, 15}
         %% install metrics handlers
         {handler, [
            {mqtt, [
               {host, <<"10.14.204.3">>},
               {port, 1883}
            ]
            }]}
      ]},
      {conn_status, [
         %% install conn_status handlers
         {handler, [
            {mqtt, [
               {host, <<"10.14.204.3">>},
               {port, 2883},
               {user, <<"admin">>},
               {pass, <<"admin">>}
            ]
            }]}
      ]},
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %% default configs
      {s7pool_initial_size, 2},
      {s7pool_max_size, 16},
      {email, [
         {from_address, <<"noreply@tgw-group.com">>},
         {smtp_relay, <<"smtp.tgw.local">>},
         {smtp_user, undefined},
         {smtp_pass, undefined},
         {template, <<"/home/ubuntu/faxe/templates/email_template.html">>}
      ]},
      {mqtt, [
         {host, <<"10.14.204.3">>},
         {port, 1883}
      ]},
      {amqp, [
         {host, <<"10.14.204.3">>},
         {port, 5672}
      ]},
      {rabbitmq, [
         {root_exchange, <<"x_lm_fanout">>}
      ]},
      {crate, [
         {host, <<"10.14.204.8">>},
         {port, 5433},
         {user, <<"crate">>},
         {database, <<"doc">>}
      ]},
      {crate_http, [
         {host, <<"10.14.204.8">>},
         {port, 4201}
      ]}
      %%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ]},

   {vmstats,
      [
         {sink, faxe_vmstats},
         {interval, 3000},
         {sched_time, false}
      ]
   },
   {lager, [
      {colored, true},
      {error_logger_redirect, true},
      {handlers, [
         {lager_console_backend, [{level, warning},
            {formatter, lager_default_formatter},
            {formatter_config,
               [time, color, " [",severity,"] ",
                  {flow, ["(", flow, ") "], [""]},
                  {comp, ["(", comp, ") "], [""]},
                  message,
                  "\e[0m\r\n"] % clear color and newline
            }
         ]}
         ,
         { lager_flowlog_backend, [
            {level, notice},
            {host, <<"http://10.14.204.8">>},
            {port, 4201},
            {fields,
               [<<"ts">>, <<"severity">>, <<"flow">>, <<"comp">>, <<"message">>, <<"meta">>]
            },
            {storage_backend, crate_log_writer}
            ]
         }
         ,
         {lager_file_backend, [{file, "log/error.log"}, {level, error}]}
%%         ,
%%         {lager_file_backend, [{file, "error.log"}, {level, error}]},
%%         {lager_file_backend, [{file, "console.log"}, {level, info}]}
      ]}
   ]},
   {kernel,
      [
         {shell_history, enabled},
         {shell_history_path, ".rebar3"}
      ]

   }
].


```
 