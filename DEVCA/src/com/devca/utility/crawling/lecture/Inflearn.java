package com.devca.utility.crawling.lecture;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.devca.model.dao.lecture.LectureDao;
import com.devca.model.dao.lecture.LectureDaoImpl;
import com.devca.model.dto.lecture.LECTURE;

public class Inflearn {

	public static int inflearnCrawlingWithoutSearching() {
		LectureDao dao = new LectureDaoImpl();

		int result = 0;
		int page = 0;
		int pagination_size = 999999999;

		while (++page <= pagination_size) {
			ArrayList<LECTURE> inflearnList = new ArrayList<LECTURE>();

			String url = "https://www.inflearn.com/courses?page=" + page + "&order=seq&view=card";

			Document doc;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
				continue; // 해당 페이지 크롤링 실패시 무시하고 다음 페이지로 이동
			}

			// 마지막 페이지 몇인지 가져오기
			pagination_size = Integer.parseInt(doc.selectFirst(".pagination-list li:last-child a").text());
			System.out.println(pagination_size + " : " + page);

			/////////////////////////// START :: Crawling ///////////////////////////
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
				Document detail_doc;
				try {
					detail_doc = Jsoup.connect(link).get();
				} catch (IOException e) {
					e.printStackTrace();
					continue;
				}
				Element d_content = detail_doc.selectFirst("#description .body"); // 내용은 html 코드와 같이 통으로

				System.out.println(title + " : " + link);

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
			/////////////////////////// END :: Crawling ///////////////////////////

			/////////////////////////// START :: insert DAO ///////////////////////////
			if (inflearnList.size() > 0) {
				try {
					result += dao.multiInsertLecture(inflearnList);
					System.out.println(result + " : " + inflearnList.size() + "개 입력됨!");
				} catch (Exception e) {
					e.printStackTrace();
					continue;
				}
			}
			/////////////////////////// END :: insert DAO ///////////////////////////
		}
		return result;
	}

}
