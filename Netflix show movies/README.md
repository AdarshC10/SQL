# 📊 Netflix Shows and Movies Analytics Project

## 🚀 Overview
This project analyzes Netflix’s library of movies and shows using **SQL, Excel, and Tableau** to uncover meaningful content insights for subscribers. With over **82,000 rows of data**, the goal was to extract patterns related to ratings, genres, age certifications, and release decades to support content decisions and improve user recommendations.

---

## 🎯 Business Problem
Netflix handles a massive dataset and sought answers to:
- Which titles are the highest and lowest rated?
- How does the number of shows/movies vary by decade?
- How do age classifications impact ratings and title distribution?
- Which genres dominate the platform?

A scalable data analytics solution was needed to transform raw data into actionable insights.

---

## 🛠 Tools & Technologies
| Tool | Purpose |
|------|---------|
| Excel | Cleaning and preprocessing |
| MySQL | Data extraction and SQL analytics |
| Tableau | Visual dashboards and storytelling |

---

## 📌 Key Questions & Insights

---

### 1. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores?
- 1. Top Movie

```sql
SELECT title, type, imdb_score
FROM titles
WHERE type = 'movie'
ORDER BY imdb_score DESC
LIMIT 10;
```
<img width="399" height="219" alt="image" src="https://github.com/user-attachments/assets/ff5d6371-a6e0-4ed7-a880-a7ab8c9be648" />

- Top 10 Shows
  
```sql
SELECT title, 
type, 
imdb_score
FROM shows_movies.titles
WHERE imdb_score >= 8.0
AND type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10
```
<img width="400" height="276" alt="image" src="https://github.com/user-attachments/assets/ccfb190d-44e5-472d-aae1-93974acb70af" />

- Bottom 10 Shows
  
```sql
SELECT title, 
type, 
imdb_score
FROM shows_movies.titles
WHERE type = 'SHOW'
ORDER BY imdb_score ASC
LIMIT 10
```
<img width="399" height="248" alt="image" src="https://github.com/user-attachments/assets/4291930b-2cb4-433c-b27c-92b3686f4174" />

### 2. How many movies and shows fall in each decade in Netflix's library?

```sql
SELECT CONCAT(FLOOR(release_year / 10) * 10, ) AS decade,
	COUNT(*) AS movies_shows_count
FROM shows_movies.titles
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;
```

<img width="315" height="302" alt="image" src="https://github.com/user-attachments/assets/3e57a702-4d4b-4acc-a35c-65f8f94ad0b9" />

### 3. How did age-certifications impact the dataset?

```sql
SELECT DISTINCT age_certification, 
ROUND(AVG(imdb_score),2) AS avg_imdb_score,
ROUND(AVG(tmdb_score),2) AS avg_tmdb_score
FROM shows_movies.titles
GROUP BY age_certification
ORDER BY avg_imdb_score DESC
```

<img width="350" height="355" alt="image" src="https://github.com/user-attachments/assets/f9571e08-7979-4693-869c-27b0c0f3dc74" />

### 4. Which genres are the most common?
- Top 10 most common genres for MOVIES
  
  ```sql
  SELECT genres, 
COUNT(*) AS title_count
FROM shows_movies.titles 
WHERE type = 'Movie'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;
```
<img width="400" height="329" alt="image" src="https://github.com/user-attachments/assets/ae5100b3-e0b6-4456-b885-a38771cb5f25" />

- Top 10 most common genres for SHOWS

```sql
SELECT genres, 
COUNT(*) AS title_count
FROM shows_movies.titles 
WHERE type = 'Show'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;
```

<img width="400" height="329" alt="image" src="https://github.com/user-attachments/assets/498ef3be-92d5-4a9f-8f02-836106535274" />




