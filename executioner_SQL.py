import MySQLdb
import time

db = MySQLdb.connect("localhost", "root", "morphling", "summer_project_4")
cursor = db.cursor()
querry_array = [sql_1, sql_2, sql_3, sql_4, sql_5, sql_6, sql_7, sql_8, sql_9, sql_10]

def execute(y):
	with open("output_MySQL.txt", 'a') as output:
		total_time = 0
		for x in range(0, 10):
			try:
				current_time = time.time()
				cursor.execute(querry_array[y])
				results = cursor.fetchall()
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
		output.close()

for y in range(0,10):
	execute(y)

