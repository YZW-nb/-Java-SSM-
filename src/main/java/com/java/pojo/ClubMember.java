package com.java.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClubMember {
    private Integer id;
    private Integer clubId;
    private Integer userId;
    private Date joinTime;

    // 用于新增关联的构造
    public ClubMember(Integer clubId, Integer userId) {
        this.clubId = clubId;
        this.userId = userId;
    }
}
