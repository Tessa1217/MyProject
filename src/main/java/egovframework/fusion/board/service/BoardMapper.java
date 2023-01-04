/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.board.vo.BoardFileVO;
import egovframework.fusion.board.vo.BoardHistoryVO;
import egovframework.fusion.board.vo.BoardLikeVO;
import egovframework.fusion.board.vo.BoardTagVO;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Mapper
public interface BoardMapper {

	// 다건 조회 
	public List<BoardVO> getBoardList(@Param("board") BoardVO board, @Param("cri") Criteria cri);
	
	public int getBoardListCnt(@Param("board") BoardVO board, @Param("cri") Criteria cri);

	public List<BoardFileVO> getFileList(BoardFileVO boardFileVo);

	public List<BoardTagVO> getTagList(BoardTagVO boardTagVo);
	
	public List<BoardTagVO> getRecentTagList(@Param("listType") String listType);
	
	public BoardVO getBoardPost(BoardVO boardVo);
	
	// 단건 조회 

	public BoardHistoryVO getBoardHistory(BoardHistoryVO boardHistoryVo);

	public BoardLikeVO getBoardLike(BoardLikeVO boardLikeVo);

	public BoardFileVO getBoardFile(BoardFileVO boardFileVo);
	
	// 삽입

	public void insBoardPost(BoardVO boardVo);

	public void insBoardFile(BoardFileVO boardFileVo);

	public void insBoardHistory(BoardHistoryVO boardHistoryVo);

	public void insBoardTag(BoardTagVO boardTagVo);

	public void insBoardLike(BoardLikeVO boardLikeVo);
	
	public void insBoardTagLog(BoardTagVO boardTagVo);

	// 수정 
	
	public void updBoardCnt(BoardVO boardVo);

	public void updFileDownCnt(BoardFileVO boardFileVo);

	public void updBoardFile(BoardFileVO boardFileVo);

	public void updBoardPost(BoardVO boardVo);
	
	// 삭제

	public void delBoardPost(BoardVO boardVo);

	public void delBoardFile(BoardFileVO boardFileVo);

	public void delBoardTag(BoardTagVO boardTagVo);

	public void delBoardLike(BoardLikeVO boardLikeVo);

}
