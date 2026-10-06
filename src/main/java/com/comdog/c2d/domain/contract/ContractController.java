package com.comdog.c2d.domain.contract;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.comdog.c2d.domain.contract.dto.ContractListDto;


@Controller
@RequestMapping("/admin/contract")
public class ContractController {
	
	@Autowired 
	ContractService service;
	
	//계약 목록 조회
	@GetMapping("/list")
	public String getContractListPage(Model model,
		@RequestParam(value = "search", required = false) String search,
		@RequestParam(value = "keyword", required = false) String keyword) {
	
	Map<String, String> searchParams = new HashMap<>();
		searchParams.put("search", search);
		searchParams.put("keyword", keyword);
	
	List<ContractListDto> contractList = service.searchContracts(searchParams);
	
	model.addAttribute("viewContractList", contractList);
	
	return "admin/contract/list";
	
	}
	
	//계약 상태 변경 (목록 화면에서 버튼 클릭 시 작동)
	@PostMapping("/updateStatus")
	public String updateContractStatus(
			@RequestParam("contractId") Long contractId,
			@RequestParam("status") String status) {
		service.updateContractStatus(contractId, status);
		
		return "redirect:/admin/contract/list";
	}
	
	
}
