# spotify_SQL
# 🎧 Spotify Advanced SQL Project –

![Spotify Logo](https://github.com/yourusername/your-repo-name/blob/main/C:\Users\neelesh\Downloads\spotify_image.jpg)

## ✅ Project Overview

This project involves analyzing a **Spotify dataset** using SQL to explore various attributes of tracks, albums, and artists. The project focuses on understanding the dataset, writing SQL queries of varying complexity — from easy to advanced — and generating valuable insights.

The primary goals of this project are:

✔ Practice SQL data exploration techniques  
✔ Learn how to work with datasets involving multiple attributes  
✔ Write queries to extract meaningful information from the data  
✔ Work through easy, medium, and advanced query challenges  

This project is ideal for anyone looking to improve their SQL querying skills in a real-world dataset.

---

## 📂 Dataset Description

The dataset includes the following attributes:

- **artist** – Name of the performer  
- **track** – Title of the song  
- **album** – Name of the album  
- **album_type** – Type of album (single, album, etc.)  
- **danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo** – Various audio features  
- **duration_min** – Duration of the track in minutes  
- **title, channel** – Additional information about the track  
- **views, likes, comments, stream** – Popularity metrics  
- **licensed, official_video** – Properties indicating licensing and video availability  
- **energy_liveness** – Combined metric  
- **most_played_on** – Platform or channel where the track was most played  

---

## 📂 Project Steps

### 1️⃣ Data Exploration
- Load and inspect the dataset
- Identify patterns and data distribution
- Handle missing or incorrect data
- Explore unique values and correlations between attributes

### 2️⃣ SQL Query Writing
- ✅ **Easy Queries** – Simple filtering, counting, and grouping
- ✅ **Intermediate Queries** – Aggregations, joins, and more complex data retrieval
- ✅ **Advanced Queries** – Using window functions, ranking, and detailed analysis

---

## 💻 Table Definition

```sql
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

