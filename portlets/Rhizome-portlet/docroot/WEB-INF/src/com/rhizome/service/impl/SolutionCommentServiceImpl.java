package com.rhizome.service.impl;

import com.rhizome.dao.SolutionCommentDAO;
import com.rhizome.domain.SolutionComment;
import com.rhizome.service.SolutionCommentService;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class SolutionCommentServiceImpl extends GenericServiceImpl<SolutionComment, Long> implements SolutionCommentService {

	private SolutionCommentDAO solutionCommentDAO;
	
	@Inject
	public void initSolutionCommentDAOFactory(SolutionCommentDAO solutionCommentDAO) {
		this.solutionCommentDAO = solutionCommentDAO;
		setGenericDAOFactory(solutionCommentDAO);
	}

	@Override
	public List<SolutionComment> getListOfSolutionComment(long solutionId, long parentCommentId) {
		return solutionCommentDAO.getListOfSolutionComment(solutionId,parentCommentId);
	}

	@Override
	public List<SolutionComment> getListOfSolutionReplyComment(long solutionId,long commentId) {
		return solutionCommentDAO.getListOfSolutionReplyComment(solutionId, commentId);
	}

	@Override
	public long getTotalCommentsBySolutionId(long solutionId) {
		return solutionCommentDAO.getTotalCommentsBySolutionId(solutionId);
	}
}
