create database clinictria;
use clinictria ;
select * from clinictrial;

#1. Add index name fast on Name
-- checking the data type
describe clinictrial;

-- alter to mofify the datatype
alter table clinictrial modify name varchar(20);

-- set the index
create index fast on clinictrial(name);

#2. Describe the schema of table
describe clinictrial;

#3. Find average of Age

select avg(age) avg_age from clinictrial;

# 4. Find minimum of Age
select min(age) as min_age from clinictrial;

# 5. Find maximum of Age
select max(age ) from clinictrial;

# 6. Find average age of those were pregnant and not pregnant
  
  select pregnant, avg(age) as avg_age_pregnant from clinictrial group by pregnant;

# 7. Find average blood pressure of those had drug reaction and did not had drug 
# reaction
select Drug_Reaction,avg(bp) as avg_bp from clinictrial group by Drug_Reaction;

# 8. Add new column name as ‘Age_group’ and those having age between 16 & 21

# should be categorized as Low, more than 21 and less than 35 should be 
# categorized as Middle and above 35 should be categorized as High.

-- add new column Age_group
-- change data type

alter table clinictrial add column Age_group varchar(10);

update clinictrial set Age_group = case when age between 16 and 21 then 'Low' 
when age> 21 and age < 35 then 'Middle' when age >= 35 then 'High' end;
 

# 9. Change ‘Age’ of Reetika to 32
update clinictrial set Age =32 where name="Reetika";
-- check its changed or not
 select * from clinictrial where name="Reetika";
 

# 10. Change name of Reena as Shara’
update clinictrial set name="Shara" where name="Reena";
-- check its changed or not
select * from clinictrial where name="Shara";

# 11. Remove Chlstrl column

alter table clinictrial drop Chlstrl;

# 12. Select only Name, Age and BP
select Name,Age,BP from clinictrial;

# 13. Select ladies whose first name starts with ‘E’
select * from clinictrial where name like 'E%';

# 14. Select ladies whose Age_group were Low
select * from clinictrial;
select * from clinictrial where Age_group ='Low';

# 15. Select ladies whose Age_group were High
select * from clinictrial where age_group = 'High';

# 16. Select ladies whose name starts with ‘A’ and those were pregnant 
select * from clinictrial where name like 'A%' and pregnant = 'Yes';

# 17. Identify ladies whose BP was more than 120 
select * from clinictrial where bp> 120;


# 18. Identify ladies whose BP was between 100 and 120 
select * from clinictrial where bp between 100 and 120;

# 19. Identify ladies who had low anxiety aged less than 30

select * from clinictrial where age <30 and Anxty_LH= 'no'  ;

# 20.Select ladies whose name ends with ‘i’
select * from clinictrial where name like '%i';

# 21. Select ladies whose name ends with ‘a’
select * from clinictrial where name like '%a';

# 22.Select ladies whose name starts with ‘K’

select * from clinictrial where name like 'K%';

# 23.Select ladies whose name have ‘a’ anywhere 
select * from clinictrial where name like '%a%';

# 24. Order ladies in ascending way based on ‘BP’
select * from clinictrial order by bp asc;

# 25. Order ladies in descending way based on ‘Age
select * from clinictrial order by age desc;