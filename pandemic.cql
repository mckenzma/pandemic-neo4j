//Pandemic Game in Neo4j
// Create Cities
LOAD CSV WITH HEADERS FROM "https://docs.google.com/spreadsheets/u/0/d/1Z8R-lJ-cNGYeWDvMfjqhaj-a9wTVJwRIXCT8DacQvsc/export?format=csv&id=1Z8R-lJ-cNGYeWDvMfjqhaj-a9wTVJwRIXCT8DacQvsc&gid=0" AS row
FIELDTERMINATOR ','
MERGE (city:City {name: row.City})
ON CREATE SET 
	city.name = row.City,
	city.color = row.Color//,
	//city.population = toInteger(row.Population),
	//city.location = point({ longitude: row.Longitude, latitude: row.Latitude})

//Connect Cities
LOAD CSV WITH HEADERS FROM "https://docs.google.com/spreadsheets/u/0/d/1jYpTcFmhCTxoiGssPQpqvQ0gyChc1qfHuYv-eepKDPc/export?format=csv&id=1jYpTcFmhCTxoiGssPQpqvQ0gyChc1qfHuYv-eepKDPc&gid=0" AS row
FIELDTERMINATOR ','
MATCH (cStart:City {name: row.CityStart})
MATCH (cEnd:City {name: row.CityEnd})
MERGE (cStart)-[:CONNECTS_TO]->(cEnd)

//Remove "duplicate connections"
MATCH (city1:City)-[r1:CONNECTS_TO]->(city2:City)-[r2:CONNECTS_TO]->(city1)
WHERE id(r1)>id(r2)
DELETE r1
