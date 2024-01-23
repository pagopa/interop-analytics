CREATE TABLE IF NOT EXISTS domains.purpose
(
  id CHAR(36) PRIMARY KEY,
  eservice_id CHAR(36) NOT NULL REFERENCES eservice (id),
  consumer_id CHAR(36) NOT NULL REFERENCES tenant (id),
  suspended_by_consumer TIMESTAMP NULL,
  suspended_by_producer TIMESTAMP NULL,
  title VARCHAR(1024) NOT NULL,
  description VARCHAR(4096) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NULL,
  is_free_of_charge BOOLEAN NOT NULL,
  free_of_charge_reason BOOLEAN NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.purpose_version
(
  id CHAR(36) PRIMARY KEY,
  state VARCHAR(50) NOT NULL,
  expected_approval_date TIMESTAMP NULL,

  risk_analysis_id CHAR(36) NULL,
  risk_analysis_content_type VARCHAR(1024) NULL,
  risk_analysis_path VARCHAR(1024) NULL,
  risk_analysis_created_at TIMESTAMP NULL,

  daily_calls INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NULL,
  first_activation_at TIMESTAMP NULL,
  suspended_at TIMESTAMP NULL,

  purpose_id CHAR(36) NOT NULL REFERENCES purpose (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.purpose_risk_analysis_form_single_answer
(
  id CHAR(36) PRIMARY KEY,
  key VARCHAR(1024) NOT NULL,
  value VARCHAR(16384) NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.purpose_risk_analysis_form_multi_answer
(
  id CHAR(36) PRIMARY KEY,
  key VARCHAR(1024) NOT NULL,
  values VARCHAR(16384) NOT NULL -- It contains a json array
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.purpose_risk_analysis_form
(
  id CHAR(36) PRIMARY KEY,
  version VARCHAR(10) NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.purpose_risk_analysis
(
  id CHAR(36) PRIMARY KEY,
  name VARCHAR(1024) NOT NULL,
  risk_analysis_form_id CHAR(36) NOT NULL REFERENCES purpose_risk_analysis_form (id),
  created_at TIMESTAMP NOT NULL,

  purpose_id CHAR(36) NOT NULL REFERENCES purpose (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;
