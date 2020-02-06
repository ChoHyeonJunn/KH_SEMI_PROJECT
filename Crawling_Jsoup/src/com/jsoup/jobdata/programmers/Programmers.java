package com.jsoup.jobdata.programmers;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Programmers {
	public static void main(String[] args) {
		// Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링

		String url = "https://programmers.co.kr/job?page=1"; // 크롤링할 url지정
		Document doc = null; // Document에는 페이지의 전체 HTML 문서가 저장된다

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 임시 doc 출력
		System.out.println(doc.text());
		//
		
		// select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
		Elements elements = doc.select("ul.list-positions");

		System.out.println("============================================================");

		// Iterator을 사용하여 하나씩 값 가져오기
		Iterator<Element> ie1 = elements.select("li.list-position-item").iterator();

		while (ie1.hasNext()) {
			Element item = ie1.next();
			Element body = item.selectFirst("div.item-body");
			
			Element companyName = body.selectFirst("h5.company-name");
			System.out.println(companyName.text());
			
			Elements tags = body.select("ul.list-position-tags");
			Iterator<Element> itag = tags.select("li.stack-item").iterator();
			while(itag.hasNext()) {
				Element tagItem = itag.next();
				System.out.print(tagItem.text() + " / ");
			}
			System.out.println();System.out.println();
		}

		System.out.println("============================================================");

	}
}
