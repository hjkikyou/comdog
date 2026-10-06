package com.comdog.c2d.domain.contract;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.comdog.c2d.domain.contract.dto.ContractInsertDto;
import com.comdog.c2d.domain.contract.dto.ContractListDto;

@Service
	public class ContractServiceImpl implements ContractService {
	
	@Autowired
	ContractDao contractDao;
	
	//계약 목록 조회
	@Override
	public List<ContractListDto> searchContracts(Map<String, String> searchParams) {
		return contractDao.searchContracts(searchParams);
	}

	//계약 상태 변경
	@Override
	public void updateContractStatus(Long contractId, String status) {
		contractDao.updateContractStatus(contractId, status);
		
	}
	
	@Override
	public void insertContract(ContractInsertDto dto) {
		contractDao.insertContract(dto);
	}
	
}
