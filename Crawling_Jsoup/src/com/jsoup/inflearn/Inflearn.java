package com.jsoup.inflearn;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Inflearn {
	public static void main(String[] args) {
		String url = "https://www.inflearn.com/courses/it-programming/web-dev"; //ũ�Ѹ��� url����
		Document doc = null;        //Document���� �������� ��ü HTML ������ ����ȴ�

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//select�� �̿��Ͽ� ���ϴ� �±׸� �����Ѵ�. select�� ���ϴ� ���� �������� ���� �߿��� ����̴�.
		Elements elements = doc.select("div.columns.is-multiline.is-mobile.courses_card_list_body");    

		System.out.println("============================================================");

		//Iterator�� ����Ͽ� �ϳ��� �� ��������
		Iterator<Element> ie1 = elements.select("div.course_title").iterator();
		        
		while (ie1.hasNext()) {
			System.out.println(ie1.next().text());
		}
		
		System.out.println("============================================================");

	}
}
