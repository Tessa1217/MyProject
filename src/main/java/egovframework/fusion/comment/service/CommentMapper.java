package egovframework.fusion.comment.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.comment.vo.CommentVO;

@Mapper
public interface CommentMapper {
	
	public List<CommentVO> getCommentList(CommentVO commentVO);
	
	public void insComment(CommentVO commentVO);
	
	public CommentVO getComment(CommentVO commentVO);
	
	public void updComment(CommentVO commentVO);
	
	public void delComment(CommentVO commentVO);

}