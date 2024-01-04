--DROP TABLE IF EXISTS album_songs;
--DROP TABLE IF EXISTS albums;
--DROP TABLE IF EXISTS song_genres;
--DROP TABLE IF EXISTS genres;
--DROP VIEW IF EXISTS song_info;
--DROP VIEW if exists number_one_songs;
--DROP TABLE IF EXISTS playlist_songs;
--DROP TABLE IF EXISTS artist_songs;
--DROP TABLE IF EXISTS songs;
--DROP TABLE IF EXISTS artists;
--DROP TABLE IF EXISTS playlists;


CREATE TABLE IF NOT EXISTS songs (
    spotify_id TEXT PRIMARY KEY,
    track_name TEXT,
    release_date DATE,
    duration INT,
    popularity INT,
    added_by TEXT,
    added_at TEXT,
    danceability FLOAT,
    energy FLOAT,
    music_key INT,
    loudness FLOAT,
    mode INT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    time_signature INT
);

CREATE TABLE IF NOT EXISTS artists (
    artist_name TEXT,
    artist_id TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS playlists (
    wrapped_year TEXT,
    user_id TEXT,
    playlist_id TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS playlist_songs (
    playlist_id TEXT,
    song_id TEXT,
    position INT,
    FOREIGN KEY (song_id) REFERENCES songs,
    FOREIGN KEY (playlist_id) REFERENCES playlists,
    PRIMARY KEY (position, playlist_id, song_id)     
);

CREATE TABLE IF NOT EXISTS artist_songs (
    song_id TEXT,
    artist_id TEXT,
    FOREIGN KEY (artist_id) REFERENCES artists,
    FOREIGN KEY (song_id) REFERENCES songs,
    PRIMARY KEY (artist_id, song_id)
);

CREATE TABLE IF NOT EXISTS genres (
    genre TEXT,
    genre_id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS song_genres (
    song_id TEXT,
    genre_id INT,
    FOREIGN KEY (song_id) REFERENCES songs,
    FOREIGN KEY (genre_id) REFERENCES genres,
    PRIMARY KEY (song_id, genre_id)
);

CREATE TABLE IF NOT EXISTS albums (
    album_name TEXT,
    album_id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS album_songs (
    song_id TEXT,
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES albums,
    FOREIGN KEY (song_id) REFERENCES songs,
    PRIMARY KEY (album_id, song_id)
);