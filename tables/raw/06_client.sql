CREATE TABLE IF NOT EXISTS domains.client
(
  id CHAR(36) PRIMARY KEY,
  consumer_id CHAR(36) NOT NULL REFERENCES tenant (id),
  name VARCHAR(1024) NOT NULL,
  purposes Seq[PersistentClientStatesChain], --
  description VARCHAR(4096) NULL,
  kind VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.client_user
(
  client_id CHAR(36) NOT NULL REFERENCES client (id),
  user_id CHAR(36) NOT NULL,

  PRIMARY KEY (client_id, user_id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

-- Related objects states (eserviuce, agreement, purpose) has been omitted because not relevant in this context
CREATE TABLE IF NOT EXISTS domains.client_purpose
(
  client_id CHAR(36) NOT NULL REFERENCES client (id),
  purpose_id CHAR(36) NOT NULL REFERENCES purpose (id),

  PRIMARY KEY (client_id, purpose_id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

