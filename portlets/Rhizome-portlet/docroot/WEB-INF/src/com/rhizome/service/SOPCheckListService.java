package com.rhizome.service;

import com.rhizome.domain.SOPCheckList;

import java.util.List;

public interface SOPCheckListService extends GenericService<SOPCheckList, Long>{

	public SOPCheckList checkSOPMyCheckListExist(long articleId, long userId);
	
	boolean checkSOPMyCheckListExistList(long articleId, long userId);
	
	public List<SOPCheckList> getSOPListForLoggedInUser(long userId);
}
