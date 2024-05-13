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
@WebServlet(value={"/goods/search", "/goods/search.json", "/goods/insert", "/goods/list", "/goods/list.json", "/goods/delete"})
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
			
		case "/goods/list.json":
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list()));
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
