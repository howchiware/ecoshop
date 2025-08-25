package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Point;



@Mapper
public interface PointMapper {
	
	 // 포인트 등록
    public int insertPoint(Point dto) throws SQLException;

    // 회원의 가장 최근 포인트 1건 (잔액용)
    public Point findRecentPoint(Long memberId);

    // 회원의 전체 포인트 이력
    public List<Point> listMemberPoints(Long memberId);
	
}
