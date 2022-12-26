# 1.Question: Which destination in the flights database is the furthest distance away, based on information in the flights table?
# Show the SQL query(s) that support your conclusion. 
# 1.Answer: HNL, Honolulu Intl
select distinct dest, distance from flights order by distance desc

# 2.Question: What are the different numbers of engines in the planes table? For each number of engines, which aircraft have the most number of seats?
# Show the SQL statement(s) that support your result.
# 2.Answer: Planes have 1, 2, 3, or 4 engines. The 4-engine model with the most seats is 747-451. The 3-engine model with the most seats is A330-223.
# There are a number of 2-engine models with the same # of seats, all starting with "777-". The 1-engine model with the most seats is OTTER DHC3.
select distinct model, engines, seats, row_number() over (partition by engines order by engines desc, seats desc) as "rank" from planes order by engines desc, seats desc

# 3.Question: Show the total number of flights.
# 3.Answer: 857 total flights.
select count(*) as "total_flights" from flights

# 4.Question: Show the total number of flights by airline (carrier).
# 4.Answer: '9E', '28'; 'AA', '96'; 'AS', '2'; 'B6', '170'; 'DL', '114'; 'EV', '117'; 'F9', '2'; 'FL', '10'; 'HA', '1'; 'MQ', '78'
# 'UA', '167'; 'US', '33'; 'VX', '12'; 'WN', '27'
select carrier, count(*) as "carrier_flights" from flights group by carrier order by carrier

# 5.Question: Show all of the airlines, ordered by number of flights in descending order.
# 5.Answer: 'B6', '170'; 'UA', '167'; 'EV', '117'; 'DL', '114'; 'AA', '96'; 'MQ', '78'
# 'US', '33'; '9E', '28'; 'WN', '27'; 'VX', '12'; 'FL', '10'; 'AS', '2'; 'F9', '2'; 'HA', '1'
select carrier, count(*) as "carrier_flights" from flights group by carrier order by carrier_flights desc

# 6.Question: Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
# 6.Answer: 'B6', '170'; 'UA', '167'; 'EV', '117'; 'DL', '114'; 'AA', '96'
select carrier, count(*) as "carrier_flights" from flights group by carrier order by carrier_flights desc limit 5

# 7.Question: Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.
# 7.Answer: 'UA', '122'; 'B6', '104'; 'AA', '70'; 'DL', '67'; 'VX', '12'
select carrier, count(*) as "long_distance_flights" from flights where distance >= 1000 group by carrier order by long_distance_flights desc limit 5

# 8.Question: Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question,
# and the query that answers the question.
# 8.Answer: What was the average dep_delay for each airline carrier, and which airline had the worst average dep_delay?
select carrier, avg(dep_delay) as "avg_dep_delay" from flights group by carrier order by avg_dep_delay desc