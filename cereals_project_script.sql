drop database if exists cereals;
create database cereals;
use cereals;
show tables;

select * from cereals_data;
describe cereals_data;

#1. Add index name fast on name
alter table cereals_data modify name varchar(100);
CREATE INDEX fast ON cereals_data(name);

#2. Describe the schema of table
describe cereals_data;


#3. Create view name as see where users can not see type column [first run appropriate query
-- then create view] 

create view see as(
select name, mfr, calories, protein, fat, sodium, fiber, carbo, sugars, potass, 
       vitamins, shelf, weight, cups, rating 
from cereals_data);

select * from see;

#4. Rename the view as saw 
rename table see to saw;

#5. Count how many are cold cereals 
select count(type) as cold_cereals from cereals_data where type ='C';

#6. Count how many cereals are kept in shelf 3

select count(*) as helf_3_cereal_count from cereals_data where shelf =3;

#7. Arrange the table from high to low according to ratings
select * from cereals_data order by rating desc;

#8. Suggest some column/s which can be Primary key 

alter table cereals_data  add primary key(name);

#9. Find average of calories of hot cereal and cold cereal in one query

select type,avg(calories) as avg_cal from cereals_data group by type;

#10. Add new column as HL_Calories where more than average calories should be categorized as
-- HIGH and less than average calories should be categorized as LOW

-- add new column  name HL_Calories 
alter table cereals_data add column HL_Calories varchar(20);
alter table cereals_data drop HL_Calories;

update cereals_data join (select avg(calories) as avg_cal from cereals_data) as avg_table
set HL_Calories = case when calories >avg_table.avg_cal then 'High' 
when calories < avg_table.avg_cal then 'Low' End;

select * from cereals_data;

#11. List only those cereals whose name begins with B 
select * from cereals_data where name like 'B%' ;

#12. List only those cereals whose name begins with F 
select * from cereals_data where name like 'F%';

#13. List only those cereals whose name ends with s

select * from cereals_data where name like '%S';

#14. Select only those records which are HIGH in column HL_calories and mail to
#jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>] 
  select * from cereals_data where HL_calories = "High";
  
#15. Find maximum of ratings
select max(rating) as max_rating from cereals_data ;

#16. Find average ratings of those were High and Low calories 

select HL_Calories, avg(rating) as avg_raitings from cereals_data group by HL_Calories;


#17. Craete two examples of Sub Queries of your choice and give explanation in the script
#itself with remarks by using 

#Find cereals whose calories are above the average calories of all cereals
# Subquery-- calculates the average calorie .
# Main query -- Returns  calorie value is greater than this average.
select * from cereals_data where calories >(
select avg(calories) from cereals_data);		




select * from cereals_data;
#18. Remove column fat 

alter table cereals_data drop fat;

#19. Count records for each manufacturer [mfr] 
select count(mfr) as count_of_mfr from cereals_data;

#20. Select name, calories and ratings only 
 select name,calories,rating from cereals_data;
 
 
  select * from cereals_data;




