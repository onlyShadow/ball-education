package com.ballchen.education.course.dao;

import com.ballchen.education.course.entity.CourseUserBasic;

public interface ICourseUserBasicDAO {
    int deleteByPrimaryKey(String id);

    int insert(CourseUserBasic record);

    int insertSelective(CourseUserBasic record);

    CourseUserBasic selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(CourseUserBasic record);

    int updateByPrimaryKey(CourseUserBasic record);
}