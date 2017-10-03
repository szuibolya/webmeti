package util;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Random;

import javax.servlet.ServletContext;

import blayer.bl_login;
import services.tools;
import utilities.QueryResponse;

public class SessionProvider {
	public static String version = "1.0";
	private static SessionProvider ourInstance;
	private ServletContext sc;
    private Hashtable<String, MetiSession> sessions;
    private long session_counter;
    private ConnectionProvider CP;
    private Connection ownconnection;
    private Long CID;
    private Random orandom, random;
    private byte[] a, b;
    private int al, bl;
    private long expiredinterval=0;
	
	public synchronized static SessionProvider getInstance(ServletContext sc) {
        if (ourInstance == null) {
            ourInstance = new SessionProvider(sc);
        }
        return ourInstance;
    }

    private SessionProvider(ServletContext sc) {
    	this.sc = sc;
    	sessions = new Hashtable();
        session_counter = 0;
        try {
            expiredinterval = Integer.parseInt(sc.getInitParameter("expiredinterval"));   //percben van megadva
       //sc.log("expiredinterval"+expiredinterval);
            expiredinterval *=(60*1000);
        } catch (Exception e) {
            expiredinterval = 8*60*60*1000; //8 óra
        }
        try {
            orandom = new Random();
            al = Integer.parseInt(sc.getInitParameter("key1len"));
            if (al < 2) al = 2;
            bl = Integer.parseInt(sc.getInitParameter("key2len"));
            if (bl < 2) bl = 2;
            a = new byte[al];
            b = new byte[bl];
            CP = ConnectionProvider.getInstance(sc);

            CID = new Long(CP.createConnection());
            ownconnection = CP.getConnection(CID);
            
        } catch (Exception e) {
            sc.log("cc hiba" + e.getMessage());
        } catch (Error error) {
            sc.log("cc error");
        }
        String jversion;
        try {
            jversion = System.getProperty("java.version");
        } catch (Exception e) {
            jversion = "Nem igy kell hivni";
        }
        jversion = jversion==null?"Empty":jversion;

        sc.log("Logistic module started! Version: "+version + "Servlet java version: " + jversion);
    }
    
    public long getSession_counter() {
        return session_counter;
    }
    
    public String getshortInfo() {
        String str = "<table border=\"1\" cellpadding=\"2\"><tr><td>Felhasznalo neve<td>Belepes datuma<td>Utolso aktivitas datuma<td>Nyelv<td>Utolso hiba<td>Utolso funkcio";
        Enumeration e = sessions.keys();

        while (e.hasMoreElements()) {
            String o = (String) e.nextElement();
            MetiSession s =  sessions.get(o);
            str = str + s.shortinfo();
        }
        str = str+"</table>";
        return str;
    }
    
    public synchronized boolean check_SID(String sessionid) {
        if (sessions.containsKey(sessionid)) return true;
        return false;
    }
    
    private String generateSID() {
        String s;
        do {
            orandom.nextBytes(a);
            random = new Random(orandom.nextLong());
            random.nextBytes(b);
            s = tools.toHexString(a) + tools.toHexString(b);
            if (s.length() != (al + bl) * 2) return null;
        } while (sessions.containsKey(s));

        return s;
    }    
    
    private synchronized MetiResponse useownconnection(int function, Hashtable parht) {
        QueryResponse r=null;
        parht.put("session_schema", "public");
        switch (function) {
            case 0:
                String username = (String) parht.get("u");
                String password = (String) parht.get("p");
                if (username.compareTo("rendszergazda") == 0) {          // todo ne konstans legyen
                    if (isanother(username)) {
                        r = new QueryResponse();
                        r.setMsg("alreadyyet_error");
                        r.setSuccess(false);
                        return new MetiResponse(r);
                    }
                }
                r = new bl_login().doLogin(ownconnection, username, password,parht);
                break;
            case 1:
                r = new bl_login().getlanginfo(ownconnection,parht);
                break;
            case 2:
                r = new bl_login().getlangcolname(ownconnection,parht);
                break;
        }
        return new MetiResponse(r);
    }
    
    private boolean isanother(String loginname) {
        Enumeration e = sessions.keys();
        while (e.hasMoreElements()) {
            String o = (String) e.nextElement();
            MetiSession s = sessions.get(o);
            if (s.loginname.compareTo(loginname)==0) return true;
        }
        return false;
    }
    
    public synchronized MetiResponse startsession(Hashtable parht) {
        // az ownconnection kereszt�l a parht alapj�n elmenni az adatb�zisba �s ellen�rizni a jelsz�t
        // ha sikeres akkor gener�lni egy sessionid-t �s meghat�rozni a userid-t
        MetiSession newsession;
        MetiResponse r = null, r2 =null;

        try {

            r = useownconnection(0,parht);

            if(r!=null) sc.log(r.getMsg()); else sc.log("r == null use 0");
            if (!r.isSuccess()) {
                return r;
            }
            String sessionid = generateSID();
            if (sessionid == null) throw new Exception("no sessionid");
            String s = r.getHt().get("userid").toString();
            newsession = new MetiSession(sessionid, Long.valueOf(s));
            newsession.fullname = (String)r.getHt().get("fullname");
            newsession.connid = new Long(CP.createConnection());
            newsession.loginname = (String)parht.get("loginfrm_usr_input");
            r2 = useownconnection(2,parht);
            newsession.lang = (String)r2.getHt().get("lang");
            newsession.timeformat = (String)r2.getHt().get("timeformat");
            newsession.dateformat = (String)r2.getHt().get("dateformat");
            newsession.javadateformat = (String)r2.getHt().get("javadateformat");
            newsession.datedelimiter = (String)r2.getHt().get("datedelimiter");
            newsession.langtitle = (String)r2.getHt().get("langtitle");
            r.removeElement("userid");
            session_counter++;
            sessions.put(sessionid, newsession);
            r.addElement("sessionid", sessionid);
            r.setStatus(MetiResponse.STATUS_OK);
        } catch (Exception e) {
            sc.log("SP hiba", e);
            r.setStatus(MetiResponse.STATUS_INTERNAL_ERROR);
        } catch (Error error) {
            sc.log("SP error", error);
            r.setStatus(MetiResponse.STATUS_INTERNAL_ERROR);
        }
        return r;
    }
    
    public MetiSession getSession(String sid) {
    	return sessions.get(sid);
    }

}
