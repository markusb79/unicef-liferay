package com.rhizome.service.impl;

import com.rhizome.dao.SolutionDAO;
import com.rhizome.domain.Solution;
import com.rhizome.service.SolutionService;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class SolutionServiceImpl extends GenericServiceImpl<Solution, Long> implements SolutionService{
	
	private SolutionDAO solutionDAO;
	
	@Inject
	public void initSolutionDAOFactory(SolutionDAO solutionDAO) {
		this.solutionDAO = solutionDAO;
		setGenericDAOFactory(solutionDAO);
	}
	
	@Override
	public List<Solution> getRecentSolution() {
		return solutionDAO.getRecentSolution();
	}

	@Override
	public List<Solution> getRecentSolutionByPageNumber(long start,
			int recordsSize) {
		return solutionDAO.getRecentSolutionByPageNumber(start,recordsSize);
	}
	
	@Override
	 public List<Solution> solutionList() {
	  return solutionDAO.solutionList();
	 }

}
