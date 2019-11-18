Documentation for FAXE
======================

To view the documentation in rendered HTML, download the `site` folder and open `index.html` in your browser.


Build
-----

### mkdocs

for live view
    
    mkdocs serve
    
render html

    mkdocs build
    

### rest api documentation

build

    redoc-cli bundle rest-api/swagger_faxe.yaml
    
after that, rename the resulting html file to "faxe_rest_api.html" and copy it to ./site

