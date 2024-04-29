package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class KakaoServlet
 */
@WebServlet(value={"/kakao/book", "/kakao/local"})
public class KakaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/kakao/book":
			request.setAttribute("pageName", "/kakao/book.jsp");
			System.out.println("카카오 API : 도서 검색");
			break;
		case "/kakao/local":
			request.setAttribute("pageName", "/kakao/local.jsp");
			System.out.println("카카오 API : 지역 검색");
			break;
		}
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
