CREATE TABLE area(id int UNIQUE, name char(20), PRIMARY KEY(name) );
CREATE TABLE cuisine(id int UNIQUE, name char(20), scope char(20), area_name char(20), PRIMARY KEY(name), FOREIGN KEY(area_name) REFERENCES area(name) );
CREATE TABLE ingredient_category(id int UNIQUE, name char(20), PRIMARY KEY(name) );
CREATE TABLE ingredient(id int UNIQUE, name char(20), category char(20), PRIMARY KEY(name), FOREIGN KEY(category) REFERENCES ingredient_category(name) );
CREATE TABLE recipe(id int, source char(20), cuisine char(20), PRIMARY KEY(id), FOREIGN KEY(cuisine) REFERENCES cuisine(name) );
CREATE TABLE ingred_recipe(ing char(20), id_rec int, PRIMARY KEY (ing, id_rec), FOREIGN KEY (ing) REFERENCES ingredient(name), FOREIGN KEY (id_rec) REFERENCES recipe(id) );
CREATE TABLE similarity(cuisine_1 char(20), cuisine_2 char(20), value float, PRIMARY KEY (cuisine_1, cuisine_2), FOREIGN KEY (cuisine_1) REFERENCES cuisine(name), FOREIGN KEY (cuisine_2) REFERENCES cuisine(name) );

SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/AREA.csv'INTO TABLE area FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/CUISINE.csv'INTO TABLE cuisine FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/.../INGREDIENT.csv'INTO TABLE ingredient FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
// ingredient category
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/INGREDIENT_CATEGORY.csv'INTO TABLE ingredient_category FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/RECIPES.csv'INTO TABLE recipe FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/ingred_partof_recipe.csv'INTO TABLE ingred_recipe FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;
SET foreign_key_checks = 0; LOAD DATA LOCAL INFILE 'c:/Users/Matjaz Moser/Dropbox/SABANCI/summer project/mySQL/data/cuisines_similarities.csv'INTO TABLE similarity FIELDS TERMINATED BY ','LINES TERMINATED BY '\n'IGNORE 1 ROWS; SET foreign_key_checks = 1;


