package com.devca.utility.crawling;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.devca.model.dto.lecture.JOBD_KEYWORD;

public class Programmers {
	public static ArrayList<JOBD_KEYWORD> getKeywordFromProgrammers(){ 
		ArrayList<JOBD_KEYWORD> jobd_keywords = new ArrayList<>();
		ArrayList<String> keywordList = new ArrayList<>();
		
		/* programmers 의 채용데이터를 크롤링 하여 기술 키워드를 습득 */
		int page = 0;
		while (true) {
			page++;
			String url = "https://programmers.co.kr/job?page=" + page; // 크롤링할 url지정
			Document doc = null; // Document에는 페이지의 전체 HTML 문서가 저장된다

			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
			}

			// select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
			Elements elements = doc.select("ul.list-positions");

			// Iterator을 사용하여 하나씩 값 가져오기
			Iterator<Element> ie1 = elements.select("li.list-position-item").iterator();

			if (!ie1.hasNext())
				break;

			while (ie1.hasNext()) {
				Element item = ie1.next();
				Element body = item.selectFirst("div.item-body");

				Elements tags = body.select("ul.list-position-tags");
				Iterator<Element> itag = tags.select("li.stack-item").iterator();
				while (itag.hasNext()) {
					Element tagItem = itag.next();
					String stack = tagItem.text();

					System.out.print(stack + " ");
					keywordList.add(stack);
				}
			}

		}
		
		/* 겹치는 키워드를 map 을 통해 빼내기 */
		Map<String, Integer> wordMap = new HashMap<String, Integer>();
		
		for(String keyword : keywordList) {
			if(wordMap.get(keyword) != null) {
				int freq = wordMap.get(keyword);
				wordMap.put(keyword, freq + 1);
			}else {
				wordMap.put(keyword, 1);
			}
		}
		
		Set<Entry<String, Integer>> eSet = wordMap.entrySet();
		Iterator<Entry<String, Integer>> it = eSet.iterator();
		
		while(it.hasNext()) {
			Entry<String, Integer> entry = it.next();
			// System.out.println("기술명 : " + entry.getKey() + " / 빈도수 : " + entry.getValue());
			
			JOBD_KEYWORD key = new JOBD_KEYWORD();
			key.setTECH(entry.getKey());
			key.setIS_TECH("Y");
			
			jobd_keywords.add(key);
		}
		
		return jobd_keywords;
	}
}
