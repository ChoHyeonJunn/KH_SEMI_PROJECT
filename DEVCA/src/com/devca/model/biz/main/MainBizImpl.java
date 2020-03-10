package com.devca.model.biz.main;

import java.util.List;

import com.devca.model.dao.main.MainDao;
import com.devca.model.dao.main.MainDaoImpl;
import com.devca.model.dao.member.MemberDao;
import com.devca.model.dao.member.MemberDaoImpl;
import com.devca.model.dto.lecture.JOB_RANK;
import com.devca.model.dto.member.ROADMAP;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class MainBizImpl implements MainBiz {

	MainDao dao = new MainDaoImpl();
	MemberDao memberDao = new MemberDaoImpl();

	// 로드맵 데이터 요청처리
	@Override
	public ROADMAP getRoadMapData(int MEMBER_CODE) {
		return dao.getRoadMapData(MEMBER_CODE);
	}

	// 로드맵 데이터 추가 요청처리
	@SuppressWarnings("deprecation")
	@Override
	public int addRoadMapData(int MEMBER_CODE, String item) {
		ROADMAP roadmap = dao.getRoadMapData(MEMBER_CODE);
		JsonParser parser = new JsonParser();

		JsonObject addItem = new JsonObject();
		addItem.addProperty("name", item);
		addItem.addProperty("value", "3");

		JsonArray roadMapData = (JsonArray) parser.parse(roadmap.getROADMAP_TECH());
		roadMapData.add(addItem);

		ROADMAP newRoadMap = new ROADMAP();
		newRoadMap.setMEMBER_CODE(MEMBER_CODE);
		newRoadMap.setROADMAP_TECH(roadMapData.toString());

		return memberDao.updateRoadMap(newRoadMap);
	}

	// 로드맵 중분류 추가 요청처리
	@SuppressWarnings("deprecation")
	@Override
	public int addRoadMapCategory(int MEMBER_CODE, String item) {
		ROADMAP roadmap = dao.getRoadMapData(MEMBER_CODE);
		JsonParser parser = new JsonParser();


		JsonArray addChild = new JsonArray();
		JsonObject temp = new JsonObject();
		temp.addProperty("name", "기술을 추가하세요");
		temp.addProperty("value", "3");
		addChild.add(temp);
		
		JsonObject addItem = new JsonObject();
		addItem.addProperty("name", item);
		addItem.add("children", addChild);

		JsonArray roadMapData = (JsonArray) parser.parse(roadmap.getROADMAP_TECH());
		roadMapData.add(addItem);

		ROADMAP newRoadMap = new ROADMAP();
		newRoadMap.setMEMBER_CODE(MEMBER_CODE);
		newRoadMap.setROADMAP_TECH(roadMapData.toString());

		return memberDao.updateRoadMap(newRoadMap);
	}
	
	// 로드맵 데이터 삭제 요청처리
	@SuppressWarnings("deprecation")
	@Override
	public int removeRoadMapData(int MEMBER_CODE, String item) {
		ROADMAP roadmap = dao.getRoadMapData(MEMBER_CODE);
		JsonParser parser = new JsonParser();

		JsonArray roadMapData = (JsonArray) parser.parse(roadmap.getROADMAP_TECH());

		//System.out.println("json 지우기!!");
		//System.out.println(roadMapData);

		for (int i = 0; i < roadMapData.size(); i++) {
			JsonObject obj = roadMapData.get(i).getAsJsonObject();
			// System.out.println(obj.get("name"));

			// 지워야 할 노드일 때
			if (obj.get("name").toString().contains(item)) {

				// 자식 노드가 있을 경우
				if (obj.get("children") != null) {
					JsonArray array = obj.get("children").getAsJsonArray();
					if (array.size() == 0) {
						roadMapData.remove(i--);
					} else {
						//System.out.println("자식 노드가 있어 지울 수 없음!!");
					}
				} else {
					roadMapData.remove(i--);
				}
			} else {
				if (obj.get("children") != null) {
					JsonArray array = obj.get("children").getAsJsonArray();
					for (int j = 0; j < array.size(); j++) {
						JsonObject sobj = array.get(j).getAsJsonObject();

						//System.out.println(sobj.get("name").toString());
						if (sobj.get("name").toString().contains(item)) {
							//System.out.println("지울 노드 발견!!!");
							array.remove(j);
						}
					}
				}
			}
		}

		//System.out.println(roadMapData);

		ROADMAP newRoadMap = new ROADMAP();
		newRoadMap.setMEMBER_CODE(MEMBER_CODE);
		newRoadMap.setROADMAP_TECH(roadMapData.toString());

		return memberDao.updateRoadMap(newRoadMap);
	}

	// 로드맵 데이터 연결 요청처리
	@Override
	public int linkRoadMapData(int MEMBER_CODE, String selectedItem, String Item) {
		ROADMAP roadmap = dao.getRoadMapData(MEMBER_CODE);
		JsonParser parser = new JsonParser();

		JsonArray roadMapData = (JsonArray) parser.parse(roadmap.getROADMAP_TECH());

		//System.out.println("json 연결하기!!");
		//System.out.println(roadMapData);

		for (int i = 0; i < roadMapData.size(); i++) {
			JsonObject obj = roadMapData.get(i).getAsJsonObject();

			// 연결할 부모 노드일 때
			if (obj.get("name").toString().contains(selectedItem)) {
				JsonArray array = obj.get("children").getAsJsonArray();

				JsonObject linkItem = new JsonObject();
				linkItem.addProperty("name", Item);
				linkItem.addProperty("value", "3");

				array.add(linkItem);
			}

			// 기존 존재하던 Item 은 삭제
			if (obj.get("name").toString().contains(Item)) {
				roadMapData.remove(i--);	// 자식노드가 있는 경우는 이벤트가 발생하지 않도록 view에서 막아놓음!!
			}
		}

		//System.out.println(roadMapData);

		ROADMAP newRoadMap = new ROADMAP();
		newRoadMap.setMEMBER_CODE(MEMBER_CODE);
		newRoadMap.setROADMAP_TECH(roadMapData.toString());

		return memberDao.updateRoadMap(newRoadMap);
	}

	// 기술 요구사항 데이터 요청 처리
	@Override
	public List<JOB_RANK> getBarChartData(String verify) {
		if (verify.equals("Developer")) {
			return dao.getDeveloperBarChartData();
		} else if (verify.equals("Web")) {
			return dao.getWebBarChartData();
		} else if (verify.equals("Server")) {
			return dao.getServerBarChartData();
		} else if (verify.equals("Language")) {
			return dao.getLanguageBarChartData();
		} else if (verify.equals("DataBase")) {
			return dao.getDataBaseBarChartData();
		} else if (verify.equals("frameWork")) {
			return dao.getframeWorkBarChartData();
		} else {
			return dao.getDeveloperBarChartData();
		}
	}

}
