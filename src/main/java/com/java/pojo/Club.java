package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Club {
    private Integer id;
    private String name;
    private String category;
    private String intro;
    private Integer founderId;
    private Integer status; // 1-正常，2-解散
    private Date createTime;
    private String coverUrl;



}
