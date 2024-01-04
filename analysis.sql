/*
SELECT track_name FROM songs
LEFT OUTER JOIN song_genres ON song_genres.song_id = songs.spotify_id
LEFT OUTER JOIN genres ON genres.genre_id = song_genres.genre_id
WHERE genres.genre = 'german techno';


CREATE VIEW number_one_songs AS 
(
    SELECT playlist_songs.song_id, playlists.wrapped_year
    FROM playlist_songs
    LEFT OUTER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
    WHERE playlist_songs.position = 1
);

--find number one songs that are not in any other wrapped years
SELECT songs.track_name 
FROM songs
WHERE songs.spotify_id NOT IN 
(
    SELECT songs.spotify_id
    FROM number_one_songs
    LEFT OUTER JOIN songs ON number_one_songs.song_id = songs.spotify_id
    LEFT OUTER JOIN playlist_songs ON songs.spotify_id = playlist_songs.song_id
    WHERE songs.spotify_id IN (SELECT song_id FROM number_one_songs)
    AND playlist_songs.position != 1
)
AND songs.spotify_id IN (SELECT song_id FROM number_one_songs);--


----find top genres grouped by year
--CREATE VIEW top_genres_by_year AS (
--    WITH genre_counts AS (
--        SELECT  playlists.wrapped_year, 
--                genres.genre,  
--                COUNT(*) AS genre_count
--        FROM song_genres
--        LEFT JOIN playlist_songs ON song_genres.song_id = playlist_songs.song_id
--        LEFT OUTER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
--        LEFT OUTER JOIN genres ON song_genres.genre_id = genres.genre_id
--        GROUP BY playlists.wrapped_year, genres.genre
--    )
--    SELECT  genre_counts.wrapped_year, 
--            genre_counts.genre_id, 
--            genre_counts.genre_count 
--    FROM genre_counts 
--    WHERE (genre_counts.wrapped_year, genre_counts.genre_count) IN (
--        SELECT  genre_counts.wrapped_year, 
--                MAX(genre_counts.genre_count)
--        FROM genre_counts
--        GROUP BY wrapped_year
--    )
--); 

--SELECT * FROM top_genres_by_year;

--SELECT songs.track_name, artists.artist_name, genres.genre 
--FROM songs 
--LEFT OUTER JOIN song_genres ON song_genres.song_id = songs.spotify_id
--LEFT OUTER JOIN artist_songs ON artist_songs.song_id = songs.spotify_id
--LEFT OUTER JOIN artists ON artists.artist_id = artist_songs.artist_id
--LEFT OUTER JOIN genres ON genres.genre_id = song_genres.genre_id
--WHERE genres.genre = 'minneapolis indie';


SELECT songs.track_name, artists.artist_name, genres.genre 
FROM songs 
LEFT OUTER JOIN song_genres ON song_genres.song_id = songs.spotify_id
LEFT OUTER JOIN artist_songs ON artist_songs.song_id = songs.spotify_id
LEFT OUTER JOIN artists ON artists.artist_id = artist_songs.artist_id
LEFT OUTER JOIN genres ON genres.genre_id = song_genres.genre_id
WHERE songs.track_name = 'Chamber Of Reflection';


-- List all genres that have more than 10 songs associated with them.
SELECT COUNT(genres.genre), genres.genre
FROM songs
LEFT OUTER JOIN song_genres ON song_genres.song_id = songs.spotify_id
LEFT OUTER JOIN genres ON genres.genre_id = song_genres.genre_id
GROUP BY genres.genre
HAVING COUNT(genres.genre) > 30
ORDER BY COUNT(genres.genre) DESC;

-- Group songs by their album_name and count the number of songs in each album.
SELECT COUNT(albums.album_id), albums.album_name
FROM albums
LEFT OUTER JOIN album_songs ON album_songs.album_id = albums.album_id
LEFT OUTER JOIN songs ON album_songs.song_id = songs.spotify_id
GROUP BY albums.album_id
HAVING COUNT(albums.album_id) > 3;

-- Group songs by their album_name and year and count the number of songs in each album.
SELECT COUNT(albums.album_id), albums.album_name, playlists.wrapped_year
FROM albums
LEFT OUTER JOIN album_songs ON album_songs.album_id = albums.album_id
LEFT OUTER JOIN songs ON album_songs.song_id = songs.spotify_id
LEFT OUTER JOIN playlist_songs ON playlist_songs.song_id = songs.spotify_id
LEFT OUTER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
GROUP BY albums.album_id, playlists.wrapped_year
HAVING COUNT(albums.album_id) > 3;


SELECT songs.track_name
FROM songs 
LEFT OUTER JOIN album_songs ON album_songs.song_id = songs.spotify_id
LEFT OUTER JOIN albums ON album_songs.album_id = albums.album_id
WHERE albums.album_name = 'racine carrée';

-- count genres in top 3 positions
SELECT genres.genre, COUNT(genres.genre)
FROM songs
LEFT OUTER JOIN playlist_songs ON playlist_songs.song_id = songs.spotify_id
LEFT OUTER JOIN song_genres ON song_genres.song_id = songs.spotify_id
LEFT OUTER JOIN genres ON genres.genre_id = song_genres.genre_id
WHERE playlist_songs.position < 2
GROUP BY genres.genre
ORDER BY COUNT(genres.genre) DESC;

SELECT songs.track_name, artists.artist_name, playlists.wrapped_year
FROM songs
LEFT OUTER JOIN playlist_songs ON playlist_songs.song_id = songs.spotify_id
LEFT OUTER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
LEFT OUTER JOIN artist_songs ON artist_songs.song_id = songs.spotify_id
LEFT OUTER JOIN artists ON artists.artist_id = artist_songs.artist_id
WHERE artists.artist_name = 'Tame Impala' AND playlists.wrapped_year = '2023'
ORDER BY track_name ASC;
*/


-- select artists with more than 4 songs in a year
SELECT artists.artist_name, COUNT(DISTINCT songs.spotify_id) AS song_count, playlists.wrapped_year
FROM songs
INNER JOIN artist_songs ON artist_songs.song_id = songs.spotify_id
INNER JOIN artists ON artists.artist_id = artist_songs.artist_id
INNER JOIN playlist_songs ON playlist_songs.song_id = songs.spotify_id
INNER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
--WHERE playlists.wrapped_year = '2020'
GROUP BY artists.artist_name, playlists.wrapped_year
HAVING COUNT(DISTINCT songs.spotify_id) > 4
ORDER BY wrapped_year DESC;


