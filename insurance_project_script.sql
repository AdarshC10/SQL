drop database if exists insurance;
create database insurance;
use insurance;

select * from insurance;

# 1. Count for each categories of ‘region

select region,count(region) as count_of_region from insurance group by region;

# 2. Find 50 records of highest ‘age’ and export data/table to desktop
select * from insurance order by age desc limit 50;

# 3. Add index name ‘quick’ on ‘id’
create index quick on insurance(id);

# 4. Describe the schema of table
select * from insurance;
# 5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run
# appropriate query then create view]
select age ,bmi,children ,smoker ,region, charges from insurance;

create view gender as 
select age ,bmi,children ,smoker ,region, charges from insurance ;

select * from gender;

# 6. Rename the view as ‘type’

rename table gender to type; 
select * from type;
# 7. Count how many are ‘northwest’ insurance holders
select * from insurance;
select count(region) as insurence_holders from insurance where region = 'northwest' ;

# 8. Count how many insurance holders were ‘femail’
select sex,count(*) from insurance where sex= 'female' ;

# 9. Create Primary key on a suitable column
select * from insurance;
alter table insurance add primary key(id);

describe insurance;

# 10. Create a new column ‘ratio’ which is age multiply by bmi
alter table insurance add column ratio float;

update insurance set ratio = age * bmi;
select * from insurance;

# 11. Arrange the table from high to low according to charges
select * from insurance order by charges desc;

# 12. Find MAX of ‘charges’
select max(charges) from insurance;

# 13. Find MIN of ‘charges’
select min(charges) from insurance;

# 14. Find average of ‘charges’ of male and female
select sex,avg(charges) as avg_charge from insurance group by sex;

# 15. Write a Query to rename column name sex to Gender
alter table insurance rename column sex to gender;


# 16. Add new column as HL_Charges where more than average charges should be
# categorized as HIGH and less than average charges should be categorized as LOW

alter table insurance add column HL_Charges varchar(10);

update insurance join (select avg(charges) as avg_charge from insurance) as t
 set HL_Charges  = case when insurance.charges > t.avg_charge then 'High' else 'Low' end;  
 
 select * from insurance;


# 17. Change location/position of ‘smoker’ and bring before ‘children’
describe insurance;

alter table insurance modify column smoker varchar(20) after bmi;

# 18. Show top 20 records
 select * from insurance limit 20;

# 19. Show bottom 20 records
select * from insurance order by id desc limit 20;

# 20. Randomly select 20% of records and export to desktop

select round(count(*)*0.2) from insurance;

select * from insurance order by rand() limit 268;
 
# 21. Remove column ‘ratio’
alter table insurance drop ratio;

# 22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in
# the script itself with remarks by using 

#Find all female records whose BMI is higher than the average BMI of all males.

select * from insurance where gender ="female" and bmi >(
select avg(bmi) from insurance where gender ="male");

-- Main Query -- Selects only female entries.
-- Subquery-- Calculates the average BMI of all males.
-- The outer query compares each female's BMI to this average.




# 23. Create a view called Female_HL_Charges that shows only those data where
# HL_Charges is High, Female, Smokers and with 0 children
create view Female_HL_Charges as(
select * from insurance where HL_charges ="High" and gender ="female" and smoker ="Yes" and children =0);


# 24. Update children column if there is 0 children then make it as Zero Children, if 1
# then one_children, if 2 then two_children, if 3 then three_children, if 4 then
# four_children if 5 then five_children else print it as More_than_five_children.
describe insurance;
alter table insurance modify children varchar(50);

 update insurance set children = case when children =0 then "Zero_children" 
 when children = 1 then "one_children" when children = 2 then "two_children" when children = 3 then "three_children"
 when children = 4 then "four_children " when children  = 5 then "five_children" else "More_than_five_children" end;
select * from insurance;


# 25. Mail the script to jeevan.raj@imarticus.com by EOD

