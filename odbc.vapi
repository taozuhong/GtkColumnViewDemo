[CCode (cheader_filename = "sql.h,sqlext.h")]
namespace ODBC {
    [CCode (cname = "ODBCVER")]
    public const int VER;
    [CCode (cname = "SQL_NULL_DATA")]
	public const int NULL_DATA;
    [CCode (cname = "SQL_DATA_AT_EXEC")]
	public const int DATA_AT_EXEC;
    [CCode (cname = "SQL_SUCCESS")]
	public const int SUCCESS;
    [CCode (cname = "SQL_SUCCESS_WITH_INFO")]
	public const int SUCCESS_WITH_INFO;
    [CCode (cname = "SQL_NO_DATA")]
	public const int NO_DATA;
    [CCode (cname = "SQL_ERROR")]
	public const int ERROR;
    [CCode (cname = "SQL_INVALID_HANDLE")]
	public const int INVALID_HANDLE;

    [CCode (cname = "SQL_STILL_EXECUTING")]
	public const int STILL_EXECUTING;
    [CCode (cname = "SQL_NEED_DATA")]
	public const int NEED_DATA;
    [CCode (cname = "SQL_PARAM_DATA_AVAILABLE")]
	public const int PARAM_DATA_AVAILABLE;
    [CCode (cname = "SQL_NTS")]
	public const int NTS;
    [CCode (cname = "SQL_NTSL")]
	public const int NTSL;
    [CCode (cname = "SQL_MAX_MESSAGE_LENGTH")]
	public const int MAX_MESSAGE_LENGTH;
    [CCode (cname = "SQL_DATE_LEN")]
	public const int DATE_LEN;

    [CCode (cname = "SQL_TIME_LEN")]
	public const int TIME_LEN;
    [CCode (cname = "SQL_TIMESTAMP_LEN")]
	public const int TIMESTAMP_LEN;

    [CCode (cname = "SQLRETURN")]
    public const int RETURN;

    /*
     * Cursor behaviour
     */
    [CCode (cname = "SQL_CURSOR_FORWARD_ONLY")]
    public const int CURSOR_FORWARD_ONLY;
    [CCode (cname = "SQL_CURSOR_KEYSET_DRIVEN")]
    public const int CURSOR_KEYSET_DRIVEN;
    [CCode (cname = "SQL_CURSOR_DYNAMIC")]
    public const int CURSOR_DYNAMIC;
    [CCode (cname = "SQL_CURSOR_STATIC")]
    public const int CURSOR_STATIC;

    /*
     * Concurrency (transactions)
     */
    [CCode (cname = "SQL_CONCUR_READ_ONLY")]
    public const int CONCUR_READ_ONLY;
    [CCode (cname = "SQL_CONCUR_LOCK")]
    public const int CONCUR_LOCK;
    [CCode (cname = "SQL_CONCUR_ROWVER")]
    public const int CONCUR_ROWVER;
    [CCode (cname = "SQL_CONCUR_VALUES")]
    public const int CONCUR_VALUES;

    /*
     * Fetch direction
     */
    [CCode (cname = "SQL_FETCH_NEXT")]
    public const int FETCH_NEXT;
    [CCode (cname = "SQL_FETCH_FIRST")]
    public const int FETCH_FIRST;
    [CCode (cname = "SQL_FETCH_LAST")]
    public const int FETCH_LAST;
    [CCode (cname = "SQL_FETCH_PRIOR")]
    public const int FETCH_PRIOR;
    [CCode (cname = "SQL_FETCH_ABSOLUTE")]
    public const int FETCH_ABSOLUTE;
    [CCode (cname = "SQL_FETCH_RELATIVE")]
    public const int FETCH_RELATIVE;

