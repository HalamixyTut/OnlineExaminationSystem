package com.wzz.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 *  11:58
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TokenVo {

    private Integer roleId;

    private String username;

    private String password;

}
