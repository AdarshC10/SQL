# 📊 Netflix Shows and Movies Analytics Project

## 🚀 Overview
This project analyzes Netflix’s library of movies and shows using **SQL, Excel** to uncover meaningful content insights for subscribers. With over **82,000 rows of data**, the goal was to extract patterns related to ratings, genres, age certifications, and release decades to support content decisions and improve user recommendations.

---

## 🎯 Business Problem
Netflix handles a massive dataset and sought answers to:
- Which titles are the highest and lowest rated?
- How does the number of shows/movies vary by decade?
- How do age classifications impact ratings and title distribution?
- Which genres dominate the platform?

A scalable data analytics solution was needed to transform raw data into actionable insights.

---
## 📂 Dataset Source
The dataset used in this analysis is publicly available on Kaggle:  
🔗 **[Netflix TV Shows and Movies — Kaggle](https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies?select=titles.csv)**

---

## 🛠 Tools & Technologies
| Tool | Purpose |
|------|---------|
| Excel | Cleaning and preprocessing |
| MySQL | Data extraction and SQL analytics |

---

## Questions I Wanted To Answer From the Dataset:

### 1. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores?

- Top 10 Movies
```sql
SELECT title, 
type, 
imdb_score
FROM titles
WHERE imdb_score >= 8.0
AND type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10

```
<img width="399" height="219" alt="image" src="https://github.com/user-attachments/assets/390332db-ce10-417d-8602-5232ae0d9252" />

- Top 10 Shows
  
```sql
SELECT title, 
type, 
imdb_score
FROM titles
WHERE imdb_score >= 8.0
AND type = 'SHOW'
ORDER BY imdb_score DESC
LIMIT 10
```
<img width="400" height="276" alt="image" src="https://github.com/user-attachments/assets/a164d9e7-7e0f-4a38-b755-509e0cbf5068" />

- Bottom 10 Movies
  
```sql
SELECT title, 
type, 
imdb_score
FROM titles
WHERE type = 'MOVIE'
ORDER BY imdb_score ASC
LIMIT 10
```
<img width="399" height="248" alt="image" src="https://github.com/user-attachments/assets/aa95607d-8322-4676-8cd0-afe26ae835dc" />

- Bottom 10 Shows

```sql
SELECT title, 
type, 
imdb_score
FROM titles
WHERE type = 'SHOW'
ORDER BY imdb_score ASC
LIMIT 10
```
<img width="399" height="248" alt="image" src="https://github.com/user-attachments/assets/6c7a3720-d810-4c83-aba5-5b28ed98bd61" />

### 2. How many movies and shows fall in each decade in Netflix's library?

```sql
SELECT CONCAT(FLOOR(release_year / 10) * 10) AS decade,
	COUNT(*) AS movies_shows_count
FROM titles
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10)
ORDER BY decade;
```
<img width="315" height="302" alt="image" src="https://github.com/user-attachments/assets/c45e3ce9-744d-4e48-bda8-4e77cd9f438b" />

### 3. How did age-certifications impact the dataset?

```sql
SELECT DISTINCT age_certification, 
ROUND(AVG(imdb_score),2) AS avg_imdb_score,
ROUND(AVG(tmdb_score),2) AS avg_tmdb_score
FROM titles
GROUP BY age_certification
ORDER BY avg_imdb_score DESC
```
<img width="350" height="355" alt="image" src="https://github.com/user-attachments/assets/a4154fcf-a7f8-4f5d-aedb-bdc63cc48cc6" />

### 4. Which genres are the most common?

- Top 10 most common genres for MOVIES
  
```sql
SELECT genres, 
COUNT(*) AS title_count
FROM titles 
WHERE type = 'Movie'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;
```
<img width="400" height="329" alt="image" src="https://github.com/user-attachments/assets/d2c2141e-a37d-4b62-a55e-440962ed64d1" />

- Top 10 most common genres for SHOWS
```sql
SELECT genres, 
COUNT(*) AS title_count
FROM titles 
WHERE type = 'Show'
GROUP BY genres
ORDER BY title_count DESC
LIMIT 10;
```
- Top 3 most common genres OVERALL
```sql
SELECT t.genres, 
COUNT(*) AS genre_count
FROM titles AS t
WHERE t.type = 'Movie' or t.type = 'Show'
GROUP BY t.genres
ORDER BY genre_count DESC
LIMIT 3;
```
<img width="399" height="125" alt="image" src="https://github.com/user-attachments/assets/f9591d75-0e54-450e-83e1-a669cf3549ab" />