    /*
     * Data types
     */
    [CCode (cname = "SQL_UNKNOWN_TYPE")]
    public const int UNKNOWN_TYPE;
    [CCode (cname = "SQL_CHAR")]
    public const int CHAR;
    [CCode (cname = "SQL_NUMERIC")]
    public const int NUMERIC;
    [CCode (cname = "SQL_DECIMAL")]
    public const int DECIMAL;
    [CCode (cname = "SQL_INTEGER")]
    public const int INTEGER;
    [CCode (cname = "SQL_SMALLINT")]
    public const int SMALLINT;
    [CCode (cname = "SQL_FLOAT")]
    public const int FLOAT;
    [CCode (cname = "SQL_REAL")]
    public const int REAL;
    [CCode (cname = "SQL_DOUBLE")]
    public const int DOUBLE;
    [CCode (cname = "SQL_VARCHAR")]
    public const int VARCHAR;
    [CCode (cname = "SQL_DATETIME")]
    public const int DATETIME;
    [CCode (cname = "SQL_DATE")]
    public const int DATE;
    [CCode (cname = "SQL_TYPE_DATE")]
    public const int TYPE_DATE;
    [CCode (cname = "SQL_TIME")]
    public const int TIME;
    [CCode (cname = "SQL_TYPE_TIME")]
    public const int TYPE_TIME;
    [CCode (cname = "SQL_TIMESTAMP")]
    public const int TIMESTAMP;
    [CCode (cname = "SQL_TYPE_TIMESTAMP")]
    public const int TYPE_TIMESTAMP;
    [CCode (cname = "SQL_LONGVARCHAR")]
    public const int LONGVARCHAR;
    [CCode (cname = "SQL_BINARY")]
    public const int BINARY;
    [CCode (cname = "SQL_VARBINARY")]
    public const int VARBINARY;
    [CCode (cname = "SQL_LONGVARBINARY")]
    public const int LONGVARBINARY;
    [CCode (cname = "SQL_BIGINT")]
    public const int BIGINT;
    [CCode (cname = "SQL_TINYINT")]
    public const int TINYINT;
    [CCode (cname = "SQL_BIT")]
    public const int BIT;
    [CCode (cname = "SQL_GUID")]
    public const int GUID;

    /*
     * Parameter related
     */
    [CCode (cname = "SQL_PARAM_TYPE_UNKNOWN")]
    public const int PARAM_TYPE_UNKNOWN;
    [CCode (cname = "SQL_PARAM_INPUT")]
    public const int PARAM_INPUT;
    [CCode (cname = "SQL_PARAM_OUTPUT")]
    public const int PARAM_OUTPUT;
    [CCode (cname = "SQL_PARAM_INPUT_OUTPUT")]
    public const int PARAM_INPUT_OUTPUT;
    [CCode (cname = "SQL_DEFAULT_PARAM")]
    public const int DEFAULT_PARAM; 
    [CCode (cname = "SQL_RETURN_VALUE")]
    public const int RETURN_VALUE;

    /*
     * Procedure related
     */
    [CCode (cname = "SQL_RESULT_COL")]
    public const int RESULT_COL;
    [CCode (cname = "SQL_PT_UNKNOWN")]
    public const int PT_UNKNOWN;
    [CCode (cname = "SQL_PT_PROCEDURE")]
    public const int PT_PROCEDURE;
    [CCode (cname = "SQL_PT_FUNCTION")]
    public const int PT_FUNCTION;

    /*
     * Environment attributes
     */
    [CCode (cname = "SQL_CP_OFF")]
    public const int CP_OFF;
    [CCode (cname = "SQL_CP_ONE_PER_DRIVER")]
    public const int CP_ONE_PER_DRIVER;
    [CCode (cname = "SQL_CP_ONE_PER_HENV")]
    public const int CP_ONE_PER_HENV;
    [CCode (cname = "SQL_CP_DEFAULT")]
    public const int CP_DEFAULT;
    [CCode (cname = "SQL_CP_STRICT_MATCH")]
    public const int CP_STRICT_MATCH;
    [CCode (cname = "SQL_CP_RELAXED_MATCH")]
    public const int CP_RELAXED_MATCH;
    [CCode (cname = "SQL_CP_MATCH_DEFAULT")]
    public const int CP_MATCH_DEFAULT;
    [CCode (cname = "SQL_OV_ODBC2")]
    public const int OV_ODBC2;
    [CCode (cname = "SQL_OV_ODBC3")]
    public const int OV_ODBC3;

