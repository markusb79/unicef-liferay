package com.rhizome.service.impl;

import com.rhizome.dao.C4DCheckListDAO;
import com.rhizome.domain.C4DCheckList;
import com.rhizome.service.C4DCheckListService;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class C4DCheckListServiceImpl extends GenericServiceImpl<C4DCheckList, Long> implements C4DCheckListService{

	private C4DCheckListDAO c4dCheckListDAO;
	
	@Inject
	public void initSolutionDAOFactory(C4DCheckListDAO c4dCheckListDAO) {
		this.c4dCheckListDAO = c4dCheckListDAO;
		setGenericDAOFactory(c4dCheckListDAO);
	}

	@Override
	public boolean checkC4DMyCheckListExistList(long articleId, long userId) {
		return c4dCheckListDAO.checkC4DMyCheckListExistList(articleId, userId);
	}

	@Override
	public C4DCheckList checkC4DMyCheckListExist(long articleId, long userId) {
		return c4dCheckListDAO.checkC4DMyCheckListExist(articleId, userId);
	}

	@Override
	public List<C4DCheckList> getC4DListForLoggedInUser(long userId) {
		return c4dCheckListDAO.getC4DListForLoggedInUser(userId);
	}

	
}