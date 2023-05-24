package com.wzz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wzz.entity.UserRole;

import java.util.List;

/**
 *
 *  19:49
 */
public interface UserRoleService extends IService<UserRole> {

    String getMenuInfo(Integer roleId);

    List<UserRole> getUserRole();
}