    /*
     * Info types for ODBC::Database.get_info yielding integer results
     */
    [CCode (cname = "SQL_ACTIVE_ENVIRONMENTS")]
    public const int ACTIVE_ENVIRONMENTS;
    [CCode (cname = "SQL_ACTIVE_CONNECTIONS")]
    public const int ACTIVE_CONNECTIONS;
    [CCode (cname = "SQL_ACTIVE_STATEMENTS")]
    public const int ACTIVE_STATEMENTS;
    [CCode (cname = "SQL_ASYNC_MODE")]
    public const int ASYNC_MODE;
    [CCode (cname = "SQL_CATALOG_LOCATION")]
    public const int CATALOG_LOCATION;
    [CCode (cname = "SQL_CONCAT_NULL_BEHAVIOR")]
    public const int CONCAT_NULL_BEHAVIOR;
    [CCode (cname = "SQL_CORRELATION_NAME")]
    public const int CORRELATION_NAME;
    [CCode (cname = "SQL_CURSOR_COMMIT_BEHAVIOR")]
    public const int CURSOR_COMMIT_BEHAVIOR;
    [CCode (cname = "SQL_CURSOR_ROLLBACK_BEHAVIOR")]
    public const int CURSOR_ROLLBACK_BEHAVIOR;
    [CCode (cname = "SQL_CURSOR_SENSITIVITY")]
    public const int CURSOR_SENSITIVITY;
    [CCode (cname = "SQL_DDL_INDEX")]
    public const int DDL_INDEX;
    [CCode (cname = "SQL_DEFAULT_TXN_ISOLATION")]
    public const int DEFAULT_TXN_ISOLATION;
    [CCode (cname = "SQL_DRIVER_HDBC")]
    public const int DRIVER_HDBC;
    [CCode (cname = "SQL_DRIVER_HENV")]
    public const int DRIVER_HENV;
    [CCode (cname = "SQL_DRIVER_HDESC")]
    public const int DRIVER_HDESC;
    [CCode (cname = "SQL_DRIVER_HLIB")]
    public const int DRIVER_HLIB;
    [CCode (cname = "SQL_DRIVER_HSTMT")]
    public const int DRIVER_HSTMT;
    [CCode (cname = "SQL_FILE_USAGE")]
    public const int FILE_USAGE;
    [CCode (cname = "SQL_GROUP_BY")]
    public const int GROUP_BY;
    [CCode (cname = "SQL_IDENTIFIER_CASE")]
    public const int IDENTIFIER_CASE;
    [CCode (cname = "SQL_MAX_ASYNC_CONCURRENT_STATEMENTS")]
    public const int MAX_ASYNC_CONCURRENT_STATEMENTS;
    [CCode (cname = "SQL_MAX_BINARY_LITERAL_LEN")]
    public const int MAX_BINARY_LITERAL_LEN;
    [CCode (cname = "SQL_MAX_CATALOG_NAME_LEN")]
    public const int MAX_CATALOG_NAME_LEN;
    [CCode (cname = "SQL_MAX_CHAR_LITERAL_LEN")]
    public const int MAX_CHAR_LITERAL_LEN;
    [CCode (cname = "SQL_MAX_COLUMN_NAME_LEN")]
    public const int MAX_COLUMN_NAME_LEN;
    [CCode (cname = "SQL_MAX_COLUMNS_IN_GROUP_BY")]
    public const int MAX_COLUMNS_IN_GROUP_BY;
    [CCode (cname = "SQL_MAX_COLUMNS_IN_INDEX")]
    public const int MAX_COLUMNS_IN_INDEX;
    [CCode (cname = "SQL_MAX_COLUMNS_IN_ORDER_BY")]
    public const int MAX_COLUMNS_IN_ORDER_BY;
    [CCode (cname = "SQL_MAX_COLUMNS_IN_SELECT")]
    public const int MAX_COLUMNS_IN_SELECT;
    [CCode (cname = "SQL_MAX_COLUMNS_IN_TABLE")]
    public const int MAX_COLUMNS_IN_TABLE;
    [CCode (cname = "SQL_MAX_CONCURRENT_ACTIVITIES")]
    public const int MAX_CONCURRENT_ACTIVITIES;
    [CCode (cname = "SQL_MAX_CURSOR_NAME_LEN")]
    public const int MAX_CURSOR_NAME_LEN;
    [CCode (cname = "SQL_MAX_DRIVER_CONNECTIONS")]
    public const int MAX_DRIVER_CONNECTIONS;
    [CCode (cname = "SQL_MAX_IDENTIFIER_LEN")]
    public const int MAX_IDENTIFIER_LEN;
    [CCode (cname = "SQL_MAX_INDEX_SIZE")]
    public const int MAX_INDEX_SIZE;
    [CCode (cname = "SQL_MAX_OWNER_NAME_LEN")]
    public const int MAX_OWNER_NAME_LEN;
    [CCode (cname = "SQL_MAX_PROCEDURE_NAME_LEN")]
    public const int MAX_PROCEDURE_NAME_LEN;
    [CCode (cname = "SQL_MAX_QUALIFIER_NAME_LEN")]
    public const int MAX_QUALIFIER_NAME_LEN;
    [CCode (cname = "SQL_MAX_ROW_SIZE")]
    public const int MAX_ROW_SIZE;
    [CCode (cname = "SQL_MAX_SCHEMA_NAME_LEN")]
    public const int MAX_SCHEMA_NAME_LEN;
    [CCode (cname = "SQL_MAX_STATEMENT_LEN")]
    public const int MAX_STATEMENT_LEN;
    [CCode (cname = "SQL_MAX_TABLE_NAME_LEN")]
    public const int MAX_TABLE_NAME_LEN;
    [CCode (cname = "SQL_MAX_TABLES_IN_SELECT")]
    public const int MAX_TABLES_IN_SELECT;
    [CCode (cname = "SQL_MAX_USER_NAME_LEN")]
    public const int MAX_USER_NAME_LEN;
    [CCode (cname = "SQL_NON_NULLABLE_COLUMNS")]
    public const int NON_NULLABLE_COLUMNS;
    [CCode (cname = "SQL_NULL_COLLATION")]
    public const int NULL_COLLATION;
    [CCode (cname = "SQL_ODBC_API_CONFORMANCE")]
    public const int ODBC_API_CONFORMANCE;
    [CCode (cname = "SQL_ODBC_INTERFACE_CONFORMANCE")]
    public const int ODBC_INTERFACE_CONFORMANCE;
    [CCode (cname = "SQL_ODBC_SAG_CLI_CONFORMANCE")]
    public const int ODBC_SAG_CLI_CONFORMANCE;
    [CCode (cname = "SQL_ODBC_SQL_CONFORMANCE")]
    public const int ODBC_SQL_CONFORMANCE;
    [CCode (cname = "SQL_PARAM_ARRAY_ROW_COUNTS")]
    public const int PARAM_ARRAY_ROW_COUNTS;
    [CCode (cname = "SQL_PARAM_ARRAY_SELECTS")]
    public const int PARAM_ARRAY_SELECTS;
    [CCode (cname = "SQL_QUALIFIER_LOCATION")]
    public const int QUALIFIER_LOCATION;
    [CCode (cname = "SQL_QUOTED_IDENTIFIER_CASE")]
    public const int QUOTED_IDENTIFIER_CASE;
    [CCode (cname = "SQL_SQL_CONFORMANCE")]
    public const int SQL_CONFORMANCE;
    [CCode (cname = "SQL_TXN_CAPABLE")]
    public const int TXN_CAPABLE;
    
