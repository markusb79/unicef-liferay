package com.rhizome.service.impl;

import com.rhizome.dao.SolutionCommentLikeDAO;
import com.rhizome.domain.SolutionCommentLike;
import com.rhizome.service.SolutionCommentLikeService;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class SolutionCommentLikeServiceImpl extends GenericServiceImpl<SolutionCommentLike, Long> implements SolutionCommentLikeService{
	
	private SolutionCommentLikeDAO solutionCommentLikeDAO;
	
	@Inject
	public void initSolutionCommentLikeDAOFactory(SolutionCommentLikeDAO solutionCommentLikeDAO) {
		this.solutionCommentLikeDAO = solutionCommentLikeDAO;
		setGenericDAOFactory(solutionCommentLikeDAO);
	}

	@Override
	public long getCurrentCommentLikeCount(long solutionId, long commentId) {
		return solutionCommentLikeDAO.getCurrentCommentLikeCount(solutionId, commentId);
	}

	@Override
	public boolean getSolutionCommentLikeStatus(long userId, long solutionId,long commentId) {
		return solutionCommentLikeDAO.getSolutionCommentLikeStatus(userId, solutionId, commentId);
	}

	@Override
	public void deleteSolutionCommentLike(long userId, long solutionId,long commentId) {
		solutionCommentLikeDAO.deleteSolutionCommentLike(userId, solutionId, commentId);
		
	}

	@Override
	public long getTotalSolutionLikeBySolutionId(long solutionId) {
		return solutionCommentLikeDAO.getTotalSolutionLikeBySolutionId(solutionId);
	}
	
}
