package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;

import javax.servlet.ServletContext;

import utilities.prov_Connection;

public class ConnectionProvider {
	private static ConnectionProvider ourInstance;
	private ServletContext sc;
	private long connection_counter;
    private long connection_index;
    private Hashtable connections;
    private Properties properties;
    private String url;
    private int maxconndb;

	public synchronized static ConnectionProvider getInstance(ServletContext sc) {
        if (ourInstance == null) {
            ourInstance = new ConnectionProvider(sc);
        }
        return ourInstance;
    }
	
	private ConnectionProvider(ServletContext sc) {
		prov_Connection.getInstance(sc);
		this.sc = sc;
		try {
            Class.forName(sc.getInitParameter("driverclass"));

            connection_counter = 0;
            connection_index = 0;
            connections = new Hashtable();
            properties = new Properties();

            url = sc.getInitParameter("connectstring");   // "jdbc:postgresql://127.0.0.1/tesztbf"
            maxconndb = Integer.parseInt(sc.getInitParameter("maxconndb"));
            maxconndb = maxconndb < 2 ? 2 : maxconndb;
            properties.put("user", sc.getInitParameter("username"));
            properties.put("password", sc.getInitParameter("password"));
            properties.put("charSet", "UTF-8");
            return;
        } catch (ClassNotFoundException e) {
            sc.log("driver not found");
        } catch (Exception e) {
            sc.log("PC construct exception",e);
        }
	}
		
    public void end() {
        try {
            if (connection_counter != 0) {
                Enumeration e = connections.keys();
                while (e.hasMoreElements()) {
                    String key = (String) e.nextElement();
                    Connection o = (Connection) connections.get(key);
                    o.close();
                    connections.remove(key);
                    connection_counter--;
                }
            }
        } catch (Exception e) {
            sc.log("PC end hiba", e);
        }
    }

    public Connection getConnection(Long conn_id) throws Exception, Error {
        if (connections.containsKey(conn_id)) {
            return (Connection) connections.get(conn_id);
        }
        return null;
    }

    public synchronized long createConnection() throws Exception, Error {
        Connection connection;

        if (maxconndb <= connection_counter) throw new Exception("Connection db_number exceed maximum!");
        connection = tryConnection();
        if (connection == null)
            throw new Exception("Cannot connect to '" + url + "' database !");
        connection_counter++;
        connection_index++;
        connections.put(new Long(connection_index), connection);

        return connection_index;
    }

    private Connection tryConnection() throws Exception, Error {
        Connection connection = null;

        try {
            connection = DriverManager.getConnection(url, properties);
        } catch (Exception e) {
            sc.log(e.getMessage());
            throw new Exception("Cannot connect to '" + url + "' database !");
        }
        return connection;
    }

    public synchronized void closeConnection(Long conn_id) throws Exception, Error {
        if (connections.containsKey(conn_id)) {
            Connection connection = (Connection) connections.get(conn_id);
            connection.close();
            connections.remove(conn_id);
            connection_counter--;
        }
    }

    public ServletContext getSc() {
        return sc;
    }

    public long getConnection_counter() {
        return connection_counter;
    }

    public long getConnection_index() {
        return connection_index;
    }

    public String getUrl() {
        return url;
    }

    public int getMaxconndb() {
        return maxconndb;
    }
}
