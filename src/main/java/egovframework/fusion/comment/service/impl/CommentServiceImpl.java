package egovframework.fusion.comment.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.comment.service.CommentMapper;
import egovframework.fusion.comment.service.CommentService;
import egovframework.fusion.comment.vo.CommentVO;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentMapper commentMapper;

	@Override
	public List<CommentVO> getCommentList(CommentVO commentVO) {
		return commentMapper.getCommentList(commentVO);
	}

	@Override
	public void insComment(CommentVO commentVO) {
		commentMapper.insComment(commentVO);
	}

	@Override
	public CommentVO getComment(CommentVO commentVO) {
		return commentMapper.getComment(commentVO);
	}

	@Override
	public void updComment(CommentVO commentVO) {
		commentMapper.updComment(commentVO);
	}

	@Override
	public void delComment(CommentVO commentVO) {
		commentMapper.delComment(commentVO);
	}

}
