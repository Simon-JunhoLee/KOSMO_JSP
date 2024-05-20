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

import model.AdminDAO;
import model.QueryVO;

/**
 * Servlet implementation class adminServlet
 */
@WebServlet(value={"/admin/order/list", "/admin/order/list.json", "/admin/order/update"})
public class adminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AdminDAO dao = new AdminDAO();
	Gson gson = new Gson();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();	
		
		switch(request.getServletPath()) {
		case "/admin/order/list":
			request.setAttribute("pageName", "/admin/orderManage.jsp");
			dis.forward(request, response);
			break;
			
		case "/admin/order/list.json":		// 테스트 : /admin/order/list.json?key=uid&word=young&page=1&size=3
			QueryVO query = new QueryVO();
			query.setKey(request.getParameter("key"));
			query.setWord(request.getParameter("word"));
			query.setPage(Integer.parseInt(request.getParameter("page")));
			query.setSize(Integer.parseInt(request.getParameter("size")));
			out.print(gson.toJson(dao.list(query)));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/admin/order/update":
			String pid = request.getParameter("pid");
			int status = Integer.parseInt(request.getParameter("status"));
			dao.update(pid, status);
			break;
		}
	}

}
