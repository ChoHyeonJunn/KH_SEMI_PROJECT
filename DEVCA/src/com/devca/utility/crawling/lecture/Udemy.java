package com.devca.utility.crawling.lecture;

import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import com.devca.model.dto.lecture.LECTURE;

public class Udemy {

	private static WebDriver driver;

	public static void main(String[] args) {

	}

	public static int udemyCrawlingWithoutSearching() {

		// System Property SetUp
		System.setProperty("webdriver.chrome.driver", "C:/Users/chohyeonjunn/Downloads/selenium/chromedriver.exe");

		// Driver SetUp
		ChromeOptions options = new ChromeOptions();
		options.addArguments("headless");
		driver = new ChromeDriver();

		int result = 0;
		int page = 0;
		int pagination_size = 999999999;

		while (++page <= pagination_size) {
			ArrayList<LECTURE> udemyList = new ArrayList<LECTURE>();

			String url = "https://www.udemy.com/courses/it-and-software/?p=" + page;

			driver.get(url);
			String a = driver.findElement(By.className(".pagination--container--2wc6Z")).getText();
			System.out.println(a);

			// 마지막 페이지 몇인지 가져오기
//	         pagination_size = Integer.parseInt(doc.selectFirst(".pagination--container--2wc6Z .pagination--page--3FKqV:last-child").text());
//	         System.out.println(pagination_size + " : " + page);

			/////////////////////////// START :: Crawling ///////////////////////////
//	         Elements searchList = doc.select(
//	               ".course-list--container--3zXPS .udlite-custom-focus-visible.course-card--container--3w8Zm.course-card--large--1BVxY");
//	         for (Element tr : searchList) {
			//
//	            // list에서 따올수 있는 data
//	            String title = tr.select(".udlite-heading-sm.udlite-focus-visible-target.course-card--course-title--2f7tE").html();
//	            String imgUrl = tr.select("img").attr("src");
//	            String link = "https://www.udemy.com/" + tr.select(".udlite-custom-focus-visible.course-card--container--3w8Zm.course-card--large--1BVxY").attr("href");
//	            String description = tr.select("course-card--course-headline--yIrRk").html();
//	            String payflag = tr.select("price-text--container--Ws-fP.course-card--price-text-container--2sb8G").html();
			//
//	            // detail 페이지로 접근
//	            Document detail_doc;
//	            try {
//	               detail_doc = Jsoup.connect(link).get();
//	            } catch (IOException e) {
//	               e.printStackTrace();
//	               continue;
//	            }
//	            Element d_content = detail_doc.selectFirst(".paid-course-landing-page__container"); // 내용은 html 코드와 같이 통으로
			//
//	            System.out.println(title + " : " + link);
//	            
//	            LECTURE lecture = new LECTURE();
			//
//	            lecture.setLECTURE_TITLE(title);
//	            lecture.setLECTURE_IMG(imgUrl);
//	            lecture.setLECTURE_LINK(link);
			//
//	            lecture.setLECTURE_DESCRIPTION(description);
//	            lecture.setLECTURE_CONTENT(d_content.toString());
//	            lecture.setLECTURE_PAYFLAG(payflag);
			//
//	            lecture.setLECTURE_ADDRESS("");
//	            lecture.setLECTURE_LATITUDE("");
//	            lecture.setLECTURE_LOGITUDE("");
			//
//	            lecture.setLECTURE_RATE("0");
//	            lecture.setLECTURE_READCOUNT(0);
			//
//	            udemyList.add(lecture);
//	         }
			/////////////////////////// END :: Crawling ///////////////////////////

			/////////////////////////// START :: insert DAO ///////////////////////////

			/////////////////////////// END :: insert DAO ///////////////////////////
		}
		return result;
	}

}
