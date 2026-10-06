package com.comdog.c2d.domain.contract.dto;

import java.time.LocalDate;

//ContractListDto.java (화면 출력용) 

public class ContractListDto {
	private Long contractId;
	private Long memberId;
	private Long orderId;
	private Long productId;
	private Integer monthlyFee;
	private Integer duration;
	private String contractType;
	private String contractStatus;
	private LocalDate startDate;
	private LocalDate endDate;
	
	// 1. 기본 생성자 (MyBatis가 결과를 매핑할 때 반드시 필요합니다)
    public ContractListDto() {
    }

    // 2. 전체 필드 생성자 (필요시 사용)
    public ContractListDto(Long contractId, Long memberId, Long orderId, Long productId, 
                       Integer monthlyFee, Integer duration, String contractType, 
                       String contractStatus, LocalDate startDate, LocalDate endDate) {
        this.contractId = contractId;
        this.memberId = memberId;
        this.orderId = orderId;
        this.productId = productId;
        this.monthlyFee = monthlyFee;
        this.duration = duration;
        this.contractType = contractType;
        this.contractStatus = contractStatus;
        this.startDate = startDate;
        this.endDate = endDate;
    }

	public Long getContractId() {
		return contractId;
	}

	public void setContractId(Long contractId) {
		this.contractId = contractId;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Integer getMonthlyFee() {
		return monthlyFee;
	}

	public void setMonthlyFee(Integer monthlyFee) {
		this.monthlyFee = monthlyFee;
	}

	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public String getContractType() {
		return contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	public String getContractStatus() {
		return contractStatus;
	}

	public void setContractStatus(String contractStatus) {
		this.contractStatus = contractStatus;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
  
}


