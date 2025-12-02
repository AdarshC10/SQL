create database Netflix_Data;

use Netflix_Data;

show tables;
select * from titles;

#1. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores?

select title, type,tmdb_score from titles where type = "movie" order by tmdb_score desc limit 10;

select title, type,tmdb_score from titles where type = "show" order by tmdb_score desc limit 10;

select title, type,tmdb_score from titles where type = "movie" order by tmdb_score asc limit 10;

select title, type,tmdb_score from titles where type = "show" order by tmdb_score asc limit 10;

#2. How many movies and shows fall in each decade in Netflix's library?
select floor(release_year/10) *10 as decade,count(*) as movie_show_count from titles group by floor(release_year/10) *10 order by movie_show_count asc;

#3. How did age-certifications impact the dataset?
select * from titles;
select distinct age_certification , ROUND(AVG(imdb_score),2) AS avg_imdb_score,
ROUND(AVG(tmdb_score),2) AS avg_tmdb_score from titles group by age_certification ORDER BY avg_imdb_score DESC;

update titles set age_certification = "N/A" where age_certification = "";

select age_certification,count(*) as count  from titles where type = "movie" and age_certification != "N/A" group by age_certification;

#4. Which genres are the most common?
#Top 10 most common genres for MOVIES
select genres , titles, count(*) as title_count from titles where  type = "movie" group by genres order by  title_count desc	;

#Top 10 most common genres for SHOWS
select genres,count(*) as title_count from titles where type = "show" group by genres order by title_count desc ; 

#Top 3 most common genres OVERALL
select genres,count(*) as title_count from titles group by genres;

#
-- Who were the top 20 actors that appeared the most in movies/shows? 
select * from credits;
select * from titles;
select name as actor, count(*) as no_apperance from credits  where role = "actor" group by actor order by no_apperance desc limit 20;
# -- Who were the top 20 directors that directed the most movies/shows? 
select name as director,count(*) as no_of_apperance from credits where role = "director" group by director order by  no_of_apperance desc limit 20;
-- Calculating the average runtime of movies and TV shows separately
select type,avg(runtime) as avg_runtime from titles where type ="movie"
union all
select type,avg(runtime) as avg_runtime from titles where type ="show";

-- Finding the titles and  directors of movies released on or after 2010
select * from titles;
select distinct t.title, c.name as directors,t.release_year from titles t join credits c using(id) where c.role = "director" and t.release_year >= 2010 and t.type ="movie";

-- Which shows on Netflix have the most seasons?
select title,seasons from titles where type = "show" order by seasons desc;

-- Which genres had the most movies?
select genres, count(*) as title_count from titles group by genres order by title_count desc;
-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80)

select title,name as director,imdb_score,tmdb_popularity from titles as t join credits as c using(id) where role = "director" and imdb_score >7.5 and tmdb_popularity >20;
-- What were the total number of titles for each year? 	
select release_year,count(*) as total_number_titles from titles group by release_year order by total_number_titles desc;

-- Actors who have starred in the most highly rated movies or shows
select c.name,count(*) as count_title,t.imdb_score, t.tmdb_score from titles as t join credits c using(id) where c.role = "actor" and (t.type = "movie" or t.type = "show") 
 group by c.name  ,t.imdb_score, t.tmdb_score order by	 t.imdb_score desc, t.tmdb_score desc  ;


-- Which actors/actresses played the same character in multiple movies or TV shows? 
select c.name as actor_actress,c.character,count(t.title) as num_title from titles as t join credits c using(id) where t.type = "movie" or t.type = "show"
 group by actor_actress,c.character having num_title>2;

-- Average IMDB score for leading actors/actresses in movies or shows
select c.name as actor_actress, avg(imdb_score) as Average_IMDB from titles t join credits c using(id) where t.type = "movie" or t.type = "show" group by actor_actress;