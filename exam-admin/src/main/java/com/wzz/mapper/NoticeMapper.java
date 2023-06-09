package com.wzz.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wzz.entity.Notice;
import org.springframework.stereotype.Repository;

/**
 *
 *  8:59
 */
@Repository
public interface NoticeMapper extends BaseMapper<Notice> {

    // 将所有公告设置为历史公告
    boolean setAllNoticeIsHistoryNotice();

}
