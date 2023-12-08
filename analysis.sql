CREATE VIEW number_one_songs AS 
(
    SELECT playlist_songs.song_id, playlists.wrapped_year
    FROM playlist_songs
    LEFT OUTER JOIN playlists ON playlist_songs.playlist_id = playlists.playlist_id
    WHERE playlist_songs.position = 1
);

-- find number one songs that are also in other wrapped years 
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
AND songs.spotify_id IN (SELECT song_id FROM number_one_songs);


