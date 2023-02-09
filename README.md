## View the documentation [here](https://heyoka.github.io/faxe-docs/site).

Documentation for FAXE
======================

To view the documentation in rendered HTML, download the `site` folder and open `index.html` in your browser.

### Prerequisites

#### python
* install mkdocs
* install mkdocs-material
* mkdocs-macros-plugin
* install pygments
#### npm
* redoc-cli

Build
-----

### mkdocs

for live view
    
    mkdocs serve
    
render html

    mkdocs build
    
#### dfs syntax highlighting

install custom syntax highlighting for dfs scripts into pygments
    
    cd Dfslexer && sudo python3 setup.py develop

### rest api documentation

build

    make 

