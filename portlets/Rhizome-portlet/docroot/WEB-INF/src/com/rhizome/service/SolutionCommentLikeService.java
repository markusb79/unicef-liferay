package com.rhizome.service;

import com.rhizome.domain.SolutionCommentLike;

public interface SolutionCommentLikeService extends GenericService<SolutionCommentLike, Long>{

	public long getCurrentCommentLikeCount(long solutionId, long commentId);
	
	boolean getSolutionCommentLikeStatus(long userId, long solutionId, long commentId);
	
	public void deleteSolutionCommentLike(long userId, long solutionId, long commentId);
	
	public long getTotalSolutionLikeBySolutionId(long solutionId);
}
