package com.devca.model.biz.member;

import com.devca.model.dao.member.MemberDao;
import com.devca.model.dao.member.MemberDaoImpl;
import com.devca.model.dto.KAKAO_MEMBER;
import com.devca.model.dto.MEMBER;

public class MemberBizImpl implements MemberBiz {

	MemberDao dao = new MemberDaoImpl();

	@Override
	public int memberJoin(MEMBER member) {
		return dao.memberJoin(member);
	}

	@Override
	public int kakaoJoin(KAKAO_MEMBER kakao_member) {
		MEMBER member = new MEMBER();
		KAKAO_MEMBER kakao = new KAKAO_MEMBER();

		member.setMEMBER_NAME(kakao_member.getMEMBER_NAME());
		member.setMEMBER_EMAIL(kakao_member.getMEMBER_EMAIL());
		member.setMEMBER_PHONE(kakao_member.getMEMBER_PHONE());

		int kakao_res = 0;
		int res = dao.memberJoinWithSNS(member);
		if (res > 0) {
			MEMBER member_seq = dao.getMEMBER_CODE(kakao_member.getMEMBER_EMAIL());
			
			kakao.setMEMBER_CODE(member_seq.getMEMBER_CODE());
			kakao.setKAKAO_ID(kakao_member.getKAKAO_ID());
			kakao.setKAKAO_NICKNAME(kakao_member.getKAKAO_NICKNAME());
			
			kakao_res = dao.kakaoJoin(kakao);	
		}

		return kakao_res;
	}

	@Override
	public MEMBER memberLogin(MEMBER member) {
		return dao.memberLogin(member);
	}

}
