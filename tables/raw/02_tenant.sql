CREATE TABLE IF NOT EXISTS domains.tenant
(
  id CHAR(36) PRIMARY KEY,
  kind VARCHAR(50) NULL,
  selfcare_id VARCHAR(100) NULL,
  external_id_origin VARCHAR(50) NOT NULL,
  external_id_value VARCHAR(50) NOT NULL,
  feature_certifier_id VARCHAR(50) NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NULL,
  name VARCHAR(1024) NOT NULL,
  onboarded_at TIMESTAMP NULL,
  sub_unit_type VARCHAR(20) NULL
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.tenant_mail
(
  id VARCHAR(128) PRIMARY KEY,
  kind VARCHAR(50) NOT NULL,
  address VARCHAR(320) NULL,
  description VARCHAR(512) NULL,
  created_at TIMESTAMP NOT NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

-- Attributes tables have been split to avoid confusion on revocation timestamp on verified attributes, 
-- but tables could be merged into one
CREATE TABLE IF NOT EXISTS domains.tenant_certified_attribute
(
  id CHAR(36) PRIMARY KEY,
  assignment_timestamp TIMESTAMP NOT NULL,
  revocation_timestamp TIMESTAMP NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.tenant_declared_attribute
(
  id CHAR(36) PRIMARY KEY,
  assignment_timestamp TIMESTAMP NOT NULL,
  revocation_timestamp TIMESTAMP NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.tenant_verified_attribute
(
  id CHAR(36) PRIMARY KEY,
  assignment_timestamp TIMESTAMP NOT NULL,
  revocation_timestamp TIMESTAMP NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.tenant_verified_attribute_vierifier
(
  id CHAR(36) PRIMARY KEY,
  verification_date TIMESTAMP NOT NULL,
  expiration_date TIMESTAMP NULL,
  extension_date TIMESTAMP NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;

CREATE TABLE IF NOT EXISTS domains.tenant_verified_attribute_revoker
(
  id CHAR(36) PRIMARY KEY,
  verification_date TIMESTAMP NOT NULL,
  expiration_date TIMESTAMP NULL,
  extension_date TIMESTAMP NULL,
  revokation_date TIMESTAMP NOT NULL,

  tenant_id CHAR(36) NOT NULL REFERENCES tenant (id)
)
BACKUP NO
DISTSTYLE AUTO SORTKEY AUTO ENCODE AUTO;
