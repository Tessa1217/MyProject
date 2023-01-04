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

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.board.vo.BoardFileVO;
import egovframework.fusion.board.vo.BoardHistoryVO;
import egovframework.fusion.board.vo.BoardLikeVO;
import egovframework.fusion.board.vo.BoardTagVO;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.cmmn.vo.Criteria;

@Service
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);

	@Autowired
	BoardMapper boardMapper;

	@Override
	public List<BoardVO> getBoardList(BoardVO board, Criteria cri) {
		return boardMapper.getBoardList(board, cri);
	}

	@Override
	public int getBoardListCnt(BoardVO board, Criteria cri) {
		return boardMapper.getBoardListCnt(board, cri);
	}

	@Override
	public List<BoardTagVO> getRecentTagList(String listType) {
		return boardMapper.getRecentTagList(listType);
	}

	@Override
	public List<BoardFileVO> getFileList(BoardFileVO boardFileVo) {
		return boardMapper.getFileList(boardFileVo);
	}

	@Override
	public List<BoardTagVO> getTagList(BoardTagVO boardTagVo) {
		return boardMapper.getTagList(boardTagVo);
	}

	@Override
	public BoardVO getBoardPost(BoardVO boardVo) {
		boardVo = boardMapper.getBoardPost(boardVo);
		if (boardVo == null) {
			return new BoardVO();
		}
		BoardFileVO boardFileVo = new BoardFileVO();
		boardFileVo.setBoardNo(boardVo.getBoardNo());
		List<BoardFileVO> fileList = boardMapper.getFileList(boardFileVo);
		if (fileList != null) {
			boardVo.setBoardFiles(boardMapper.getFileList(boardFileVo));
		}

		BoardTagVO boardTagVo = new BoardTagVO();
		boardTagVo.setBoardNo(boardVo.getBoardNo());
		List<BoardTagVO> tagList = boardMapper.getTagList(boardTagVo);
		if (tagList != null) {
			boardVo.setBoardTags(boardMapper.getTagList(boardTagVo));
		}
		return boardVo;
	}

	@Override
	public BoardFileVO getBoardFile(BoardFileVO boardFileVo) {
		return boardMapper.getBoardFile(boardFileVo);
	}

	@Override
	public BoardHistoryVO getBoardHistory(BoardHistoryVO boardHistoryVo) {
		return boardMapper.getBoardHistory(boardHistoryVo);
	}

	@Override
	public BoardLikeVO getBoardLike(BoardLikeVO boardLikeVo) {
		return boardMapper.getBoardLike(boardLikeVo);
	}

	@Override
	public void insBoardPost(BoardVO boardVo) {
		boardMapper.insBoardPost(boardVo);
	}

	@Override
	public void insBoardFile(BoardFileVO boardFileVo) {
		boardMapper.insBoardFile(boardFileVo);
	}

	@Override
	public void insBoardTag(BoardTagVO boardTagVo) {
		boardMapper.insBoardTag(boardTagVo);
	}

	@Override
	public void insBoardHistory(BoardHistoryVO boardHistoryVo) {
		boardMapper.insBoardHistory(boardHistoryVo);
	}

	@Override
	public void insBoardLike(BoardLikeVO boardLikeVo) {
		boardMapper.insBoardLike(boardLikeVo);
	}

	@Override
	public void insBoardTagLog(BoardTagVO boardTagVo) {
		boardMapper.insBoardTagLog(boardTagVo);
	}

	@Override
	public void updBoardCnt(BoardVO boardVo) {
		boardMapper.updBoardCnt(boardVo);
	}

	@Override
	public void updBoardPost(BoardVO boardVo) {
		boardMapper.updBoardPost(boardVo);
	}

	@Override
	public void updFileDownCnt(BoardFileVO boardFileVo) {
		boardMapper.updFileDownCnt(boardFileVo);
	}

	@Override
	public void updBoardFile(BoardFileVO boardFileVo) {
		boardMapper.updBoardFile(boardFileVo);
	}

	@Override
	public void delBoardFile(BoardFileVO boardFileVo) {
		boardMapper.delBoardFile(boardFileVo);
	}

	@Override
	public void delBoardLike(BoardLikeVO boardLikeVo) {
		boardMapper.delBoardLike(boardLikeVo);
	}

	@Override
	public void delBoardTag(BoardTagVO boardTagVo) {
		boardMapper.delBoardTag(boardTagVo);
	}

	@Override
	public void delBoardPost(BoardVO boardVo) {
		boardMapper.delBoardPost(boardVo);
	}


}
