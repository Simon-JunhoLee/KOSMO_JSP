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

import model.BBSDAOImpl;
import model.BBSVO;

/**
 * Servlet implementation class BBSServlet
 */
@WebServlet(value={"/bbs/list.json","/bbs/list", "/bbs/insert", "/bbs/read", "/bbs/delete", "/bbs/update", "/bbs/total"})
public class BBSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BBSDAOImpl dao = new BBSDAOImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/bbs/total":
			String query = request.getParameter("query");
			out.print(dao.page(query));
			break;
			
		case "/bbs/list":
			request.setAttribute("pageName", "/bbs/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/bbs/list.json":
			query = request.getParameter("query");
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(query)));
			break;
			
		case "/bbs/read":
			String bid = request.getParameter("bid");
			System.out.println("전달 받은 bid : "+bid);
			BBSVO vo = dao.read(Integer.parseInt(bid));
			request.setAttribute("bbs", vo);
			request.setAttribute("pageName", "/bbs/read.jsp");
			dis.forward(request, response);
			break;
			
		case "/bbs/insert":
			request.setAttribute("pageName", "/bbs/insert.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/bbs/insert":
			BBSVO vo = new BBSVO();
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			vo.setWriter(request.getParameter("writer"));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/bbs/list");
			break;
		}
	}

}