    /*
     * Info types for ODBC::Database.get_info yielding bitmasks (integer results):
     */
    [CCode (cname = "SQL_AGGREGATE_FUNCTIONS")]
    public const int AGGREGATE_FUNCTIONS;
    [CCode (cname = "SQL_ALTER_DOMAIN")]
    public const int ALTER_DOMAIN;
    [CCode (cname = "SQL_ALTER_TABLE")]
    public const int ALTER_TABLE;
    [CCode (cname = "SQL_BATCH_ROW_COUNT")]
    public const int BATCH_ROW_COUNT;
    [CCode (cname = "SQL_BATCH_SUPPORT")]
    public const int BATCH_SUPPORT;
    [CCode (cname = "SQL_BOOKMARK_PERSISTENCE")]
    public const int BOOKMARK_PERSISTENCE;
    [CCode (cname = "SQL_CATALOG_USAGE")]
    public const int CATALOG_USAGE;
    [CCode (cname = "SQL_CONVERT_BINARY")]
    public const int CONVERT_BINARY;
    [CCode (cname = "SQL_CONVERT_BIT")]
    public const int CONVERT_BIT;
    [CCode (cname = "SQL_CONVERT_CHAR")]
    public const int CONVERT_CHAR;
    [CCode (cname = "SQL_CONVERT_GUID")]
    public const int CONVERT_GUID;
    [CCode (cname = "SQL_CONVERT_DATE")]
    public const int CONVERT_DATE;
    [CCode (cname = "SQL_CONVERT_DECIMAL")]
    public const int CONVERT_DECIMAL;
    [CCode (cname = "SQL_CONVERT_DOUBLE")]
    public const int CONVERT_DOUBLE;
    [CCode (cname = "SQL_CONVERT_FLOAT")]
    public const int CONVERT_FLOAT;
    [CCode (cname = "SQL_CONVERT_FUNCTIONS")]
    public const int CONVERT_FUNCTIONS;
    [CCode (cname = "SQL_CONVERT_INTEGER")]
    public const int CONVERT_INTEGER;
    [CCode (cname = "SQL_CONVERT_INTERVAL_YEAR_MONTH")]
    public const int CONVERT_INTERVAL_YEAR_MONTH;
    [CCode (cname = "SQL_CONVERT_INTERVAL_DAY_TIME")]
    public const int CONVERT_INTERVAL_DAY_TIME;
    [CCode (cname = "SQL_CONVERT_LONGVARBINARY")]
    public const int CONVERT_LONGVARBINARY;
    [CCode (cname = "SQL_CONVERT_LONGVARCHAR")]
    public const int CONVERT_LONGVARCHAR;
    [CCode (cname = "SQL_CONVERT_NUMERIC")]
    public const int CONVERT_NUMERIC;
    [CCode (cname = "SQL_CONVERT_REAL")]
    public const int CONVERT_REAL;
    [CCode (cname = "SQL_CONVERT_SMALLINT")]
    public const int CONVERT_SMALLINT;
    [CCode (cname = "SQL_CONVERT_TIME")]
    public const int CONVERT_TIME;
    [CCode (cname = "SQL_CONVERT_TIMESTAMP")]
    public const int CONVERT_TIMESTAMP;
    [CCode (cname = "SQL_CONVERT_TINYINT")]
    public const int CONVERT_TINYINT;
    [CCode (cname = "SQL_CONVERT_VARBINARY")]
    public const int CONVERT_VARBINARY;
    [CCode (cname = "SQL_CONVERT_VARCHAR")]
    public const int CONVERT_VARCHAR;
    [CCode (cname = "SQL_CONVERT_WCHAR")]
    public const int CONVERT_WCHAR;
    [CCode (cname = "SQL_CONVERT_WLONGVARCHAR")]
    public const int CONVERT_WLONGVARCHAR;
    [CCode (cname = "SQL_CONVERT_WVARCHAR")]
    public const int CONVERT_WVARCHAR;
    [CCode (cname = "SQL_CREATE_ASSERTION")]
    public const int CREATE_ASSERTION;
    [CCode (cname = "SQL_CREATE_CHARACTER_SET")]
    public const int CREATE_CHARACTER_SET;
    [CCode (cname = "SQL_CREATE_COLLATION")]
    public const int CREATE_COLLATION;
    [CCode (cname = "SQL_CREATE_DOMAIN")]
    public const int CREATE_DOMAIN;
    [CCode (cname = "SQL_CREATE_SCHEMA")]
    public const int CREATE_SCHEMA;
    [CCode (cname = "SQL_CREATE_TABLE")]
    public const int CREATE_TABLE;
    [CCode (cname = "SQL_CREATE_TRANSLATION")]
    public const int CREATE_TRANSLATION;
    [CCode (cname = "SQL_CREATE_VIEW")]
    public const int CREATE_VIEW;
    [CCode (cname = "SQL_DATETIME_LITERALS")]
    public const int DATETIME_LITERALS;
    [CCode (cname = "SQL_DROP_ASSERTION")]
    public const int DROP_ASSERTION;
    [CCode (cname = "SQL_DROP_CHARACTER_SET")]
    public const int DROP_CHARACTER_SET;
    [CCode (cname = "SQL_DROP_COLLATION")]
    public const int DROP_COLLATION;
    [CCode (cname = "SQL_DROP_DOMAIN")]
    public const int DROP_DOMAIN;
    [CCode (cname = "SQL_DROP_SCHEMA")]
    public const int DROP_SCHEMA;
    [CCode (cname = "SQL_DROP_TABLE")]
    public const int DROP_TABLE;
    [CCode (cname = "SQL_DROP_TRANSLATION")]
    public const int DROP_TRANSLATION;
    [CCode (cname = "SQL_DROP_VIEW")]
    public const int DROP_VIEW;
    [CCode (cname = "SQL_DTC_TRANSITION_COST")]
    public const int DTC_TRANSITION_COST;
    [CCode (cname = "SQL_DYNAMIC_CURSOR_ATTRIBUTES1")]
    public const int DYNAMIC_CURSOR_ATTRIBUTES1;
    [CCode (cname = "SQL_DYNAMIC_CURSOR_ATTRIBUTES2")]
    public const int DYNAMIC_CURSOR_ATTRIBUTES2;
    [CCode (cname = "SQL_FETCH_DIRECTION")]
    public const int FETCH_DIRECTION;
    [CCode (cname = "SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1")]
    public const int FORWARD_ONLY_CURSOR_ATTRIBUTES1;
    [CCode (cname = "SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2")]
    public const int FORWARD_ONLY_CURSOR_ATTRIBUTES2;
    [CCode (cname = "SQL_GETDATA_EXTENSIONS")]
    public const int GETDATA_EXTENSIONS;
    [CCode (cname = "SQL_KEYSET_CURSOR_ATTRIBUTES1")]
    public const int KEYSET_CURSOR_ATTRIBUTES1;
    [CCode (cname = "SQL_KEYSET_CURSOR_ATTRIBUTES2")]
    public const int KEYSET_CURSOR_ATTRIBUTES2;
    [CCode (cname = "SQL_INDEX_KEYWORDS")]
    public const int INDEX_KEYWORDS;
    [CCode (cname = "SQL_INFO_SCHEMA_VIEWS")]
    public const int INFO_SCHEMA_VIEWS;
    [CCode (cname = "SQL_INSERT_STATEMENT")]
    public const int INSERT_STATEMENT;
    [CCode (cname = "SQL_LOCK_TYPES")]
    public const int LOCK_TYPES;
    [CCode (cname = "SQL_NUMERIC_FUNCTIONS")]
    public const int NUMERIC_FUNCTIONS;
    [CCode (cname = "SQL_OJ_CAPABILITIES")]
    public const int OJ_CAPABILITIES;
    [CCode (cname = "SQL_OWNER_USAGE")]
    public const int OWNER_USAGE;
    [CCode (cname = "SQL_POS_OPERATIONS")]
    public const int POS_OPERATIONS;
    [CCode (cname = "SQL_POSITIONED_STATEMENTS")]
    public const int POSITIONED_STATEMENTS;
    [CCode (cname = "SQL_QUALIFIER_USAGE")]
    public const int QUALIFIER_USAGE;
    [CCode (cname = "SQL_SCHEMA_USAGE")]
    public const int SCHEMA_USAGE;
    [CCode (cname = "SQL_SCROLL_CONCURRENCY")]
    public const int SCROLL_CONCURRENCY;
    [CCode (cname = "SQL_SCROLL_OPTIONS")]
    public const int SCROLL_OPTIONS;
    [CCode (cname = "SQL_SQL92_DATETIME_FUNCTIONS")]
    public const int SQL92_DATETIME_FUNCTIONS;
    [CCode (cname = "SQL_SQL92_FOREIGN_KEY_DELETE_RULE")]
    public const int SQL92_FOREIGN_KEY_DELETE_RULE;
    [CCode (cname = "SQL_SQL92_FOREIGN_KEY_UPDATE_RULE")]
    public const int SQL92_FOREIGN_KEY_UPDATE_RULE;
    [CCode (cname = "SQL_SQL92_GRANT")]
    public const int SQL92_GRANT;
    [CCode (cname = "SQL_SQL92_NUMERIC_VALUE_FUNCTIONS")]
    public const int SQL92_NUMERIC_VALUE_FUNCTIONS;
    [CCode (cname = "SQL_SQL92_PREDICATES")]
    public const int SQL92_PREDICATES;
    [CCode (cname = "SQL_SQL92_RELATIONAL_JOIN_OPERATORS")]
    public const int SQL92_RELATIONAL_JOIN_OPERATORS;
    [CCode (cname = "SQL_SQL92_REVOKE")]
    public const int SQL92_REVOKE;
    [CCode (cname = "SQL_SQL92_ROW_VALUE_CONSTRUCTOR")]
    public const int SQL92_ROW_VALUE_CONSTRUCTOR;
    [CCode (cname = "SQL_SQL92_STRING_FUNCTIONS")]
    public const int SQL92_STRING_FUNCTIONS;
    [CCode (cname = "SQL_SQL92_VALUE_EXPRESSIONS")]
    public const int SQL92_VALUE_EXPRESSIONS;
    [CCode (cname = "SQL_STANDARD_CLI_CONFORMANCE")]
    public const int STANDARD_CLI_CONFORMANCE;
    [CCode (cname = "SQL_STATIC_CURSOR_ATTRIBUTES1")]
    public const int STATIC_CURSOR_ATTRIBUTES1;
    [CCode (cname = "SQL_STATIC_CURSOR_ATTRIBUTES2")]
    public const int STATIC_CURSOR_ATTRIBUTES2;
    [CCode (cname = "SQL_STATIC_SENSITIVITY")]
    public const int STATIC_SENSITIVITY;
    [CCode (cname = "SQL_STRING_FUNCTIONS")]
    public const int STRING_FUNCTIONS;
    [CCode (cname = "SQL_SUBQUERIES")]
    public const int SUBQUERIES;
    [CCode (cname = "SQL_SYSTEM_FUNCTIONS")]
    public const int SYSTEM_FUNCTIONS;
    [CCode (cname = "SQL_TIMEDATE_ADD_INTERVALS")]
    public const int TIMEDATE_ADD_INTERVALS;
    [CCode (cname = "SQL_TIMEDATE_DIFF_INTERVALS")]
    public const int TIMEDATE_DIFF_INTERVALS;
    [CCode (cname = "SQL_TIMEDATE_FUNCTIONS")]
    public const int TIMEDATE_FUNCTIONS;
    [CCode (cname = "SQL_TXN_ISOLATION_OPTION")]
    public const int TXN_ISOLATION_OPTION;
    [CCode (cname = "SQL_UNION")]
    public const int UNION;
     
