# eq-analysis
code dump for a rudimentary earthquake analysis webapp
Thew gend goal is to create a web application, allowing users to drilldown on a location and view the history of earthquake activity
there. A subsequent goal is to provide a probability of earthquake occurrence based on eq activity and other, possibly relevant, factors.

This project is chiefly about the cause and effect of the "other" factors...

The current database in being used is an Oracle 12c standalone db (no license required if developing only).
Future plans are to include methods (using hibernate) to build or rebuild the db in either oracle, postgres, mssql or mysql/maria flavors.

#Acknowledgements

@mthorry (for my shameless borrowing of his [eqmapping app](https://github.com/mthorry/earthquakes-mapper) built using react and the googlemaps api)
