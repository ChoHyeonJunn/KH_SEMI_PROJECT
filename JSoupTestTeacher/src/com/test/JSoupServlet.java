package com.test;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

@WebServlet("/test.do")
public class JSoupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String search = request.getParameter("search");
		
		int page = 1;
		boolean hasNext = true;
		
		while(hasNext) {
			String url = "https://search.kyobobook.co.kr/web/search?vPstrKeyWord=" + search + "&searchPcondition=1&collName=&vPstrTab=PRODUCT&currentPage="+page+"&orderClick=LAG";
			// System.out.println(url);
			
			Document doc = Jsoup.connect(url).get();
			// System.out.println(doc);

			System.out.println("-----"+page+"-----");
			Elements searchList = doc.select("#search_list tr");
			for(Element tr : searchList) {
				// System.out.println(tr);
				String imgUrl = tr.select(".image img").attr("src");
				String title = tr.select(".title strong").html();
				String price = tr.select(".sell_price strong").html();
	
				System.out.println(title + " : " + price + " \t " + imgUrl);
				
				
			}
			page++;
			// System.out.println(searchList.size());
			if(searchList.size() != 0) {
				page++;
			} else {
				hasNext = false;
			}
			// System.out.println(doc.select(".page_jump"));
		}
	}

}
