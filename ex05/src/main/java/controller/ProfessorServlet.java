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

import model.ProDAOImpl;
import model.ProVO;
import model.QueryVO;

@WebServlet(value= {"/pro/list", "/pro/list.json", "/pro/total", "/pro/insert", "/pro/read", "/pro/delete"})
public class ProfessorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProDAOImpl dao = new ProDAOImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/pro/list.json":
			int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			int size = request.getParameter("size") == null ? 2 : Integer.parseInt(request.getParameter("size"));
			String key = request.getParameter("key") == null ? "pcode" : request.getParameter("key");
			String word = request.getParameter("word") == null ? "" : request.getParameter("word");
			QueryVO vo = new QueryVO();
			vo.setPage(page);
			vo.setSize(size);
			vo.setWord(word);
			vo.setKey(key);
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(vo)));
			break;
		
		case "/pro/total":
			key = request.getParameter("key") == null ? "pcode" : request.getParameter("key");
			word = request.getParameter("word") == null ? "" : request.getParameter("word");
			vo = new QueryVO();
			vo.setKey(key);
			vo.setWord(word);
			out.print(dao.total(vo));
			break;
			
		case "/pro/insert":
			request.setAttribute("code", dao.getCode());
			request.setAttribute("pageName", "/pro/insert.jsp");
			dis.forward(request, response);
			break;
			
		case "/pro/read":
			String pcode = request.getParameter("pcode");
			request.setAttribute("pro", dao.read(pcode));
			request.setAttribute("pageName", "/pro/read.jsp");
			dis.forward(request, response);
			break;
			
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/pro/insert":
			ProVO pro = new ProVO();
			pro.setPcode(request.getParameter("pcode"));
			pro.setPname(request.getParameter("pname"));
			pro.setDept(request.getParameter("dept"));
			pro.setTitle(request.getParameter("title"));
			pro.setSalary(Integer.parseInt(request.getParameter("salary")));
			pro.setHiredate(request.getParameter("hiredate"));
//			System.out.println(pro.toString());
			dao.insert(pro);
			response.sendRedirect("/pro/list");
			break;
			
		case "/pro/delete":
			int result = dao.delete(request.getParameter("pcode")); 
			out.print(result);
			break;
		}
	}

}
