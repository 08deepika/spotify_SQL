--SPOTIFY DATASET--SQL PROJECT--

-- create table
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

------------------------------
EDA
------------------------------
SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT COUNT(DISTINCT album) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;

SELECT DISTINCT channel FROM spotify;

SELECT DISTINCT most_played_on FROM spotify;

----------------------------------------
--QUESTIONS AND SOLUTION --
----------------------------------------

-- Q.1 Retrieve the names of the all tracks that have more than 1 billion streams
SELECT * FROM spotify
WHERE stream > 1000000000;

-- Q.2 List all albums with their artists?
SELECT DISTINCT album, artist
FROM spotify
ORDER BY artist, album;

OR
SELECT DISTINCT album, artist
FROM spotify
ORDER BY 1 

-- Q.3 What is the average duration of tracks per album?
SELECT album_type, ROUND(AVG(duration_min)) as avg_duration
FROM spotify
GROUP BY album_type;

-- Q.4 Find all tracks that belong to the album type single
SELECT * FROM spotify
WHERE album_type = 'single

-- Q.5 Count the total number of tracks by each artist?
SELECT artist, COUNT(*) AS total_no_songs
FROM spotify
GROUP BY artist;

-- Q.6 Calculate the average danceability of tracks in each album
SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability desc;

-- Q.7 Most popular channel by total views?
SELECT channel, SUM(views) AS total_views
FROM spotify
GROUP BY channel
ORDER BY total_views DESC;

-- Q.8 List all tracks along with their views and likes where official_video = TRUE ?
SELECT track, SUM(views) AS total_views, SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY total_views DESC
LIMIT 5;

-- Q.9 For each album, calculate the total views of all associated tracks?
SELECT album, track, SUM(views) AS total_views
FROM spotify
GROUP BY album, track
ORDER BY total_views DESC;

-- Q.10 Most played song on Spotify vs YouTube?
SELECT album, most_played_on, MAX(stream) as max_stream
FROM spotify
GROUP BY album, most_played_on
ORDER BY max_stream DESC

-- Q.11 Retrieve the track names have been streamed on Spotify more than YouTube?
SELECT * FROM 
(SELECT track,
		COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
		COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify
GROUP BY track
) as new_table
WHERE streamed_on_spotify > streamed_on_youtube
	AND streamed_on_youtube <> 0;

-- Q.12 Find the top 3 most viewed tracks for each artist using window function?
WITH ranking_artist
AS
(SELECT
	artist,
	track,
	SUM(views) as total_views,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify
GROUP BY artist, track
ORDER BY 1,3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3;

-- Q.13 Find the top 5 albums with the highest total likes?
SELECT album, SUM(likes) AS total_likes
FROM spotify
GROUP BY album
ORDER BY total_likes DESC;

-- Q.14 Write a query to find tracks where the liveness scrore is above the average?
SELECT track, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

-- Q.15 Use a WITH Clause to calculate the difference between the highest and lowest energy values for tracks in each album?
WITH difference
AS
(SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1
)
SELECT album,
highest_energy - lowest_energy as diff
FROM difference
ORDER BY 2 DESC;

-- Q.16 List the top-3 channels with the most total views
SELECT channel, SUM(views) as total_views
FROM spotify
GROUP BY channel
ORDER BY total_views DESC
LIMIT 3;

-- Q.17 Find artists whose tracks are all official videos
SELECT artist
FROM spotify
GROUP BY artist
HAVING BOOL_AND(official_video = TRUE);

-- Q.18 List the artists who have at least 3 albums in the dataset
SELECT artist, COUNT(DISTINCT album) AS album_count
FROM spotify
GROUP BY artist
HAVING COUNT(DISTINCT album) >= 3
ORDER BY album_count DESC;

-- Q.19 What is the total numbers of streams for official videos vs non-official videous?
SELECT official_video, SUM(stream) as total_steams
FROM spotify
GROUP BY official_video
ORDER BY 1 DESC;

-- Q.20 What is the average duration of tracks per album type?
SELECT album_type, ROUND(AVG(duration_min)) as avg_duration
FROM spotify
GROUP BY album_type;