package com.comdog.c2d.domain.contract;

import java.util.List;
import java.util.Map;

import com.comdog.c2d.domain.contract.dto.ContractInsertDto;
import com.comdog.c2d.domain.contract.dto.ContractListDto;

public interface ContractService {

	// 계약 목록 조회
	List<ContractListDto> searchContracts(Map<String, String> searchParams);

	// 계약 상태 변경
	void updateContractStatus(Long contractId, String status);

	void insertContract(ContractInsertDto dto); // +추가 : 주문 서비스에서 호출할 용도 

}
