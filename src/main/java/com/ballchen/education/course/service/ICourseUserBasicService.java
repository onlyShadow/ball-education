package com.ballchen.education.course.service;

import com.ballchen.education.course.entity.CourseUserBasic;

/**
 * Created by ballchen on 2016/8/15.
 */
public interface ICourseUserBasicService {

    int deleteByPrimaryKey(String id);

    int insert(CourseUserBasic record);

    int insertSelective(CourseUserBasic record);

    CourseUserBasic selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CourseUserBasic record);

    int updateByPrimaryKey(CourseUserBasic record);
}
