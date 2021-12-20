[CCode (cheader_filename = "sql.h, sqlext.h")]
namespace ODBC {
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

    [CCode (cname = "int", cprefix = "SQL_", has_type_id = false)]
    public enum ResultCode {
        INVALID_HANDLE,
        ERROR,
        SUCCESS,
        SUCCESS_WITH_INFO,
        NEED_DATA,
        NO_DATA,
        PARAM_DATA_AVAILABLE
    }

    [CCode (cname = "int", cprefix = "SQL_HANDLE_", has_type_id = false)]
    public enum HandleType {
        ENV,
        DBC,
        STMT,
        DESC
    }

    [CCode (cname = "int", cprefix = "SQL_ATTR_", has_type_id = false)]
    public enum Attribute
    {

    }

    [CCode (cname = "SQL_SUCCEEDED")]
    public bool succeeded(int rc)
    {
        return (((rc) & (~1)) ==0);
    }

}