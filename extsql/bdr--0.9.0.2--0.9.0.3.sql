-- Data structures for BDR's dynamic configuration management

SET LOCAL search_path = bdr;
SET bdr.permit_unsafe_ddl_commands = true;
SET bdr.skip_ddl_replication = true;

CREATE FUNCTION bdr.bdr_parse_slot_name(
    slot_name name,
    remote_sysid OUT text,
    remote_timeline OUT oid,
    remote_dboid OUT oid,
    local_dboid OUT oid,
    replication_name OUT name
)
RETURNS record
LANGUAGE c STRICT IMMUTABLE AS 'MODULE_PATHNAME','bdr_parse_slot_name_sql';

COMMENT ON FUNCTION bdr.bdr_parse_slot_name(name)
IS 'Parse a slot name from the bdr plugin and report the embedded field values';

CREATE FUNCTION bdr.bdr_format_slot_name(
    remote_sysid text,
    remote_timeline oid,
    remote_dboid oid,
    local_dboid oid,
    replication_name name DEFAULT ''
)
RETURNS name
LANGUAGE c STRICT IMMUTABLE AS 'MODULE_PATHNAME','bdr_format_slot_name_sql';

COMMENT ON FUNCTION bdr.bdr_format_slot_name(text, oid, oid, oid, name)
IS 'Format a BDR slot name from node identity parameters';

RESET bdr.permit_unsafe_ddl_commands;
RESET bdr.skip_ddl_replication;
RESET search_path;