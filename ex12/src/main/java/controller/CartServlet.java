package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.CartDAO;
import model.CartVO;
import model.FavoriteDAO;
import model.OrderDAO;
import model.OrderVO;
import model.PurchaseVO;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet(value={"/cart/insert", "/cart/list.json", "/cart/list", "/cart/update", "/cart/delete", "/favorite/insert", "/favorite/delete", 
				"/purchase/insert", "/purchase/list.json", "/order/insert", "/order/list", "/order/olist.json"})
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CartDAO dao = new CartDAO();
	FavoriteDAO fdao = new FavoriteDAO();
	OrderDAO odao = new OrderDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		
		switch(request.getServletPath()) {
		case "/cart/list.json":
			out.print(gson.toJson(dao.list(request.getParameter("uid"))));
			break;
			
		case "/cart/list":
			request.setAttribute("pageName", "/goods/cart.jsp");
			dis.forward(request, response);
			break;
		
		case "/order/list":
			request.setAttribute("pageName", "/user/order.jsp");
			dis.forward(request, response);
			break;
			
		case "/purchase/list.json":	// 테스트 : /purchase/list.json?uid=jun
			out.print(gson.toJson(odao.list(request.getParameter("uid"))));
			break;
			
		case "/order/olist.json":	// 테스트 : /order/olist.json?pid=0ae459c1-fe47
			out.print(gson.toJson(odao.olist(request.getParameter("pid"))));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/cart/insert":
			CartVO vo = new CartVO();
			vo.setUid(request.getParameter("uid"));
			vo.setGid(request.getParameter("gid"));
			out.print(dao.insert(vo));
			break;
			
		case "/cart/update":
			vo = new CartVO();
			vo.setUid(request.getParameter("uid"));
			vo.setGid(request.getParameter("gid"));
			vo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			dao.update(vo);
			break;
			
		case "/cart/delete":
			vo = new CartVO();
			vo.setUid(request.getParameter("uid"));
			vo.setGid(request.getParameter("gid"));
			dao.delete(vo);
			break;
			
		case "/favorite/insert":
			String uid = request.getParameter("uid");
			String gid = request.getParameter("gid");
			fdao.insert(uid, gid);
			break;
		
		case "/favorite/delete":
			uid = request.getParameter("uid");
			gid = request.getParameter("gid");
			fdao.delete(uid, gid);
			break;
			
		case "/purchase/insert":	// 주문자 정보 등록
			UUID uuid = UUID.randomUUID();
			String pid = uuid.toString().substring(0, 13);
			PurchaseVO pvo = new PurchaseVO();
			pvo.setPid(pid);
			pvo.setUid(request.getParameter("uid"));
			pvo.setUname(request.getParameter("rname"));
			pvo.setPhone(request.getParameter("rphone"));
			pvo.setAddress1(request.getParameter("raddress1"));
			pvo.setAddress2(request.getParameter("raddress2"));
			pvo.setSum(Integer.parseInt(request.getParameter("sum")));
			// System.out.println(pvo.toString());
			odao.insert(pvo);
			out.print(pid);
			break;
			
		case "/order/insert":		// 주문 상품 등록
			OrderVO ovo = new OrderVO();
			ovo.setPid(request.getParameter("pid"));
			ovo.setGid(request.getParameter("gid"));
			ovo.setPrice(Integer.parseInt(request.getParameter("price")));
			ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			// System.out.println(ovo.toString());
			odao.insert(ovo);
			break;
		}
	}

}
