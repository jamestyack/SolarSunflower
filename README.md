Solar Sunflower: A #TechCamp and Code for Philly Project
========================================================

Installation
-----------

The Solar Sunflower is an educational tool used for wireless monitoring of green stormwater infrastructure. Environmental data is collected by analog sensors (soil moisture, temperature, light) embedded in the green stormwater infrastructure system (e.g., a rain garden). Data is sent to the Web and can be mined by students or citizens and analyzed via an online interface. The data provides important information about system performance, plant health and maintenance needs.

To initialize:
`rake db:create`
`rake db:migrate`
`rake db:seed`

You might also want to POST some data points using the`curl` request below.

login with user@example.com/changeme

Useage
------

To POST soil moisture data to the database:

curl -v -H "Content-Type: application/json" -X POST -d '{"type":"soilmoisture", "data":{"collection_point_id":123,"collection_time":"2013-03-08 08:58AM","deptha":1,"depthb":1.2,"depthc":1.9}}' 'http://localhost:3000/dc/'


Each soil moisture data bundle belongs to a `collection point`, which belongs to a `site`. You can navigate through this heirarchy from the the home page.

Each `site` has a page that displayes `collection points` and `soilmoisture` data bundles. Add `.json` to the `site` URL get request to return a JSON object representation of that site's data, i.e. `http://localhost:3000/sites/1.json`

This can be used to generate graphs and visualizations.
