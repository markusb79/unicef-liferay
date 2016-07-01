package com.rhizome.dao.impl;

import com.rhizome.dao.SOPCheckListDAO;
import com.rhizome.domain.SOPCheckList;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class SOPCheckListDAOImpl extends GenericDAOImpl<SOPCheckList, Long> implements SOPCheckListDAO{
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Override
	public SOPCheckList checkSOPMyCheckListExist(long articleId, long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SOPCheckList.class);
		criteria.add(Restrictions.eq("sopArticleId", articleId));
		criteria.add(Restrictions.eq("userId", userId));
		return criteria.list().size() > 0 ? (SOPCheckList)criteria.list().get(0) : null;
		
	}

	@Override
	public boolean checkSOPMyCheckListExistList(long articleId, long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SOPCheckList.class);
		criteria.add(Restrictions.eq("sopArticleId", articleId));
		criteria.add(Restrictions.eq("userId", userId));
		if(criteria.list().isEmpty()){
			return false;
		}else{
			return true;
		}
	}

	@Override
	public List<SOPCheckList> getSOPListForLoggedInUser(long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(SOPCheckList.class);
		criteria.add(Restrictions.eq("userId", userId));
		return criteria.list().size() > 0 ? criteria.list() : null;
	}
	
}
