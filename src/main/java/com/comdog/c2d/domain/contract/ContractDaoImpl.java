package com.comdog.c2d.domain.contract;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.comdog.c2d.domain.contract.dto.ContractInsertDto;
import com.comdog.c2d.domain.contract.dto.ContractListDto;

@Repository //DB와 연결되는 DAO 컴포넌트임을 명시
public class ContractDaoImpl implements ContractDao {
	
	
	// MyBatis의 핵심 객체인 SqlSession을 주입받습니다.
    @Autowired
    private SqlSession sql;

    //계약 목록 조회
    @Override
    public List<ContractListDto> searchContracts(Map<String, String> map) {
        return sql.selectList("contract.searchContracts", map);
    }
	
	//계약 상태 변경
	@Override
	public void updateContractStatus(Long contractId, String status) {
		// 파라미터가 2개이므로 Map으로 묶어서 전달
        Map<String, Object> params = new HashMap<>();
        params.put("contractId", contractId);
        params.put("status", status);
        sql.update("contract.updateContractStatus", params);
    }

    @Override
    public void insertContract(ContractInsertDto dto) {
        sql.insert("contract.insertContract", dto);
    }


    
    
    
	
	//사용자 조회 페이지 삭제 조건
	@Override
	public void deletePaymentByMemberId(Long id) {
	    sql.delete("contract.deletePaymentByMemberId", id);
	}

	@Override
	public void deleteReviewByMemberId(Long id) {
	    sql.delete("contract.deleteReviewByMemberId", id);
	}

	@Override
	public void deleteByMemberId(Long id) {
	    sql.delete("contract.deleteByMemberId", id);
	}


}












