package util;

import java.util.Calendar;
import java.util.Date;

public class MetiSession {
	public String sessionid;
    public String loginname;
    public String fullname;
    public String lang;
    public String timeformat;
    public String dateformat;
    public String javadateformat;
    public String datedelimiter;
    public String langtitle;
    public Long userid;
    public Long connid;
    public long startdate;
    public long stopdate;
    public long lastquerydate,lastquerydateend;
    public boolean lawsystemchg;
    public boolean forbidden;

    public boolean inserver;      
    public String lasterror;
    public String lastfuncname;

    public MetiSession(String sessionid, Long userid) {
        this.sessionid = sessionid;
        this.userid = userid;
        this.startdate = System.currentTimeMillis();
        this.stopdate = -1;
        this.lastquerydate = -1;
        this.lastquerydateend = -1;
        this.forbidden = false;
        this.inserver = false;
        this.lasterror = null;
        this.lang = null;
        timeformat=null;
    dateformat=null;
    javadateformat=null;
    datedelimiter=null;
    langtitle=null;
        this.loginname = null;
        this.fullname = null;
        this.lawsystemchg = false;
    }

    public String toString() {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(startdate);

        String s = "sessionid=" + sessionid + "  userid=" + userid + "  connid=" + connid +
                   "  startdate=" + startdate + " " + c.getTime() + " fullname="+fullname+
                " forbidden="+ forbidden+" lang="+lang+" loginname="+loginname+"<br>";
        return s;
    }

    public String shortinfo() {
        String s = "<tr><td>"+fullname+"<td>"+ new Date(startdate)+"<td>"+ new Date(lastquerydate)+"<td>"+langtitle+"<td>"+lasterror+"<td>"+lastfuncname;
        return s;
    }
}
