USE house_price_regression;

#4 Select all the data from table house_price_data to check if the data was imported correctly
SELECT * FROM house_price_regression.house_price_data;

#5 Use the alter table command to drop the column date from the database and show first 10 rows 
#to verify if command worked
ALTER TABLE house_price_data DROP COLUMN date;
SELECT * FROM house_price_data LIMIT 10;

#6 Use sql query to find how many rows of data you have.
SELECT COUNT(*) from house_price_data;

#7a What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms FROM  house_price_data;

#7b What are the unique values in the column bathrooms?
SELECT DISTINCT bedrooms FROM  house_price_data;

#7c What are the unique values in the column floors?
SELECT DISTINCT floors FROM  house_price_data;

#7d What are the unique values in the column condition?
SELECT DISTINCT(house_price_data.condition) FROM  house_price_data;

#7e What are the unique values in the column grade?
SELECT distinct grade FROM house_price_data;

#8 Arrange the data in a decreasing order by the price of the house to show the 
#top 10 most expensive houses in your data.
Select price from house_price_data
order by price desc
limit 10;

#9 What is the average price of all the properties in your data?
Select round(sum(price)/count(*),-2) as average_price from house_price_data;

#10a What is the average price of the houses grouped by bedrooms?
Select bedrooms, round(sum(price)/count(*),-2) as average_price from house_price_data
group by bedrooms
order by bedrooms asc;

#10b What is the average sqft_living of the houses grouped by bedrooms ('gla': gross living area)? 
Select bedrooms, round(sum(sqft_living)/count(*),-2) as average_gla from house_price_data
group by bedrooms
order by bedrooms asc;

#10c What is the average price of the houses with a waterfront and without a waterfront? 
SELECT waterfront, round(sum(price)/count(*),-2) from house_price_data
group by waterfront;

#10d Is there any correlation between the columns condition and grade? 
Select grade, house_price_data.condition, count(*) from house_price_data
group by grade, house_price_data.condition
order by grade, house_price_data.condition asc;
# answer: by eye, there does not seem to be a correlation between grade and condition but rather that 
# condition 3 is most common in all grade values

#11 Find all houses with the following: 3-4 bedrooms, more than 3 bathrooms, 1 foor, no waterfront, condition > 2,
# Grade > 4, price less than 300000
SELECT bedrooms, bathrooms, floors, waterfront, house_price_data.condition, grade, price from house_price_data
where (bedrooms =3 or bedrooms = 4) and (bathrooms > 3) and (floors =1.0) and (waterfront = 0) and (house_price_data.condition > 2)
and (grade > 4) and (price <300000);
# there are no fitting results that fit all of the prospective homeowner's requests. There are 3 homes with 5-6 beds (not 3-4)

#12 Show which prices are twice more than the average of all the properties in the database.

select price, id from house_price_data 
where price > 2*( select avg(price) from house_price_data)
order by price;

#13 Create a view of the query in #12  

create or replace view twice_average as
select price, id from house_price_data 
where price > 2*( select avg(price) from house_price_data)
order by price;
select * from twice_average;

#14 Most customers are interested in properties with three or four bedrooms. 
#What is the difference in average prices of the properties with three and four bedrooms?
select( (select avg(price) from house_price_data where bedrooms = 4) -
( select avg(price) from house_price_data where bedrooms = 3))fourthreediff;

#15 Show all zipcodes for properties in the database
SELECT DISTINCT zipcode from house_price_data;

#16 Show the list of all the properties that were renovated.
SELECT * from house_price_data
where yr_renovated != 0;

#17 Provide the details of the 11th most expensive property in your database.
select id, price, rank() over (order by price desc) as price_rank from house_price_data
where rank() over (order by price desc) between 10 and 12;

Select * from 
(
select id, price, rank() over (order by price desc) as price_rank from house_price_data
)allrank
where price_rank = 11;