package com.rhizome.dao.impl;

import com.rhizome.dao.C4DCheckListDAO;
import com.rhizome.domain.C4DCheckList;
import com.rhizome.domain.SOPCheckList;

import java.util.List;

import javax.inject.Inject;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class C4DCheckListDAOImpl extends GenericDAOImpl<C4DCheckList, Long> implements C4DCheckListDAO{
	
	@Inject
	public void initSessionFactory(SessionFactory sessionFactory) {
		setSessionFactory(sessionFactory);
	}

	@Override
	public boolean checkC4DMyCheckListExistList(long articleId, long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(C4DCheckList.class);
		criteria.add(Restrictions.eq("c4dArticleId", articleId));
		criteria.add(Restrictions.eq("userId", userId));
		if(criteria.list().isEmpty()){
			return false;
		}else{
			return true;
		}
	}

	@Override
	public C4DCheckList checkC4DMyCheckListExist(long articleId, long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(C4DCheckList.class);
		criteria.add(Restrictions.eq("c4dArticleId", articleId));
		criteria.add(Restrictions.eq("userId", userId));
		return criteria.list().size() > 0 ? (C4DCheckList)criteria.list().get(0) : null;
	}

	@Override
	public List<C4DCheckList> getC4DListForLoggedInUser(long userId) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(C4DCheckList.class);
		criteria.add(Restrictions.eq("userId", userId));
		return criteria.list().size() > 0 ? criteria.list() : null;
	}
}
