Documentation for FAXE
======================

To view the documentation in rendered HTML, download the `site` folder and open `index.html` in your browser.

### Prerequisites

* install mkdocs
* install pygments


Build
-----

### mkdocs

for live view
    
    mkdocs serve
    
render html

    mkdocs build
    
#### dfs syntax highlighting

install custom syntax highlighting for dfs scripts into pygments
    
    cd DfsLexer && sudo python3 setup.py develop

### rest api documentation

build

    redoc-cli bundle rest-api/swagger_faxe.yaml
    
after that, rename the resulting html file to "faxe_rest_api.html" and copy it to ./site

