package com.java.mapper;

import com.java.pojo.Fund;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Mapper
public interface FundMapper {
    // 增：录入经费记录
    int insertFund(Fund fund);

    // 删：仅删除未审核的记录（需校验关联）
    int deleteUnapprovedFund(@Param("id") Integer id);

    // 改：修改支出金额（需记录修改原因，实际业务中可扩展字段或日志表）
    int updateFundAmount(@Param("id") Integer id,
                         @Param("newAmount") BigDecimal newAmount,
                         @Param("updateTime") Date updateTime);

    // 改：补充凭证说明
    int updateProofDesc(@Param("id") Integer id,
                        @Param("newProofDesc") String newProofDesc,
                        @Param("updateTime") Date updateTime);

    // 查：按条件统计经费（社团ID、时间范围、类型）
    List<Fund> selectFundByCondition(@Param("clubId") Integer clubId,
                                     @Param("startTime") Date startTime,
                                     @Param("endTime") Date endTime,
                                     @Param("type") Integer type);

    // 查：查询单条经费的操作人、凭证信息
    Fund selectFundDetail(@Param("id") Integer id);

    List<Fund> selectAllFunds();
}