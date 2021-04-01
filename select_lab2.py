import psycopg2
import csv
import configparser

RESULTS_FILENAME = 'Results.csv'
RESULT_HEADER = ['Year', 'Mark']

config = configparser.ConfigParser()
config.read('settings.ini')
conn_config = config['connection']
conn = psycopg2.connect(dbname=conn_config['dbname'],
						user=conn_config['user'],
						password=conn_config['password'],
						host=conn_config['host'])
if conn != None:
	print(f'Connected to {conn_config["dbname"]}\n')

with conn:
	with conn.cursor() as cur:

		execute_line = '''SELECT MAX(Ball100), Year
						  FROM Results
						  WHERE TestStatus IN ('Зараховано', 'Отримав результат')
						  AND Year IN (2019, 2020)
						  GROUP BY Year
						  ORDER BY Year;'''
		cur.execute(execute_line)
		data = cur.fetchall()

		with open(RESULTS_FILENAME, 'w', newline='') as file:
			writer = csv.writer(file, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
			writer.writerow(RESULT_HEADER)
			for row in data:
				writer.writerow(row)
		print(f"\nCreated file {RESULTS_FILENAME}")
