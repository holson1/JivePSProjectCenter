package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	String msg = "";

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("\t<base> href=");
      out.print( Deploy.context );
      out.write(" </base> \n");
      out.write("\t<title>Project Center</title>\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"styles/login.css\">\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"styles/basic.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\t");

		//check for user login here
		if((session.getAttribute("uid")) != null)
			response.sendRedirect("/home/myprojects/");
	
      out.write("\n");
      out.write("\n");
      out.write("\t<div id=\"title\">\t\n");
      out.write("\t\t<h1>Jive PS Project Center</h1>\t\n");
      out.write("\t</div>\n");
      out.write("\n");
      out.write("\t<hr/>\n");
      out.write("\t<div id=\"content\">\t\n");
      out.write("\t\t<aside>\t\n");
      out.write("\t\t\t<h2>Sign up, it's simple!</h2>\n");
      out.write("\n");
      out.write("\t\t\t");

			//check for message
			if((msg = (String) session.getAttribute("reg_message")) != null) {
				session.removeAttribute("reg_message");
				out.println("<p class=\"err_msg\">" + msg + "</p>");
			}
			
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t<form action=\"/servlets/Register\" method=\"post\">\n");
      out.write("\t\t\t\t<label>Username:</label>\n");
      out.write("\t\t\t\t<input type=\"text\" name=\"new_un\">\n");
      out.write("\t\t\t\t<br/>\n");
      out.write("\t\t\t\t<label>Password:</label>\n");
      out.write("\t\t\t\t<input type=\"password\" name=\"new_pw\">\n");
      out.write("\t\t\t\t<br/>\n");
      out.write("\t\t\t\t<label>Re-enter:</label>\n");
      out.write("\t\t\t\t<input type=\"password\" name=\"re_pw\">\n");
      out.write("\t\t\t\t<br/>\n");
      out.write("\t\t\t\t<input type=\"submit\" class=\"submit\" value=\"Register >>\">\n");
      out.write("\t\t\t</form>\t\n");
      out.write("\t\t</aside>\n");
      out.write("\n");
      out.write("\t\t<div class=\"vr\">\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\t\t<div id=\"login\">\n");
      out.write("\t\t\t<h2>Login</h2>\n");
      out.write("\t\t\n");
      out.write("\t\t\t");

			//check for message
			if((msg = (String) session.getAttribute("message")) != null) {
				session.removeAttribute("message");
				out.println("<p class=\"err_msg\">" + msg + "</p>");
			}
			
      out.write("\n");
      out.write("\t\n");
      out.write("\t\t\t<form action=\"/servlets/Login\" method=\"post\">\n");
      out.write("\t\t\t\t<label>Username:</label>\n");
      out.write("\t\t\t\t<input type=\"text\" name=\"username\">\n");
      out.write("\t\t\t\t<br/>\n");
      out.write("\t\t\t\t<label>Password:</label>\n");
      out.write("\t\t\t\t<input type=\"password\" name=\"password\">\n");
      out.write("\t\t\t\t<br/>\n");
      out.write("\t\t\t\t<input type=\"submit\" class=\"submit\" value=\"Go >>\">\n");
      out.write("\t\t\t</form>\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\t</div>\n");
      out.write("\n");
      out.write("\t<hr/>\n");
      out.write("\n");
      out.write("\t<div id=\"footer\">\n");
      out.write("\t\t<p><i>Created by Henry Olson, 2014</i></p>\n");
      out.write("\t</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
