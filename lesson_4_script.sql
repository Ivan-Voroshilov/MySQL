USE vk;

UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                 

CREATE TEMPORARY TABLE genders(name VARCHAR(50));

INSERT INTO genders VALUES
  ('F'),
  ('M');
    
UPDATE profiles SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);  

ALTER TABLE profiles MODIFY COLUMN gender ENUM('M', 'F');

UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);

UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

INSERT INTO extensions VALUES ('jpeg'), ('mp4'), ('mp3'), ('avi'), ('png');

UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

ALTER TABLE media MODIFY COLUMN metadata JSON;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

TRUNCATE media_types;

UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

ALTER TABLE friendship DROP COLUMN requested_at;

UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);

UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;

UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at; 

UPDATE friendship SET confirmed_at = NOW() WHERE confirmed_at < created_at;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
  
UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3); 


DELETE FROM communities WHERE id > 30;

SELECT * FROM communities_users;

UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 30);
