CREATE TABLE IF NOT EXISTS domains.client
(
  id CHAR(36) PRIMARY KEY,
  consumer_id CHAR(36) NOT NULL REFERENCES domains.tenant (id),
  name VARCHAR(1024) NOT NULL,
  description VARCHAR(4096) NULL,
  kind VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.client_user
(
  client_id CHAR(36) NOT NULL REFERENCES domains.client (id),
  user_id CHAR(36) NOT NULL,

  PRIMARY KEY (client_id, user_id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

-- Related objects states (eservice, agreement, purpose) has been omitted because not relevant in this context
CREATE TABLE IF NOT EXISTS domains.client_purpose
(
  client_id CHAR(36) NOT NULL REFERENCES domains.client (id),
  purpose_id CHAR(36) NOT NULL REFERENCES domains.purpose (id),

  PRIMARY KEY (client_id, purpose_id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

