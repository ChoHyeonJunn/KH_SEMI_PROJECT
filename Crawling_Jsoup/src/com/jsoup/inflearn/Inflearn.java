package com.jsoup.inflearn;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Inflearn {
	public static void main(String[] args) {
		String url = "https://www.inflearn.com/courses/it-programming/web-dev"; //크롤링할 url지정
		Document doc = null;        //Document에는 페이지의 전체 HTML 문서가 저장된다

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
		Elements elements = doc.select("div.columns.is-multiline.is-mobile.courses_card_list_body");    

		System.out.println("============================================================");

		//Iterator을 사용하여 하나씩 값 가져오기
		Iterator<Element> ie1 = elements.select("div.course_title").iterator();
		        
		while (ie1.hasNext()) {
			System.out.println(ie1.next().text());
		}
		
		System.out.println("============================================================");

	}
}
