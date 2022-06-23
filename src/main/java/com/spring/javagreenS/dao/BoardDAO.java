package com.spring.javagreenS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS.vo.BoardVO;

public interface BoardDAO {

	public int totRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setBoardInput(@Param("vo") BoardVO vo);

	public void setReadNum(@Param("idx") int idx);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public int totSearchRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public List<BoardVO> getBoardSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<BoardVO> getPreNext(@Param("idx") int idx);

	public int getMinIdx();
	
}
