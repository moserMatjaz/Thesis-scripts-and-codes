from py2neo import authenticate, Graph
import time

graph = Graph()
authenticate("localhost:7474", "neo4j", "morphling")

cql_1 = ("MATCH (i:INGREDIENT)-[n:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(c:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) WHERE a.name = 'African' RETURN a.name as AREA_NAME,i.name, count(n) AS OCCURANCES ORDER BY OCCURANCES DESC LIMIT 1")
cql_2 = ("MATCH (i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(c:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) RETURN a.name AS AREA_NAME, count(distinct(i.ID)) AS INGREDIENTS, count(distinct(r.ID)) AS RECIPES, count(distinct(c.ID)) AS CUISINES ORDER BY AREA_NAME")
cql_3 = ("MATCH (c1:CUISINE) - [n:SIMILIARITY] - (c2:CUISINE) WHERE c1.name = 'Israel' AND c2.scope = 'Country' RETURN c2.name, n.value ORDER BY n.value DESC LIMIT 5")
cql_4 = ("MATCH (c1:CUISINE)<-[:IS_FROM]-(r1:RECIPE)<-[:IS_PART_OF]-(i:INGREDIENT)-[:IS_PART_OF]->(r2:RECIPE)-[:IS_FROM]->(c2:CUISINE) WHERE c1.name = 'Bangladesh' AND c2.name = 'Pakistan'RETURN c1.name AS C1, c2.name AS C2, count(distinct(i.name)) AS MUTUAL")
cql_5 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) RETURN count(distinct(c.ID)),count(distinct(i.ID)),count(distinct(r.ID)),count(distinct(k.ID)),count(distinct(a.ID))")
cql_6 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) RETURN COUNT(DISTINCT(c.ID)), a.name ORDER BY a.name")
cql_7 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) WITH c, i, r, k, a MATCH (recipe)-[:IS_FROM]->(cuisine)-[:ORIGINATES_FROM]->(area) WHERE c.name = 'alcoholic beverage' AND a.name = 'SouthAsian' AND area.name = 'SouthAsian' RETURN toFloat(COUNT(DISTINCT(r.ID)))*100/toFloat(COUNT(DISTINCT(recipe.ID))) AS BANANA, a.name")
cql_8 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE) WITH c, i, r, k MATCH (recipe)-[:IS_FROM]->(cuisine) WHERE c.name = 'fruit' AND k.name = cuisine.name RETURN toFloat(COUNT(DISTINCT(r.ID)))*100/toFloat(COUNT(DISTINCT(recipe.ID))) AS BANANA, k.name ORDER BY BANANA DESC")
cql_9 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) RETURN SUM(c.ID) + SUM(i.ID) + SUM(r.ID) + SUM(k.ID) + SUM(a.ID) AS SUMA")
cql_10 = ("MATCH (c:INGREDIENT_CATEGORY)<-[:BELONGS_TO]-(i:INGREDIENT)-[:IS_PART_OF]->(r:RECIPE)-[:IS_FROM]->(k:CUISINE)-[:ORIGINATES_FROM]->(a:AREA) WHERE c.name = 'alcoholic beverage' RETURN count(DISTINCT(r.ID)) AS BANANA, a.name ORDER BY a.name")

querry_array = [cql_1, cql_2, cql_3, cql_4, cql_5, cql_6, cql_7, cql_9, cql_10]

def execute(y):
	with open("output_Neo4j.txt", 'a') as output:
		total_time = 0
		for x in range(0, 10):
			try:
				current_time = time.time()
				graph.cypher.execute(querry_array[y])
				current_time = float("%s" % (time.time() - current_time))
				print(x,y)
				output.write(str(current_time) + "\n")
				total_time += current_time
			except:
				output.write("DNF")
				total_time = 0
		if (total_time > 0):
			average_time = total_time/10
		else:
			average_time = 0
		output.write("\n" + "Total time: " + str(total_time) + "\n" + "Average time: " + str(average_time) + "\n" + "************************************" + "\n")
		output.close()

for y in range(0,9):
	execute(y)

