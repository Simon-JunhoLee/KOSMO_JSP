package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.CommentDAOImpl;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet(value= {"/com/list.json"})
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommentDAOImpl dao = new CommentDAOImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/com/list.json":
			int page = request.getParameter("page") == null ? 1:Integer.parseInt(request.getParameter("page"));
			int size = request.getParameter("size") == null ? 10:Integer.parseInt(request.getParameter("size"));
			int bid = Integer.parseInt(request.getParameter("bid"));
			Gson gson = new Gson();
			
			out.print(gson.toJson(dao.list(bid, page, size)));
			
			break;
		
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