    /*
     * Info types for ODBC::Database.get_info yielding strings:
     */
    [CCode (cname = "SQL_ACCESSIBLE_PROCEDURES")]
    public const int ACCESSIBLE_PROCEDURES;
    [CCode (cname = "SQL_ACCESSIBLE_TABLES")]
    public const int ACCESSIBLE_TABLES;
    [CCode (cname = "SQL_CATALOG_NAME")]
    public const int CATALOG_NAME;
    [CCode (cname = "SQL_CATALOG_NAME_SEPARATOR")]
    public const int CATALOG_NAME_SEPARATOR;
    [CCode (cname = "SQL_CATALOG_TERM")]
    public const int CATALOG_TERM;
    [CCode (cname = "SQL_COLLATION_SEQ")]
    public const int COLLATION_SEQ;
    [CCode (cname = "SQL_COLUMN_ALIAS")]
    public const int COLUMN_ALIAS;
    [CCode (cname = "SQL_DATA_SOURCE_NAME")]
    public const int DATA_SOURCE_NAME;
    [CCode (cname = "SQL_DATA_SOURCE_READ_ONLY")]
    public const int DATA_SOURCE_READ_ONLY;
    [CCode (cname = "SQL_DATABASE_NAME")]
    public const int DATABASE_NAME;
    [CCode (cname = "SQL_DBMS_NAME")]
    public const int DBMS_NAME;
    [CCode (cname = "SQL_DBMS_VER")]
    public const int DBMS_VER;
    [CCode (cname = "SQL_DESCRIBE_PARAMETER")]
    public const int DESCRIBE_PARAMETER;
    [CCode (cname = "SQL_DM_VER")]
    public const int DM_VER;
    [CCode (cname = "SQL_DRIVER_NAME")]
    public const int DRIVER_NAME;
    [CCode (cname = "SQL_DRIVER_ODBC_VER")]
    public const int DRIVER_ODBC_VER;
    [CCode (cname = "SQL_DRIVER_VER")]
    public const int DRIVER_VER;
    [CCode (cname = "SQL_EXPRESSIONS_IN_ORDERBY")]
    public const int EXPRESSIONS_IN_ORDERBY;
    [CCode (cname = "SQL_IDENTIFIER_QUOTE_CHAR")]
    public const int IDENTIFIER_QUOTE_CHAR;
    [CCode (cname = "SQL_INTEGRITY")]
    public const int INTEGRITY;
    [CCode (cname = "SQL_KEYWORDS")]
    public const int KEYWORDS;
    [CCode (cname = "SQL_LIKE_ESCAPE_CLAUSE")]
    public const int LIKE_ESCAPE_CLAUSE;
    [CCode (cname = "SQL_MAX_ROW_SIZE_INCLUDES_LONG")]
    public const int MAX_ROW_SIZE_INCLUDES_LONG;
    [CCode (cname = "SQL_MULT_RESULT_SETS")]
    public const int MULT_RESULT_SETS;
    [CCode (cname = "SQL_MULTIPLE_ACTIVE_TXN")]
    public const int MULTIPLE_ACTIVE_TXN;
    [CCode (cname = "SQL_NEED_LONG_DATA_LEN")]
    public const int NEED_LONG_DATA_LEN;
    [CCode (cname = "SQL_ODBC_SQL_OPT_IEF")]
    public const int ODBC_SQL_OPT_IEF;
    [CCode (cname = "SQL_ODBC_VER")]
    public const int ODBC_VER;
    [CCode (cname = "SQL_ORDER_BY_COLUMNS_IN_SELECT")]
    public const int ORDER_BY_COLUMNS_IN_SELECT;
    [CCode (cname = "SQL_OUTER_JOINS")]
    public const int OUTER_JOINS;
    [CCode (cname = "SQL_OWNER_TERM")]
    public const int OWNER_TERM;
    [CCode (cname = "SQL_PROCEDURE_TERM")]
    public const int PROCEDURE_TERM;
    [CCode (cname = "SQL_PROCEDURES")]
    public const int PROCEDURES;
    [CCode (cname = "SQL_QUALIFIER_NAME_SEPARATOR")]
    public const int QUALIFIER_NAME_SEPARATOR;
    [CCode (cname = "SQL_QUALIFIER_TERM")]
    public const int QUALIFIER_TERM;
    [CCode (cname = "SQL_ROW_UPDATES")]
    public const int ROW_UPDATES;
    [CCode (cname = "SQL_SCHEMA_TERM")]
    public const int SCHEMA_TERM;
    [CCode (cname = "SQL_SEARCH_PATTERN_ESCAPE")]
    public const int SEARCH_PATTERN_ESCAPE;
    [CCode (cname = "SQL_SERVER_NAME")]
    public const int SERVER_NAME;
    [CCode (cname = "SQL_SPECIAL_CHARACTERS")]
    public const int SPECIAL_CHARACTERS;
    [CCode (cname = "SQL_TABLE_TERM")]
    public const int TABLE_TERM;
    [CCode (cname = "SQL_USER_NAME")]
    public const int USER_NAME;
    [CCode (cname = "SQL_XOPEN_CLI_YEAR")]
    public const int XOPEN_CLI_YEAR;
     
