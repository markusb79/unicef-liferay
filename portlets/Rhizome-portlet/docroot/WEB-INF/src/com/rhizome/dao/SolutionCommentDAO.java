package com.rhizome.dao;

import com.rhizome.domain.SolutionComment;

import java.util.List;

public interface SolutionCommentDAO extends GenericDAO<SolutionComment, Long>  {

	List<SolutionComment> getListOfSolutionComment(long solutionId, long parentCommentId);

	List<SolutionComment> getListOfSolutionReplyComment(long solutionId, long commentId);
	
	public long getTotalCommentsBySolutionId(long solutionId);
}
