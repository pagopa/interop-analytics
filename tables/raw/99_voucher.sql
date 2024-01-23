CREATE TABLE IF NOT EXISTS domains.generated_jwt
( 
  jwt_id CHAR(36) PRIMARY KEY,
  correlation_id VARCHAR NULL,
  issued_at TIMESTAMP NOT NULL,
  client_id CHAR(36) NOT NULL REFERENCES domains.client (id),
  organization_id CHAR(36) NOT NULL REFERENCES domains.tenant (id),
  agreement_id CHAR(36) NOT NULL REFERENCES domains.agreement (id),
  eservice_id CHAR(36) NOT NULL REFERENCES domains.eservice (id),
  descriptor_id CHAR(36) NOT NULL REFERENCES domains.eservice_descriptor (id),
  purpose_id CHAR(36) NOT NULL REFERENCES domains.purpose (id),
  purpose_version_id CHAR(36) NOT NULL REFERENCES domains.purpose_version (id),
  algorithm VARCHAR(10) NOT NULL,
  key_id VARCHAR(50) NOT NULL,
  audience VARCHAR(1024) NOT NULL,
  subject VARCHAR(1024) NOT NULL,
  not_before TIMESTAMP NOT NULL,
  expiration_time TIMESTAMP NOT NULL,
  issuer VARCHAR(1024) NOT NULL,
  client_assertion_jwt_id VARCHAR(1024) NOT NULL,
  client_assertion_issued_at TIMESTAMP NOT NULL,
  client_assertion_algorithm VARCHAR(10) NOT NULL,
  client_assertion_key_id VARCHAR(50) NOT NULL,
  client_assertion_issuer VARCHAR(1024) NOT NULL,
  client_assertion_subject VARCHAR(1024) NOT NULL,
  client_assertion_audience VARCHAR(1024) NOT NULL,
  client_assertion_expiration_time TIMESTAMP NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;
