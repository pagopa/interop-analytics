# interop-analytics

## Tables
The lexicographic order of file names defines the order to be followed when creating the tables/views.

Rules of thumb when creating tables based on existing models:
- the table name is the name of the type in snake_case, e.g. `eservice_descriptor`
- the column name is the name of the attribute in snake_case, e.g. `eservice_id`
- nested objects are flatten in the main table using the attribute name as prefix for nested attributes, e.g. `contract_id`, `contract_path`. This rule does not apply in case of collections
- collections are modeled as different tables
- enums are converted as generic strings
- when possible, define constraints to help RedShift engine optimizing queries