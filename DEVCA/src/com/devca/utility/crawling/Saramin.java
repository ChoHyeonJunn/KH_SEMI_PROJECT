package com.devca.utility.crawling;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import com.devca.model.dto.lecture.JOB_RANK;

public class Saramin {
	private static WebDriver driver;

	public static ArrayList<JOB_RANK> saraminCrawling(List<JOB_RANK> job_rank, int page) {

		ArrayList<JOB_RANK> new_job_rank = (ArrayList<JOB_RANK>) job_rank;

		int count = 0;

		if (page == 21 || page == 40)
			return new_job_rank;

		String url = "http://www.saramin.co.kr/zf_user/jobs/list/job-category?page=" + page
				+ "&cat_cd=404&search_optional_item=n&search_done=y&panel_count=y&isAjaxRequest=0&page_count=50&sort=RL&type=job-category&is_param=1&isSearchResultEmpty=1&isSectionHome=0&searchParamCount=1#searchTitle";

		Document doc = null; // Document에는 페이지의 전체 HTML 문서가 저장된다

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
		Elements elements = doc.select("#default_list_wrap table");

		// Iterator을 사용하여 하나씩 값 가져오기
		Iterator<Element> ie1 = elements.select("tr").iterator();

		while (ie1.hasNext()) {
			System.out.println(
					"------------------------" + page + " 페이지에 : " + (++count) + " 번째 크롤링------------------------");
			Element item = ie1.next();

			String tr_id = item.attr("id");
			System.out.println(tr_id);
			String link = "http://www.saramin.co.kr" + item.select(".str_tit").attr("href");
			System.out.println(link);

			// detail 페이지로 접근해 채용공고문을 탐색한다.
			if (tr_id != "") {
				System.out.println("셀레니움 접근!!");
				// System Property SetUp
				System.setProperty("webdriver.chrome.driver",
						"C:/Users/chohyeonjunn/Downloads/selenium/chromedriver.exe");

				// Driver SetUp
				ChromeOptions options = new ChromeOptions();
				options.addArguments("headless");
				driver = new ChromeDriver(options);

				try {
					driver.get(link);
					String jobRequire = driver.findElement(By.className("wrap_jview")).getText();
					System.out.println(jobRequire);

					// jobRequire 는 채용 정보와 관련한 디테일 문자열이다.
					// 여기서 jobd_keyword 와 겹치는 부분이 있다면 빈도수를 높여준다.

					for (int i = 0; i < new_job_rank.size(); i++) {
						if (jobRequire.contains(new_job_rank.get(i).getJOB_RANK_STACK())) {
							System.out.print(new_job_rank.get(i).getJOB_RANK_STACK() + " : 된다!!!!");
							new_job_rank.get(i).setJOB_RANK_NUM(new_job_rank.get(i).getJOB_RANK_NUM() + 1);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					System.out.println("마무으리 셀레니움");
					driver.close();
				}
			}
		}

		return new_job_rank;
	}

	public static ArrayList<JOB_RANK> saraminCrawling2(List<JOB_RANK> job_rank) {

		ArrayList<JOB_RANK> new_job_rank = (ArrayList<JOB_RANK>) job_rank;

		for (JOB_RANK job : new_job_rank) {

			String url = "http://www.saramin.co.kr/zf_user/search?searchType=search&cat_cd=404&company_cd=0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C9&searchword="
					+ job.getJOB_RANK_STACK() + "&panel_type=&search_optional_item=y&search_done=y&panel_count=y";
			// "http://www.saramin.co.kr/zf_user/search?searchType=search&cat_cd=404&company_cd=0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C9&searchword=python&panel_type=&search_optional_item=y&search_done=y&panel_count=y";
			Document doc = null; // Document에는 페이지의 전체 HTML 문서가 저장된다

			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				e.printStackTrace();
				continue;
			}

			// select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
			Element elements = doc.select("span.cnt_result").first();
			if (elements != null) {
				String str = elements.text().split(" ")[1];
				String strf = str.substring(0, str.length() - 1);
				String finalStr = strf.replace(",", "");
				int stack_num = Integer.parseInt(finalStr);
				System.out.println(job.getJOB_RANK_STACK() + " 의 갯수 = " + stack_num);
				
				job.setJOB_RANK_NUM(stack_num);
			} else {
				System.out.println("NULL 값이야!!!! : " + elements);
				job.setJOB_RANK_NUM(0);
			}
		}
		return new_job_rank;
	}
}
