package com.rhizome.service.impl;

import com.rhizome.dao.SOPCheckListDAO;
import com.rhizome.domain.SOPCheckList;
import com.rhizome.service.SOPCheckListService;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class SOPCheckListServiceImpl extends GenericServiceImpl<SOPCheckList, Long> implements SOPCheckListService{

	private SOPCheckListDAO sopCheckListDAO;
	
	@Inject
	public void initSolutionDAOFactory(SOPCheckListDAO sopCheckListDAO) {
		this.sopCheckListDAO = sopCheckListDAO;
		setGenericDAOFactory(sopCheckListDAO);
	}

	@Override
	public SOPCheckList checkSOPMyCheckListExist(long articleId, long userId) {
		return sopCheckListDAO.checkSOPMyCheckListExist(articleId, userId);
	}

	@Override
	public boolean checkSOPMyCheckListExistList(long articleId, long userId) {
		return sopCheckListDAO.checkSOPMyCheckListExistList(articleId, userId);
	}

	@Override
	public List<SOPCheckList> getSOPListForLoggedInUser(long userId) {
		return sopCheckListDAO.getSOPListForLoggedInUser(userId);
	}
}