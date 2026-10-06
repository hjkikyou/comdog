package com.comdog.c2d.domain.member.dto;

import java.time.LocalDateTime;

public class MemberDto {

    private Long id;              // 사용자 고유번호
    private String email;         // 이메일 (로그인 ID)
    private String password;      // 비밀번호
    private String name;          // 사용자 실명
    private String phone;         // 연락처
    private String birthDate;     // 생년월일 6자리 (예: 990101)
    private String genderDigit;   // 주민번호 성별 앞자리 1자리 (1~4)
    private String userType;      // 회원 구분 ('PERSONAL', 'BUSINESS')
    private Boolean isSubscribed; // 프로모션 수신 동의 (0: false, 1: true)
    private LocalDateTime createdAt; // 가입일

    // ── Getters & Setters ──

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getBirthDate() { return birthDate; }
    public void setBirthDate(String birthDate) { this.birthDate = birthDate; }

    public String getGenderDigit() { return genderDigit; }
    public void setGenderDigit(String genderDigit) { this.genderDigit = genderDigit; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public Boolean getIsSubscribed() { return isSubscribed; }
    public void setIsSubscribed(Boolean isSubscribed) { this.isSubscribed = isSubscribed; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
