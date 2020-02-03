package com.jsoup.youtube;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class YoutubeJsoupCrawlingTest {
	public static void main(String[] args) {
		// Jsoup�� �̿��ؼ� https://www.youtube.com/results?search_query=python ũ�Ѹ� (���̽� �˻�!!)
		
		String url = "https://www.youtube.com/results?search_query=python"; //ũ�Ѹ��� url����
		Document doc = null;        //Document���� �������� ��ü HTML ������ ����ȴ�

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//select�� �̿��Ͽ� ���ϴ� �±׸� �����Ѵ�. select�� ���ϴ� ���� �������� ���� �߿��� ����̴�.
		Elements elements = doc.select("div#contents");    

		System.out.println("============================================================");

		//Iterator�� ����Ͽ� �ϳ��� �� ��������
		Iterator<Element> ie1 = elements.select("yt-formatted-string.style-scope.ytd-video-renderer").iterator();
		//Iterator<Element> ie2 = elements.select("strong.title").iterator();
		        
		while (ie1.hasNext()) {
			System.out.println(ie1.next().text());
		}
		
		System.out.println("============================================================");
	}
}
