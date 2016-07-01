package com.rhizome.dao.impl;

import com.rhizome.dao.SocialWorkflowDAO;
import com.rhizome.domain.SocialWorkflow;

import javax.inject.Inject;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class SocialWorkflowDAOImpl extends GenericDAOImpl<SocialWorkflow, Long> implements SocialWorkflowDAO {
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Override
	public SocialWorkflow findWorkflowFromSolutionId(Long solutionId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SocialWorkflow.class);
		criteria.add(Restrictions.eq("solution.solutionId", solutionId));
		return criteria.list().size() > 0 ? (SocialWorkflow)criteria.list().get(0) : null;
	}
}
