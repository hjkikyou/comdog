package com.comdog.c2d.domain.contract;

import java.util.List;
import java.util.Map;

import com.comdog.c2d.domain.contract.dto.ContractInsertDto;
import com.comdog.c2d.domain.contract.dto.ContractListDto;

public interface ContractDao {

	//계약 목록 조회
	List<ContractListDto> searchContracts(Map<String, String> searchParams);

	//계약 상태 변경
	void updateContractStatus(Long contractId, String status);

	void insertContract(ContractInsertDto dto);
	
	// 사용자 조회 페이지 삭제 조건
	void deletePaymentByMemberId(Long id);
	void deleteReviewByMemberId(Long id);
	void deleteByMemberId(Long id);
}
