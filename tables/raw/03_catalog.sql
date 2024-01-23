CREATE TABLE IF NOT EXISTS domains.eservice
(
  id CHAR(36) PRIMARY KEY,
  producer_id CHAR(36) NOT NULL REFERENCES domains.tenant (id),
  name VARCHAR(1024) NOT NULL,
  description VARCHAR(4096) NOT NULL,
  technology VARCHAR(32) NOT NULL,
  mode VARCHAR(32) NOT NULL,
  created_at TIMESTAMP NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_descriptor
(
  id CHAR(36) PRIMARY KEY,
  description VARCHAR(4096) NULL,
  
  interface_id CHAR(36) NULL,
  interface_name VARCHAR(1024) NULL,
  interface_content_type VARCHAR(1024) NULL,
  interface_pretty_name VARCHAR(1024) NULL,
  interface_path VARCHAR(1024) NULL,
  interface_checksum VARCHAR(1024) NULL,
  interface_upload_date TIMESTAMP NULL,

  state VARCHAR(50) NOT NULL,
  audience VARCHAR(4096) NOT NULL, -- It contains a json array
  voucher_lifespan INTEGER NOT NULL,
  daily_calls_per_consumer INTEGER NOT NULL,
  daily_calls_total INTEGER NOT NULL,
  agreement_approval_policy VARCHAR(50) NULL,
  created_at TIMESTAMP NOT NULL,
  server_urls VARCHAR(4096) NOT NULL, -- It contains a json array
  published_at TIMESTAMP NULL,
  suspended_at TIMESTAMP NULL,
  deprecated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL,

  eservice_id CHAR(36) NOT NULL REFERENCES domains.eservice (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;


CREATE TABLE IF NOT EXISTS domains.eservice_descriptor_attribute_group
(
  group_id SMALLINT NOT NULL, -- This is the index of the group in the array taken from the event (is the i of eservice.descriptor.attribute.certified[i])
  attribute_id CHAR(36) NOT NULL REFERENCES domains.attribute (id),
  explicitAttributeVerification BOOLEAN NOT NULL,
  PRIMARY KEY (group_id, attribute_id) 
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_descriptor_attribute_group_assignment
(
  eservice_descriptor_id CHAR(36) NOT NULL REFERENCES domains.eservice_descriptor (id),
  group_id SMALLINT NOT NULL, -- This should reference domains.eservice_descriptor_attribute_group (group_id), but that column cannot have a unique constraint
  attribute_type VARCHAR(32) NOT NULL, -- certified, declared or verified

  PRIMARY KEY (eservice_descriptor_id, group_id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;


CREATE TABLE IF NOT EXISTS domains.eservice_descriptor_document
(
  id CHAR(36) PRIMARY KEY,
  name VARCHAR(1024) NOT NULL,
  content_type VARCHAR(1024) NOT NULL,
  pretty_name VARCHAR(1024) NOT NULL,
  path VARCHAR(1024) NOT NULL,
  checksum VARCHAR(1024) NOT NULL,
  upload_date TIMESTAMP NOT NULL,

  eservice_descriptor_id CHAR(36) NOT NULL REFERENCES domains.eservice_descriptor (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_risk_analysis_form_single_answer
(
  id CHAR(36) PRIMARY KEY,
  key VARCHAR(1024) NOT NULL,
  value VARCHAR(16384) NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_risk_analysis_form_multi_answer
(
  id CHAR(36) PRIMARY KEY,
  key VARCHAR(1024) NOT NULL,
  values VARCHAR(16384) NOT NULL -- It contains a json array
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_risk_analysis_form
(
  id CHAR(36) PRIMARY KEY,
  version VARCHAR(10) NOT NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.eservice_risk_analysis
(
  id CHAR(36) PRIMARY KEY,
  name VARCHAR(1024) NOT NULL,
  risk_analysis_form_id CHAR(36) NOT NULL REFERENCES domains.eservice_risk_analysis_form (id),
  created_at TIMESTAMP NOT NULL,

  eservice_descriptor_id CHAR(36) NOT NULL REFERENCES domains.eservice_descriptor (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

