package com.rhizome.dao;

import com.rhizome.domain.SolutionCommentLike;

public interface SolutionCommentLikeDAO extends GenericDAO<SolutionCommentLike, Long>{

	public long getCurrentCommentLikeCount(long solutionId, long commentId);
	
	public boolean getSolutionCommentLikeStatus(long userId, long solutionId, long commentId);
	
	public void deleteSolutionCommentLike(long userId, long solutionId, long commentId);
	
	public long getTotalSolutionLikeBySolutionId(long solutionId);
}
