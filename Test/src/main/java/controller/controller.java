package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bbs.SQLServer;

public class controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		test(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		test(request, response);
	}

	protected void test(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String context = request.getContextPath();
		String command = uri.substring(context.length());
		String site = null;
		
		switch(command) {
			case "/test" :
				SQLServer sql = new SQLServer();
			try {
				sql.getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
				site = "index.jsp";
				break;
		}



//		RequestDispatcher dispatcher = request.getRequestDispatcher(site);
//		dispatcher.forward(request, response);
	}
}
