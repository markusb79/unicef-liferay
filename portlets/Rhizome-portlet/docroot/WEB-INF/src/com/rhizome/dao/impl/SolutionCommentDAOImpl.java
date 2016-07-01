package com.rhizome.dao.impl;

import com.rhizome.dao.SolutionCommentDAO;
import com.rhizome.domain.SolutionComment;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class SolutionCommentDAOImpl extends GenericDAOImpl<SolutionComment, Long> implements SolutionCommentDAO{
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Override
	public List<SolutionComment> getListOfSolutionComment(long solutionId, long parentCommentId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SolutionComment.class);
		criteria.add(Restrictions.eq("solution.solutionId", solutionId));
		criteria.add(Restrictions.eq("parentCommentId", parentCommentId));
		criteria.addOrder(Order.desc("createdDate"));
		return criteria.list();
	}

	@Override
	public List<SolutionComment> getListOfSolutionReplyComment(long solutionId, long commentId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SolutionComment.class);
		criteria.add(Restrictions.eq("solution.solutionId", solutionId));
		criteria.add(Restrictions.eq("parentCommentId", commentId));
		criteria.addOrder(Order.desc("createdDate"));
		return criteria.list();
	}

	@Override
	public long getTotalCommentsBySolutionId(long solutionId) {
		Session session = sessionFactory.getCurrentSession();
		String query = "Select count(solution_comment_id) from solution_comment where solution_id="
				+ solutionId;
		return ((Number) session.createSQLQuery(query).uniqueResult())
				.longValue();
	}
}
