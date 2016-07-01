package com.rhizome.dao.impl;

import com.rhizome.dao.SolutionDAO;
import com.rhizome.domain.Solution;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class SolutionDAOImpl extends GenericDAOImpl<Solution, Long> implements SolutionDAO {
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}
	
	@Override
	public List<Solution> getRecentSolution() {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Solution.class);
		String query="select * from solution order by solution_id desc limit 3;";
		return (List<Solution>) session
				.createSQLQuery(query).addEntity(Solution.class)
				.list();
	}

	@Override
	public List<Solution> getRecentSolutionByPageNumber(long start,
			int recordsSize) {
		List<Solution> solutions = null;
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Solution.class);
		criteria.setFirstResult((int) start);
		criteria.setMaxResults(recordsSize);
		solutions = criteria.list();
		return solutions;
	}

	@Override
	public List<Solution> solutionList() {
		Session session = sessionFactory.getCurrentSession();
		  Criteria criteria = session.createCriteria(Solution.class);
		  List<Solution> solutionlist = criteria.list();
		  return solutionlist;
	}
	
	
}