    /*
     * Options for yielding integers:
     *  ODBC::Database.get_option, 
     *  ODBC::Database.set_option, 
     *  ODBC::Statement.get_option, 
     *  ODBC::Statement.set_option
     */
    [CCode (cname = "SQL_AUTOCOMMIT")]
    public const int AUTOCOMMIT;
    [CCode (cname = "SQL_LOGIN_TIMEOUT")]
    public const int LOGIN_TIMEOUT;
    [CCode (cname = "SQL_CONCURRENCY")]
    public const int CONCURRENCY;
    [CCode (cname = "SQL_QUERY_TIMEOUT")]
    public const int QUERY_TIMEOUT;
    [CCode (cname = "SQL_MAX_ROWS")]
    public const int MAX_ROWS;
    [CCode (cname = "SQL_MAX_LENGTH")]
    public const int MAX_LENGTH;
    [CCode (cname = "SQL_NOSCAN")]
    public const int NOSCAN;
    [CCode (cname = "SQL_ROWSET_SIZE")]
    public const int ROWSET_SIZE;
    [CCode (cname = "SQL_CURSOR_TYPE")]
    public const int CURSOR_TYPE;

    [Compact]
    [CCode (free_function = "SQLFreeEnv", cname = "SQLHENV", cprefix = "SQL")]
    public class Environment {
        [CCode (cname = "SQLAllocEnv")]
		public static short AllocEnv (out Environment env);

