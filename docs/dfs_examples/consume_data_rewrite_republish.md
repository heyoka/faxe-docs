## Data cleaning and publishing

Consume data from an MQTT-Broker and do some cleaning, at the end republish this data.


```dfs

    def topic_in = 'my/topic/in'
    def topic_out = 'my/topic/out'
    def host = '192.168.1.2'
    
    |mqtt_subscribe()
    .host(host) 
    .topic(topic_in)
    .dt_field('UTC-Time')
    .dt_format('float_micro')
     
    %% here is were we clean data
    
    |eval(
        lambda: int("u_length" * 1000),
        lambda: int("u_width" * 1000),
        lambda: int("lc_quantity"),
        lambda: int("pcs_lost")
    )
    %% overwrite the original fields 
    .as(
        'u_length',
        'u_width',
        'lc_quantity',
        'pcs_lost'
        )

    |delete('UTC-Time')

    % publish the resulting message 

    |mqtt_publish()
        .host(host) 
        .qos(1)
        .topic(topic_out)
        .retained()
```

`Note:`
If topic_in = topic_out we create a loop using the mqtt broker, something we do not want normally.
