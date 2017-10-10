package services;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blayer.bl_login;
import util.ConnectionProvider;
import util.MetiResponse;
import util.SessionProvider;

public class HandlerServlet  extends HttpServlet{
	private SessionProvider SP;
	
	public void init() throws ServletException {
        SP = SessionProvider.getInstance(this.getServletContext());
    }

    public void destroy() {        
        ;
    }

    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		doGet(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 Hashtable pht = new Hashtable();
         try {
        	 
        	 req.setCharacterEncoding("UTF-8");
             Enumeration e = req.getParameterNames();
             while (e.hasMoreElements()) {
                 String key = (String) e.nextElement();
                 String val = req.getParameter(key);
                 if (val==null) log("---------------------------------------------------------- HandlerServlet------------- key="+key+" val="+val);
                 pht.put(key,val);
             }
             if(pht.containsKey("function")) {
            	 try {
                     if(!done_func_no_pwd(resp,pht)) {
                         if(checkpwd(pht)) {
                             done_functions(resp,pht);
                         }
                         else {
                             resp.setContentType("text/html; charset=UTF-8");
                             PrintWriter out = resp.getWriter();
                             out.println("<html>");
                             out.println("<head>");
                             out.println("<title>Info</title>");
                             out.println("</head>");
                             out.println("<body>");
                             out.println("<h1>Ervenytelen keres</h1>");
                             out.println("</body>");
                             out.println("</html>");
                         }
                     }
                 } catch (Exception ex) {
                     log("handlerservlet",ex);
                 }
             } else {
                 try {
                	 resp.setContentType("text/html; charset=UTF-8");
                     PrintWriter out = resp.getWriter();
                     out.println("<html>");
                     out.println("<head>");
                     out.println("<title>Login Info Version: "+SP.version+"</title>");
                     out.println("</head>");
                     out.println("<body>");
                     out.println("<h1>Bejelentkezett felhasználók:</h1>");
                     out.println(" Felhasznalok szama= "+SP.getSession_counter());
                     out.println("<br>"+"Servlet verzio: "+SP.version+"<br><br>"+SP.getshortInfo());

                     out.println("</body>");
                     out.println("</html>");
                 } catch (Exception ex) {
                     log("infoservlet",ex);
                 }
             }
         } catch (Exception e1) {
             log("HandlerServlet",e1);
         }
	}

	private boolean done_func_no_pwd(HttpServletResponse httpServletResponse, Hashtable pht) {
        String f = pht.get("function").toString();
        if("echo".equals(f)) {
            try {
                String s = pht.get("s").toString();
                log("++++++++++++++echo+++++++++++++++++++++++++++++++++");
                log(s);
                log("+++++++++++++++++++++++++++++++++++++++++++++++++++");
                httpServletResponse.setContentType("text/html; charset=UTF-8");
                PrintWriter out = httpServletResponse.getWriter();

                out.println(s);

                return true;
            } catch (IOException e) {
                log("done_func_no_pwd",e);
                
                return true;
            }
        }
        if (f.compareTo("getPdf") == 0){
            /*loadPdf((String)pht.get("docid"),httpServletResponse);*/
            return true;
        }
        if (f.compareTo("getHtml") == 0){
            /*loadHtml((String)pht.get("docid"),httpServletResponse);*/
            return true;
        }
        
        return false;
    }
	
	private boolean checkpwd(Hashtable pht) {
        try {
        	log(pht.toString());
            if(pht.containsKey("sessionid")) {
                String sessionid = pht.get("sessionid").toString();
                return SP.check_SID(sessionid);
            }
            String u = pht.get("u").toString();
            String p = pht.get("p").toString();
            ConnectionProvider PC = ConnectionProvider.getInstance(this.getServletContext());
            Long CID = new Long(PC.createConnection());
            Connection c = PC.getConnection(CID);
            boolean b =  new bl_login().check_u_p(c, u, p, pht);
            PC.closeConnection(CID);
            return b;
        } catch (Exception e) {
            log("chkpwd", e);
        }
        return false;
    }

	private void done_functions(HttpServletResponse httpServletResponse, Hashtable pht) {
        String f = pht.get("function").toString();
        if("login".equals(f)) {
            String u = pht.get("u").toString();
            done_login(httpServletResponse,pht);
            return;
        }
        if("robexegyenleg".equals(f)) {
            /*gen_robexegyenleg(httpServletResponse, pht);*/
            return;
        }        

    }
	
	private void done_login(HttpServletResponse httpServletResponse, Hashtable pht) {
        try {                        
            pht.put("sessioncounter", String.valueOf(SP.getSession_counter()));
            MetiResponse r = SP.startsession(pht);
            httpServletResponse.setContentType("text/html; charset=UTF-8");
            PrintWriter out = httpServletResponse.getWriter();
            out.println("OK "+r.getHt().get("sessionid"));
                      
        } catch (Exception e) {
            log("done error",e);            
        }
        return ;
    }
}
