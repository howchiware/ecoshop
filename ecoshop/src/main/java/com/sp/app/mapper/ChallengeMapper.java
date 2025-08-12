package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Challenge;

@Mapper
public interface ChallengeMapper {
	public Long challengeSeq() throws SQLException;
    
    public int insertChallenge(Challenge dto) throws SQLException;
    public int insertDailyChallenge(Challenge dto) throws SQLException;
    public int insertSpecialChallenge(Challenge dto) throws SQLException;
    
    public Challenge findById(long challengeId) throws SQLException;
    public Challenge findDailyById(long challengeId) throws SQLException;
    public Challenge findSpecialById(long challengeId) throws SQLException;
    
    public int dataCount(Map<String, Object> map) throws SQLException;
    public List<Challenge> listChallenge(Map<String, Object> map) throws SQLException;
    
    public int updateChallenge(Challenge dto) throws SQLException;
    public int deleteChallenge(long challengeId) throws SQLException;
    
}
