package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.UserDAO;
import model.UserVO;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet(value={"/user/login", "/user/logout", "/user/mypage", "/user/update", "/user/update/pass", "/user/list", "/user/upload", "/user/join"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		
		case "/user/logout":
			session.invalidate();
			response.sendRedirect("/");
			break;
			
		case "/user/mypage":
			String uid = (String)session.getAttribute("uid");
			request.setAttribute("user", dao.read(uid));
			request.setAttribute("pageName", "/user/mypage.jsp");
			dis.forward(request, response);
			break;
		
		case "/user/list.json":
			Gson gson=new Gson();
			out.print(gson.toJson(dao.list()));
			break;
			
		case "/user/list":
			request.setAttribute("pageName", "/user/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/user/join":
			request.setAttribute("pageName", "/user/join.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		switch (request.getServletPath()) {
		case "/user/login":
			String uid = request.getParameter("uid");
			String upass = request.getParameter("upass");
			UserVO vo = dao.read(uid);
			int result = 0;
			System.out.println(uid + ":" + upass);
			if(vo.getUid() != null) {
				if(upass.equals(vo.getUpass())){
					HttpSession session = request.getSession();
					session.setAttribute("user", vo);
					session.setAttribute("uid", uid);
					result = 1;
				}else {
					result = 2;
				}
			}
			out.print(result);
			break;
		
		case "/user/update":
			vo = new UserVO();
			vo.setUid(request.getParameter("uid"));
			vo.setUname(request.getParameter("uname"));
			vo.setPhone(request.getParameter("phone"));
			vo.setAddress1(request.getParameter("address1"));
			vo.setAddress2(request.getParameter("address2"));
			System.out.println(vo.toString());
			dao.update(vo);
			break;
		
		case "/user/update/pass":
			uid = request.getParameter("uid");
			String npass = request.getParameter("npass");
			dao.update(uid, npass);
			break;
			
		case "/user/upload":
			String path="/upload/photo/";
			MultipartRequest multi=new MultipartRequest(
					request,
					"c:" + path,
					1024*1024*10,
					new DefaultFileRenamePolicy());
			String fileName=multi.getFilesystemName("photo");
			String uid2=multi.getParameter("uid");
			System.out.println("fileName:" + fileName + "\nuid:" + uid2);
			String photo=path + fileName;
			dao.updatePhoto(uid2, photo); //사진이름수정
			break;
		}		
	}

}
