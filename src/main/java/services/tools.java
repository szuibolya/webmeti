package services;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Hashtable;
import java.util.Random;

import javax.swing.table.DefaultTableModel;

public class tools {
	public static Hashtable sessions = new Hashtable();
	
	public static String getlangselecttitle(String preflang) {
		if("hu".equals(preflang)) {
			return "Nyelv választás";
		}
		return "Choose language";
	}
	
	public static String createSessionid(int length) {
		String ret= "";
		Random r = new Random();
		int Low = 0;
		int High = 10;
		for(int i=0;i<length;i++) {
			int Result = r.nextInt(High-Low) + Low;
			ret+=Result;
		}
		sessions.put(ret, ret);
		return ret;		
	}
	
	public static String make_sha1(String in) {
        byte[] res;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA");
            md.update(in.getBytes());
            res = md.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();  
            return null;
        }
        return toHexString(res);
    }

    public static String make_md5(String in) {
        byte[] res;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(in.getBytes());
            res = md.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();  
            return null;
        }
        return toHexString(res);
    }

    public static String toHexString(byte[] array) {
            String str = "";
            try {
                DataInputStream is = new DataInputStream(new ByteArrayInputStream(array));
                int i;
                while( is.available() > 0 ) {
                    i = is.readUnsignedByte();
                    if ( i < 0x10 )
                        str += "0";
                    str += Integer.toHexString(i);
                }
            } catch (Exception e) {
                str = null;
            }
            return str.toLowerCase();
    }
    
    public static String treedtm2json(DefaultTableModel dtm) {
    	String ret="{'data':[";
    	for(int i=0;i<dtm.getRowCount();i++) {
    		ret+=("{"+P("id",(String)dtm.getValueAt(i, 1))+",");
    		ret+=(P("parent",T((String)dtm.getValueAt(i, 0)))+",");
    		if(true) {
    			ret+=(M("state")+" : {'opened' : true},");
    		}
    		ret+=(P("icon",I((String)dtm.getValueAt(i, 2)))+",");
    		ret+=(P("text",(String)dtm.getValueAt(i, 3))+"},");    		
    	}
    	ret+="]}";
    	return ret;    	
    }
    
    public static String T(String s) {
    	if("0".equals(s)) return "#";
    	return s;
    }
    
    public static String P(String k, String v) {
    	return M(k)+":"+M(v);
    }
    
    public static String M(String s) {
    	return "\""+s+"\"";
    }
    
    public static String I(String s) {
    	Hashtable iconht = new Hashtable();
    	iconht.put("orderin"   ,"glyphicon glyphicon-circle-arrow-right");
    	iconht.put("order"     ,"glyphicon glyphicon-circle-arrow-left");
    	iconht.put("mod16"     ,"glyphicon glyphicon-edit");
    	iconht.put("docok16"   ,"glyphicon glyphicon-ok");
    	iconht.put("final24"   ,"glyphicon glyphicon-share");
    	iconht.put("drop_new"  ,"glyphicon glyphicon-remove-sign");
    	iconht.put("finalnot24","glyphicon glyphicon-ban-circle");
    	iconht.put("drop16"    ,"glyphicon glyphicon-minus-sign");
    	iconht.put("okmini"    ,"glyphicon glyphicon-ok-sign");
    	iconht.put("matter"    ,"glyphicon glyphicon-th-large");
    	iconht.put("sample"    ,"glyphicon glyphicon-tag");
    	iconht.put("prodreturn","glyphicon glyphicon-transfer");
    	iconht.put("packreturn","glyphicon glyphicon-indent-right");
    	iconht.put("auto_blue" ,"glyphicon glyphicon-briefcase");
    	iconht.put("calendar"  ,"glyphicon glyphicon-calendar");
    	
    	Hashtable colorht = new Hashtable();
        colorht.put("orderin","orderincolor");
    	colorht.put("order","ordercolor");
    	colorht.put("mod16","mod16color");
    	colorht.put("docok16","docok16color");
    	colorht.put("final24","final24color");
    	colorht.put("drop_new","drop16color");
    	colorht.put("finalnot24","finalnot24color");
    	colorht.put("drop16","drop16color");
    	colorht.put("okmini","okminicolor");
    	colorht.put("matter","mattercolor");
    	colorht.put("sample","samplecolor");
    	colorht.put("prodreturn","prodreturncolor");
    	colorht.put("packreturn","packreturncolor");
    	colorht.put("auto_blue","auto_bluecolor");
    	colorht.put("calendar","calendarcolor");
    	
    	String ret =  (String)iconht.get(s)+" "+(String)colorht.get(s);
    	if(ret==null) ret = "";
    	return ret;
    }
        

}
