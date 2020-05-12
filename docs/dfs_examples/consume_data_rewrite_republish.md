## Data cleaning and publishing

Consume data from an MQTT-Broker and do some cleaning, at the end republish this data.
```dfs
    def topic_in = 'ttgw/grip/rovolutionwels/reasoning/schedulers_ol_log'
    def topic_out = 'ttgw/data/grip/rovolutionwels/reasoning/schedulers_ol_log'
    def host = '10.14.204.3'
    
    |mqtt_subscribe()
    .host(host) 
    .topic(topic_in)
    .dt_field('UTC-Time')
    .dt_format('float_micro')
     
    %% here is were we clean data
    
    |eval(
        lambda: int("sku_length" * 1000),
        lambda: int("sku_width" * 1000),
        lambda: int("source_lc_quantity"),
        lambda: int("pcs_lost")
    )
    %% overwrite the original fields 
    .as(
        'sku_length',
        'sku_width',
        'source_lc_quantity',
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
