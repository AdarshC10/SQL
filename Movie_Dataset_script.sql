create database if not exists movie;
use movie;

select * from movie;

update movie set mov_dt_rel = null where mov_dt_rel = '';
update movie set mov_dt_rel = str_to_date(mov_dt_rel,"%m/%d/%Y");
alter table movie modify mov_dt_rel date;


#1 Write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
select * from movie;
select mov_title,mov_year as movie_relesed_year from movie where mov_title="American Beauty";



#2 Write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title as Movie_before_1998, mov_year from movie where mov_year <= 1998 ;

#3 Write a query where it should contain all the data of the movies which were released after 1995 and their movie duration was greater than 120.

select * from movie where mov_year >1995 and mov_time >120 order by mov_year asc;

# 4 Write a query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of the movie year.

select * from ratings;
-- make table rating desc so get highest rating get top 7 
-- condition for country

select * from movie where mov_rel_country="UK" and mov_id in(
select mov_id from(
select mov_id  from ratings  order by rev_stars desc ) as top7) order by mov_year asc limit 7;

-- or

select * from (
select m.* from movie m inner join ratings r on m.mov_id = r.mov_id where mov_rel_country= "UK" order by rev_stars desc limit 7) as top7 order by mov_year asc;


# 5 Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and the movie year was 2001.

update movie set mov_lang = "Chinese" where mov_year=2001 and mov_lang ="japanese";
select * from movie;

# 6 Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'.
select * from reviewer;
select * from ratings;
-- inner join 3
-- condition
select rev_name as reviewers from movie m inner join ratings r using(mov_id) 
inner join reviewer rv on r.rev_id = rv.rev_id where mov_title ="Slumdog Millionaire" ;


# 7 Write a query which fetch the first name, last name & role played by the  actor where output should all exclude Male actors.

select * from actor;
select * from cast;
-- join 2
-- condition
select act_fname as first_name,act_lname as last_name,role from actor a  inner join cast c using(act_id)  where act_gender ="F";

# 8 Write a SQL query to find the actors who played a role in the movie 'Annie Hall'.Fetch all the fields of actor table. (Hint: Use the IN operator).
 select * from movie;
 select * from cast;
 select * from actor;
 
 -- concat(act_fname," ",act_lname) as Actor_name
select * from actor where act_id in(
 select act_id from movie m inner join cast ca using(mov_id) where mov_title ="Annie Hall" );
 
# 9 Write a SQL query to find those movies that have been released in countries other 
# than the United Kingdom. Return movie title, movie year, movie time, and date of release, releasing country.
select * from movie;
select mov_title as movie_title,
mov_year as movie_year,
mov_time as movie_time,
mov_dt_rel as date_of_release,
mov_rel_country as country from movie where mov_rel_country<> "UK";



# 10 Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join)

select * from movie_genres;
select * from movie;
select * from genres;

select gen_title,max(mov_time) as maximum_duration,count(mov_title) as no_of_movies from movie as m inner join movie_genres  as mg using(mov_id)
 inner join genres as g on mg.gen_id = g.gen_id group by gen_title;



# 11 Create a view which should contain the first name, last name, title of the
# movie & role played by particular actor.
select * from movie;
select * from actor;
select * from cast;


create view Actor_roles as(
select act_fname as first_name,act_lname as last_name,mov_title as title_of_the_movie,role as role_played_actor from movie as m inner join cast c using(mov_id) 
inner join actor a on c.act_id = a.act_id);

select * from Actor_roles; 

# 12 Write a SQL query to find the movies with the lowest ratings

select * from movie;
select * from ratings;
select * from(
select  m.mov_id, m.mov_title, 
    r.rev_stars,  dense_rank() over(order by r.rev_stars asc) as drnk from  movie as m inner join ratings r 
on m.mov_id = r.mov_id) as t where drnk =1 ;

# 13. Finally Mail the script to jeevan.raj@imarticus.com