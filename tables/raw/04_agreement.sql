CREATE TABLE IF NOT EXISTS domains.agreement
(
  id CHAR(36) PRIMARY KEY,
  eservice_id CHAR(36) NOT NULL REFERENCES domains.eservice (id),
  descriptor_id CHAR(36) NOT NULL REFERENCES domains.eservice_descriptor (id),
  producer_id CHAR(36) NOT NULL REFERENCES domains.tenant (id),
  consumer_id CHAR(36) NOT NULL REFERENCES domains.tenant (id),
  state VARCHAR(50) NOT NULL,
  suspended_by_consumer BOOLEAN NULL,
  suspended_by_producer BOOLEAN NULL,
  suspended_by_platform BOOLEAN NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NULL,
  consumer_notes VARCHAR(20000) NULL,
  rejection_reason VARCHAR(20000) NULL,
  suspended_at TIMESTAMP NULL,

  contract_id CHAR(36) NULL,
  contract_name VARCHAR(1024) NULL,
  contract_pretty_name VARCHAR(1024) NULL,
  contract_content_type VARCHAR(1024) NULL,
  contract_path VARCHAR(1024) NULL,
  contract_created_at TIMESTAMP NULL,

  submission_who CHAR(36) NULL,
  submission_when TIMESTAMP NULL,
  activation_who CHAR(36) NULL,
  activation_when TIMESTAMP NULL,
  rejection_who CHAR(36) NULL,
  rejection_when TIMESTAMP NULL,
  suspension_by_producer_who CHAR(36) NULL,
  suspension_by_producer_when TIMESTAMP NULL,
  suspension_by_consumer_who CHAR(36) NULL,
  suspension_by_consumer_when TIMESTAMP NULL,
  upgrade_who CHAR(36) NULL,
  upgrade_when TIMESTAMP NULL,
  archiving_who CHAR(36) NULL,
  archiving_when TIMESTAMP NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.agreement_consumer_document
(
  id CHAR(36) PRIMARY KEY,
  name VARCHAR(1024) NOT NULL,
  pretty_name VARCHAR(1024) NOT NULL,
  content_type VARCHAR(1024) NOT NULL,
  path VARCHAR(1024) NOT NULL,
  created_at TIMESTAMP NOT NULL,

  agreement_id CHAR(36) NOT NULL REFERENCES domains.agreement (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.agreement_attribute
(
  agreement_id CHAR(36) NOT NULL REFERENCES domains.agreement (id),
  attribute_id CHAR(36) NOT NULL REFERENCES domains.attribute (id),
  attribute_type VARCHAR(32) NOT NULL -- certified, declared or verified
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;
