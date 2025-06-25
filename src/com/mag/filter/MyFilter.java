package com.mag.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import java.io.IOException;

public class MyFilter implements Filter {

	String encoding;
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
						 FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		arg0.setCharacterEncoding(encoding);
		arg1.setCharacterEncoding(encoding);
		arg2.doFilter(arg0, arg1);

	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		encoding=arg0.getInitParameter("encoding");
	}

}
