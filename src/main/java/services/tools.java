package services;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Hashtable;
import java.util.Random;

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

}
