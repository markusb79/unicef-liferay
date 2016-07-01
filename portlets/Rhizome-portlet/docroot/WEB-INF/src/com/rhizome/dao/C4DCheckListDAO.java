package com.rhizome.dao;

import com.rhizome.domain.C4DCheckList;

import java.util.List;

public interface C4DCheckListDAO extends GenericDAO<C4DCheckList, Long>{
	
	boolean checkC4DMyCheckListExistList(long articleId, long userId);

	public C4DCheckList checkC4DMyCheckListExist(long articleId, long userId);
	
	public List<C4DCheckList> getC4DListForLoggedInUser(long userId);
}
