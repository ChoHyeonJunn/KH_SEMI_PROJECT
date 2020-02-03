package com.jsoup.cgv;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class CGVJsoupCrawlingTest {
	public static void main(String[] args) {
		// Jsoup�� �̿��ؼ� http://www.cgv.co.kr/movies/ ũ�Ѹ�
		
		String url = "http://www.cgv.co.kr/movies/"; //ũ�Ѹ��� url����
		Document doc = null;        //Document���� �������� ��ü HTML ������ ����ȴ�

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//select�� �̿��Ͽ� ���ϴ� �±׸� �����Ѵ�. select�� ���ϴ� ���� �������� ���� �߿��� ����̴�.
		Elements elements = doc.select("div.sect-movie-chart");    

		System.out.println("============================================================");

		//Iterator�� ����Ͽ� �ϳ��� �� ��������
		Iterator<Element> ie1 = elements.select("strong.rank").iterator();
		Iterator<Element> ie2 = elements.select("strong.title").iterator();
		        
		while (ie1.hasNext()) {
			System.out.println(ie1.next().text()+"\t"+ie2.next().text());
		}
		
		System.out.println("============================================================");
	}
}
