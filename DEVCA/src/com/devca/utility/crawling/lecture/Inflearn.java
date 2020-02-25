package com.devca.utility.crawling.lecture;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.devca.model.dto.lecture.LECTURE;

public class Inflearn {

	public static ArrayList<LECTURE> inflearnCrawling(String search) throws IOException {

		 ArrayList<LECTURE> inflearnList = new ArrayList<LECTURE>();

		int page = 1;
		int pagination_size = 0;

		while (true) {
			// String url = "https://www.inflearn.com/courses?order=search&s=" + search +
			// "&page=" + page;
			String url = "https://www.inflearn.com/courses?page=" + page + "&order=search&s=" + search;

			Document doc = Jsoup.connect(url).get();

			// 전체 페이지 갯수 가져오기
			Elements pagination_list = doc.select(".pagination-list li");
			pagination_size = pagination_list.size();

			System.out.println("-----" + pagination_size + " : " + page + "-----");

			Elements searchList = doc.select(
					".columns.is-multiline.is-mobile.courses_card_list_body .column.is-3-fullhd.is-3-widescreen.is-3-desktop.is-4-tablet.is-6-mobile");

			for (Element tr : searchList) {

				// list에서 따올수 있는 data
				String title = tr.select(".card-content .course_title").html();
				String imgUrl = tr.select("img").attr("src");
				String link = "https://www.inflearn.com" + tr.select(".course_card_back > a").attr("href");
				String description = tr.select(".course_card_back .course_decription").html();
				String payflag = tr.select(".price.has-text-right.column.is-half").html();

				// detail 페이지로 접근
				Document detail_doc = Jsoup.connect(link).get();
				Element d_content = detail_doc.selectFirst("#description .body"); // 내용은 html 코드와 같이 통으로

				// 임시 출력

				//System.out.println("title : " + title);
				//System.out.println("// imgUrl : " + imgUrl);
				//System.out.println("// link : " + link);
				//System.out.println("// description : " + description);
				//System.out.println("// payflag : " + payflag);
				// System.out.println("// d_content : " + d_content);
				//System.out.println();

				LECTURE lecture = new LECTURE();

				lecture.setLECTURE_TITLE(title);
				lecture.setLECTURE_IMG(imgUrl);
				lecture.setLECTURE_LINK(link);
				
				lecture.setLECTURE_DESCRIPTION(description);
				lecture.setLECTURE_CONTENT(d_content.toString());
				lecture.setLECTURE_PAYFLAG(payflag);
				
				lecture.setLECTURE_ADDRESS("");
				lecture.setLECTURE_LATITUDE("");
				lecture.setLECTURE_LOGITUDE("");
				
				lecture.setLECTURE_RATE("0");
				lecture.setLECTURE_READCOUNT(0);

				inflearnList.add(lecture);
			}

			// 종료조건 or 계속

			if (page >= pagination_size) {
				break;
			} else {
				page++;
			}
		}
		System.out.println(search + " : " + inflearnList.size() + "개의 lecture crawling 됨!!");
		return inflearnList;
	}
}
