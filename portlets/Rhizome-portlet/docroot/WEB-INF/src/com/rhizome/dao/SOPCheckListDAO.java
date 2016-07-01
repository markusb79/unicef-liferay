package com.rhizome.dao;

import com.rhizome.domain.SOPCheckList;

import java.util.List;

public interface SOPCheckListDAO extends GenericDAO<SOPCheckList, Long>{
	
	public SOPCheckList checkSOPMyCheckListExist(long articleId, long userId);
	
	boolean checkSOPMyCheckListExistList(long articleId, long userId);
	
	public List<SOPCheckList> getSOPListForLoggedInUser(long userId);
}
