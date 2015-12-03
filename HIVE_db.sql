CREATE DATABASE recipes_hive_2;
USE recipes_hive_2;

CREATE TABLE IF NOT EXISTS recipes_hive_2.cuisine (ID INT COMMENT 'Cuisine ID.', name STRING COMMENT 'Cusine name - primary key.', scope STRING COMMENT 'Either country or area.', area STRING COMMENT 'Name of the area of origin - foreign key.') COMMENT 'Table containing cuisines data.'ROW FORMAT DELIMITED FIELDS TERMINATED BY ','STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.area (ID INT COMMENT 'ID of the area - primary key.', name STRING COMMENT 'name of the area') COMMENT 'Table containing areas data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.ingredient (ID INT COMMENT 'ID of the ingredient.', name STRING COMMENT 'Name of the ingredient- primary key.', category STRING COMMENT 'Name of the category - foreign key.') COMMENT 'Table containing cuisines data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.ingredient_category (ID INT COMMENT 'ID of the category', name STRING COMMENT 'Name of the category - primary key.') COMMENT 'Table containing cuisines data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.recipe (ID INT COMMENT 'ID of the recipe - primary key.', source STRING COMMENT 'Source o the data (not used anywhere).', cuisine STRING COMMENT 'Name of cuisine of origin - foreign key.') COMMENT 'Table containing cuisines data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.similarity (cuisine_1 STRING COMMENT 'Name of cuisine one - foreign key and primary key.', cuisine_2 STRING COMMENT 'Name of cuisine two - foreign key and primary key.', value FLOAT COMMENT 'The calculated value') COMMENT 'Table containing cuisines data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
CREATE TABLE IF NOT EXISTS recipes_hive_2.part_of (INGREDIENT STRING COMMENT 'Ingredient name - foreign key and primary key.', ID_RECIPE INT COMMENT 'Recipe ID - foreign key and primary key.') COMMENT 'Table containing cuisines data.' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/cuisine.csv'OVERWRITE INTO TABLE recipes_hive_2.cuisine; 
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/area.csv' OVERWRITE INTO TABLE recipes_hive_2.area;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/ingredient.csv' OVERWRITE INTO TABLE recipes_hive_2.ingredient;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/ingredient_category.csv' OVERWRITE INTO TABLE recipes_hive_2.ingredient_category;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/similarity.csv' OVERWRITE INTO TABLE recipes_hive_2.similarity;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/ingredient_recipe.csv' OVERWRITE INTO TABLE recipes_hive_2.part_of;
LOAD DATA LOCAL INPATH '/home/trainer/Documents/data_recipes/data/SQL/recipe.csv'OVERWRITE INTO TABLE recipes_hive_2.recipe;