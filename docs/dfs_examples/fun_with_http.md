## fun with http

Using faxe's http nodes.
Http GET and POST from and to itself.


```dfs  
def path2 = '/faxe_stats'

%% first set up a listen node to receive data via http
|http_listen()
.path(path2)
.port(8899)
.payload_type('json')
.as('recv')

|debug()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def path = '/v1/stats/faxe'
def host = '127.0.0.1'
def port = 8081

%% call faxe's own rest api, and get some stats fields
|http_get()
.host(host)
.port(port)
.path(path)
.every(3s)

%% post this data to the http_listen node setup at the beginning of the script
|http_post()
.host(host)
.port(8899)
.path(path2)





```