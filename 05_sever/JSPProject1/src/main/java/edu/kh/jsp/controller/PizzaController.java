package edu.kh.jsp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.kh.jsp.model.dyo.Pizza;

@WebServlet("/pizzaOrder")
public class PizzaController extends HttpServlet{

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		List<Pizza> pizzaList = new ArrayList<>();
		
		pizzaList.add(new Pizza("치즈 피자", 8000) );
		pizzaList.add(new Pizza("콤비네이션 피자", 9000) );
		pizzaList.add(new Pizza("핫치킨 피자", 10000) );
		//post 방식 문제점 : 문자 인코딩 불일치
		req.setCharacterEncoding("UTF-8");
		
		String pizza = req.getParameter("pizza"); // 1,2,3중 하나
		String size = req.getParameter("size"); // R,L중 하나
		
		String amount = req.getParameter("amount"); // 수량
		
		//L 사이즈는 2천원 추가
		
		//피자 종류 : 핫치킨 피자(L)
		
		// 수량 : 2
		
		// 총 가격 : 24000원
		
		//피자 종류 파악
		// -> pizza는 "1"처럼 문자열 ->
		Pizza p = pizzaList.get( Integer.parseInt(pizza)- 1);
		
		String pizzaName = p.getName();
		
		int price = p.getPrice(); //피자 가격
		
		if(size.equals("L")) price += 2000;
		
		//price에 amount값 곱하기
		price *= Integer.parseInt(amount);
		
		//req에 pizzaName, price를 속성으로 추가
		req.setAttribute("pizzaName", pizzaName);
		req.setAttribute("price", price);
		
		// jsp요청 위임
		// -> 왜 위임?  servlet에서 응답 화면 만들기
		
		//jsp 경로 작성 기준 폴더 : webapp
		RequestDispatcher dispatcher
			= req.getRequestDispatcher("/WEB-INF/views/pizzaResult.jsp");
		
		//요청 위임
		dispatcher.forward(req, resp);
	}
}
