--DROP TABLE IF EXISTS song_genres;
--DROP TABLE IF EXISTS genres;
--DROP TABLE IF EXISTS artist_songs;
--DROP TABLE IF EXISTS artists;
--DROP TABLE IF EXISTS playlist_songs;
--DROP TABLE IF EXISTS playlists;
--DROP TABLE IF EXISTS songs;

CREATE TABLE IF NOT EXISTS songs (
    spotify_id TEXT PRIMARY KEY,
    track_name TEXT,
    album_name TEXT,
    release_date TEXT,
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
    artist_id TEXT PRIMARY KEY,
    artist_name TEXT
);

CREATE TABLE IF NOT EXISTS playlists (
    playlist_id TEXT PRIMARY KEY,
    wrapped_year TEXT
);

CREATE TABLE IF NOT EXISTS playlist_songs (
    song_id TEXT,
    playlist_id TEXT,
    position INT,
    FOREIGN KEY (song_id) REFERENCES songs,
    FOREIGN KEY (playlist_id) REFERENCES playlists,
    PRIMARY KEY (position, playlist_id)     
);

CREATE TABLE IF NOT EXISTS artist_songs (
    artist_id TEXT,
    song_id TEXT,
    FOREIGN KEY (artist_id) REFERENCES artists,
    FOREIGN KEY (song_id) REFERENCES songs,
    PRIMARY KEY (artist_id, song_id)
);

CREATE TABLE IF NOT EXISTS genres (
    genre TEXT,
    genre_id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS song_genres (
    genre_id INT,
    song_id TEXT,
    FOREIGN KEY (song_id) REFERENCES songs,
    FOREIGN KEY (genre_id) REFERENCES genres,
    PRIMARY KEY (song_id, genre_id)
);