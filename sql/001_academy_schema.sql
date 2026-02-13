CREATE TABLE IF NOT EXISTS academy_stats (
  identifier VARCHAR(64) NOT NULL,
  kills INT NOT NULL DEFAULT 0,
  deaths INT NOT NULL DEFAULT 0,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (identifier)
);

CREATE VIEW academy_ranking AS
SELECT
  identifier,
  kills,
  deaths,
  CASE WHEN deaths = 0 THEN kills ELSE kills / deaths END AS kd,
  updated_at
FROM academy_stats
ORDER BY kills DESC;
