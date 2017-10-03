package util;

import java.util.Hashtable;

import utilities.QueryResponse;

public class MetiResponse {
	
	private boolean success;
	private String msg;
	private String javaMsg;
    private Hashtable ht;

    public static final String STATUS_OK = "0";
    public static final String STATUS_SESSION_ERROR = "1";
    public static final String STATUS_SWITCH_ERROR = "2";
    public static final String STATUS_INTERNAL_ERROR = "3";
    public static final String STATUS_FUNCTION_ERROR = "4";
    
    public MetiResponse() {
	    msg = null;
	    javaMsg = null;
	    success = true;
        ht = new Hashtable();
		status = STATUS_OK;
	}

	public MetiResponse(QueryResponse r) {
		msg = r.getMsg();
		javaMsg = r.getJavaMsg();
	    success = r.isSuccess();
        ht = r.getHt();
		status = r.getStatus();
	}

	private String status;

	public String getMsg() {
	    return msg;
	}

	public void setMsg(String msg) {
	    this.msg = msg;
	}

	public boolean isSuccess() {
	    return success;
	}

	public void setSuccess(boolean success) {
	    this.success = success;
	}

	public String getJavaMsg() {
	    return javaMsg;
	}

	public void setJavaMsg(String javaMsg) {
	    this.javaMsg = javaMsg;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public Hashtable getHt() {
		return ht;
	}
	
	public void removeElement(String key) {
		ht.remove(key);
	}
	
	public void addElement(String key, String value) {
		ht.put(key, value);
	}

}
