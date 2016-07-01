package com.rhizome.dao.impl;

import com.rhizome.dao.SolutionCommentLikeDAO;
import com.rhizome.domain.SolutionCommentLike;

import javax.inject.Inject;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class SolutionCommentLikeDAOImpl extends GenericDAOImpl<SolutionCommentLike, Long> implements SolutionCommentLikeDAO{
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Override
	public long getCurrentCommentLikeCount(long solutionId, long commentId) {
		Session session = sessionFactory.getCurrentSession();
		String query = "Select count(*) from solution_comment_like where solution_id="
				+ solutionId + " and solution_comment_id=" + commentId;
		return ((Number) session.createSQLQuery(query).uniqueResult())
				.longValue();
	}

	@Override
	public boolean getSolutionCommentLikeStatus(long userId, long solutionId,long commentId) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createSQLQuery("Select solution_comment_like_id from solution_comment_like where user_id="+userId+" and solution_id="+solutionId+" and solution_comment_id="+commentId);
		if(query.list().isEmpty()){
			return false;
		}else{
			return true;	
		}
	}

	@Override
	public void deleteSolutionCommentLike(long userId, long solutionId,long commentId) {
		Session session = sessionFactory.getCurrentSession();
		session.createSQLQuery("delete from solution_comment_like where user_id=" + userId + " and solution_id="+solutionId+" and solution_comment_id="+commentId)
				.executeUpdate();
	}

	@Override
	public long getTotalSolutionLikeBySolutionId(long solutionId) {
		Session session = sessionFactory.getCurrentSession();
		String query = "Select count(solution_comment_like_id) from solution_comment_like where solution_id="
				+ solutionId;
		return ((Number) session.createSQLQuery(query).uniqueResult())
				.longValue();
	}
}
