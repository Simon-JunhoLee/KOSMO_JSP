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

import model.GoodsDAO;
import model.GoodsVO;
import model.NaverAPI;
import model.QueryVO;

/**
 * Servlet implementation class IndexServlet
 */
@WebServlet(value={"/goods/search", "/goods/search.json", "/goods/total", "/goods/insert", "/goods/list", "/goods/list.json", "/goods/delete", "/goods/read"})
public class GoodsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	GoodsDAO dao = new GoodsDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/goods/search":
			request.setAttribute("pageName", "/goods/search.jsp");
			dis.forward(request, response);
			break;
			
		case "/goods/search.json":
			QueryVO query = new QueryVO();
			query.setWord(request.getParameter("query"));
			query.setPage(Integer.parseInt(request.getParameter("page")));
			query.setSize(Integer.parseInt(request.getParameter("size")));
			out.print(NaverAPI.main(query));
			break;
			
		case "/goods/list":
			request.setAttribute("pageName", "/goods/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/goods/list.json":	// 테스트 : /goods/list.json?word=&page=1&size=3
			Gson gson = new Gson();
			query = new QueryVO();
			query.setWord(request.getParameter("word"));
			query.setPage(Integer.parseInt(request.getParameter("page")));
			query.setSize(Integer.parseInt(request.getParameter("size")));
			out.print(gson.toJson(dao.list(query)));
			break;
		
		case "/goods/total":
			out.print(dao.total(request.getParameter("word")));
			break;
			
		case "/goods/read":
			request.setAttribute("goods", dao.read(request.getParameter("gid")));
			request.setAttribute("pageName", "/goods/read.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/goods/insert":
			GoodsVO vo = new GoodsVO();
			vo.setGid(request.getParameter("gid"));
			vo.setTitle(request.getParameter("title"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setBrand(request.getParameter("brand"));
			vo.setImage(request.getParameter("image"));
			out.print(dao.insert(vo));
			break;
			
		case "/goods/delete":
			String gid = request.getParameter("gid");
			out.print(dao.delete(gid));
			break;
		}
	}

}
