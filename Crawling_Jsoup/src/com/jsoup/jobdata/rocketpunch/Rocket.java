package com.jsoup.jobdata.rocketpunch;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Rocket {
	public static void main(String[] args) {
		//String url = "https://www.inflearn.com/courses/it-programming/web-dev"; //크롤링할 url지정
		
		String url = "https://www.rocketpunch.com/jobs?job=" + "1" + 
		"&page=" + "9" + 
		"&tag=" + "웹서비스";
		
		
		Document doc = null;        //Document에는 페이지의 전체 HTML 문서가 저장된다
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 임시 doc 출력
		System.out.println(doc.text());
		//
		
		//select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
		Elements elements = doc.select("div#company-list");    
		
		System.out.println("============================================================");

		//Iterator을 사용하여 하나씩 값 가져오기
		Iterator<Element> ie = elements.select("div.company.item").iterator();
		        
		while (ie.hasNext()) {
			Element company = ie.next();
			Element content;
			System.out.println(company.text());
			Element companyName = company.selectFirst("div.company-name");
			Element companyKorName = companyName.selectFirst("strong"); 
			
			
			System.out.println(companyKorName.text());
		}
		
		System.out.println("============================================================");

	}
	
	
}