        public short GetEnvAttr(int attribute, void * value, int buffer_length, out int string_length);
        public short SetEnvAttr(int attribute, void * value, int string_length);

        public short AllocConnect(out Connection connection);
        public short Transact(Connection connection, ushort completion_type);
        public short DataSources(
            ushort direction, char * server_name, 
            short buffer_length, out short name_length,
            char * description, short buffer_length2,
            out short name_length2);

        public short Error(
            Connection connection, Statement statement,
            string sql_state, out int native_error,
            GLib.StringBuilder message_text, short buffer_length,
            out short text_length);
    }

    [Compact]
    [CCode (free_function = "SQLFreeConnect", cname = "SQLHDBC", cprefix = "SQL")]
    public class Connection {
    //      public short connect();
    //      public short query();
    //      public short callProcedure();
    //      public short createStatement();
    //      public short tables();
    //      public short columns();
    //      public short setIsolationLevel();
    //      public short beginTransaction();
    //      public short commit();
    //      public short rollback();
    //      public short close();
    }

    //  [Compact]
    //      public class Pool {
    //      constructor: odbc.pool()
    //      public short connect()
    //      public short query()
    //      public short close()
    //  }
    
    [Compact]
    [CCode (free_function = "SQLFreeStmt", cname = "SQLHDBC", cprefix = "SQL")]
    public class Statement
    {
    //      public short prepare()
    //      public short bind()
    //      public short execute()
    //      public short close()
    }
    
    //  [Compact]
    //  public class Cursor
    //  {
    //      public short fetch()
    //      public short noData()
    //      public short close()
    //  }
}