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

import model.CouDAOImpl;
import model.CouVO;
import model.QueryVO;

/**
 * Servlet implementation class CoursesServlet
 */
@WebServlet(value= {"/cou/list", "/cou/list.json", "/cou/total", "/cou/insert", "/cou/read", "/cou/delete", "/cou/update"})
public class CoursesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CouDAOImpl dao = new CouDAOImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		switch (request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/cou/list.json": 
			QueryVO vo = new QueryVO();
			vo.setKey(request.getParameter("key"));
			vo.setWord(request.getParameter("word"));
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setSize(Integer.parseInt(request.getParameter("size")));
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(vo)));
			break;
			
		case "/cou/total":
			vo = new QueryVO();
			vo.setKey(request.getParameter("key"));
			vo.setWord(request.getParameter("word"));
			out.print(dao.total(vo));
			break;
			
		case "/cou/insert":
			request.setAttribute("code", dao.getCode());
			request.setAttribute("pageName", "/cou/insert.jsp");
			dis.forward(request, response);
			break;
			
		case "/cou/read":
			request.setAttribute("cou", dao.read(request.getParameter("lcode")));
			request.setAttribute("pageName", "/cou/read.jsp");
			dis.forward(request, response);
			break;
			
		case "/cou/update":
			request.setAttribute("cou", dao.read(request.getParameter("lcode")));
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/cou/insert":
			CouVO vo = new CouVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setRoom(request.getParameter("room"));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setPname(request.getParameter("pname"));
			// System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/cou/list");
			break;
			
		case "/cou/delete":
			out.print(dao.delete(request.getParameter("lcode")));
			break;
			
		case "/cou/update":
			vo = new CouVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setRoom(request.getParameter("room"));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setPname(request.getParameter("pname"));
			dao.update(vo);
			response.sendRedirect("/cou/read?lcode=" + request.getParameter("lcode"));
			break;
		}
	}

}
