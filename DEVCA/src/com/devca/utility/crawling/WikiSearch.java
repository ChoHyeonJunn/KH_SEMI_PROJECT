package com.devca.utility.crawling;

import java.io.IOException;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

public class WikiSearch {
	public static String wikiSearching(String word) {
		
		String url = "https://ko.wikipedia.org/wiki/" + word; // 크롤링할 url지정
		Document doc = null; // Document에는 페이지의 전체 HTML 문서가 저장된다
		
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Wiki Search Crawling Error : return '' ,,,");
			return "";
		}
		
		Element des = doc.selectFirst("#mw-content-text > .mw-parser-output"); // 내용은 html 코드와 같이 통으로
		
		return des.toString();
	}
}
