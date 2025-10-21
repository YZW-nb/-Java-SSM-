package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClubApply {
    private Integer id;         //申请ID
    private Integer clubId;     //社团ID
    private Integer userId;     //申请人ID
    private String reason;      //申请理由
    private String status;      //状态：pending(待审核)/approved(通过)/rejected(拒绝)
    private Date applyTime;     //申请时间
    private Date reviewTime;    //审核时间

    //用于新的申请
    public ClubApply(Integer clubId, Integer userId, String reason){
        this.clubId = clubId;
        this.userId = userId;
        this.reason = reason;
    }


}
