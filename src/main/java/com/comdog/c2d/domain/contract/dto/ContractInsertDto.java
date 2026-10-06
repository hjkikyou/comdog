package com.comdog.c2d.domain.contract.dto;

import java.time.LocalDate;

public class ContractInsertDto {
    private Long memberId;
    private Long orderId;
    private Long productId;
    private Integer monthlyFee;
    private Integer duration;
    private String contractType;
    private String contractStatus;
    private LocalDate startDate;
    private LocalDate endDate;

    public ContractInsertDto() {}

    // Getter & Setter (단축키로 생성)
    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public Integer getMonthlyFee() { return monthlyFee; }
    public void setMonthlyFee(Integer monthlyFee) { this.monthlyFee = monthlyFee; }
    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }
    public String getContractType() { return contractType; }
    public void setContractType(String contractType) { this.contractType = contractType; }
    public String getContractStatus() { return contractStatus; }
    public void setContractStatus(String contractStatus) { this.contractStatus = contractStatus; }
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
}